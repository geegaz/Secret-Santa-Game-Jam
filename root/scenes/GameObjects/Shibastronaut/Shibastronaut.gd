extends KinematicBody2D

signal bounce_on(node)

export var GRAVITY_STRONG: float = 1200
export var GRAVITY_WEAK: float = 120
export var MAX_FALL_SPEED: float = 1200
export var BASE_BOUNCE: float = 400

var process: bool = false
var timescale: float = 1.0
var velocity: Vector2 = Vector2.ZERO

var rotation_speed = 0.0 # deg/s
var shader_rotation = 0.0
var shader_grow = Vector2.ZERO 
onready var shader_material = $Shiba_body.material
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	shader_rotation = wrapf(shader_rotation + rotation_speed * delta, 0.0, 360.0)
	shader_material.set_shader_param("rotate", shader_rotation)
	shader_material.set_shader_param("grow", shader_grow)
	
func _physics_process(delta):
	if process:
		move(delta)

func move(delta):
	if velocity.y < MAX_FALL_SPEED:
		velocity.y += lerp(GRAVITY_WEAK, GRAVITY_STRONG, abs(velocity.y)/MAX_FALL_SPEED)*delta
	
	if velocity.y <= 0.0:
		self.set_collision_mask_bit(1, false)
	else:
		self.set_collision_mask_bit(1, true)
	
	var collision = move_and_collide(velocity*delta*timescale)
	if collision:
		var groups = collision.collider.get_groups()
		if groups.size() > 0:
			match groups[0]:
				"Bounce":
					emit_signal("bounce_on", collision.collider)

					velocity = velocity.bounce(collision.normal)

					var bounce_coef = collision.collider.get("bounce_coef")
					velocity.y = -BASE_BOUNCE * bounce_coef
					#velocity.x *= 0.5
					
					$BounceSound.play()
					
					randomize()
					rotation_speed = randf() * 100.0 + 100.0
					if collision.normal.dot(Vector2.LEFT) > 0:
						rotation_speed = -rotation_speed
						
					var tween = $Tween
					tween.interpolate_property(
						self, "shader_grow",
						Vector2(-0.3,0.4),Vector2.ZERO,
						0.2
					)
					if !tween.is_active():
						tween.start()
						
				"Wall":
					velocity = velocity.bounce(collision.normal)
					velocity.x *= 0.9
				_:
					velocity = velocity.slide(collision.normal)
		else:
			velocity = velocity.slide(collision.normal)

func start():
	process = true

func stop():
	velocity = Vector2.ZERO
	process = false
