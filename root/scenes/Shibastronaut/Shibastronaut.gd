extends KinematicBody2D

signal bounce_on(node)
signal hit_hazard(node)

export var GRAVITY_STRONG: float = 1200
export var GRAVITY_WEAK: float = 120
export var MAX_FALL_SPEED: float = 1200
export var BASE_BOUNCE: float = 500

var process: bool = false
var timescale: float = 1.0
var velocity: Vector2 = Vector2.ZERO
var rotating: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		if collision.collider.is_in_group("Bounce"):
			emit_signal("bounce_on", collision.collider)
			
			velocity = velocity.bounce(collision.normal)
			
			var bounce_coef = collision.collider.get("bounce_coef")
			velocity.y = -BASE_BOUNCE * bounce_coef
			velocity.x *= 0.5
		elif collision.collider.is_in_group("Hazard"):
			emit_signal("hit_hazard", collision.collider)
			
			$CollisionShape2D.set_deferred("disabled", true)
		else:
			velocity = velocity.slide(collision.normal)


func _on_Game_start():
	if !process:
		process = true
