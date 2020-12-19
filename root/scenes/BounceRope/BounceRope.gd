extends KinematicBody2D

export var min_length: float = 10
export var max_length: float = 500
export var min_coef: float = 0.5
export var max_coef: float = 1.5

var bounce_coef: float = 1.0
var shader_displacement = Vector2.ZERO

onready var _Line = $Line2D
onready var _Shape = $CollisionShape2D

func _process(delta):
	_Line.material.set_shader_param("displacement", shader_displacement)

func _on_Shibastronaut_bounce_on(node):
	if node == self:
		$CollisionShape2D.set_deferred("disabled", true)
		var tween = $Tween
		tween.interpolate_property(
			self,"shader_displacement",
			Vector2(0.0, 10.0), Vector2.ZERO,
			0.2
		)
		tween.interpolate_property(
			_Line,"modulate:a",
			1.0, 0.0,
			0.5
		)
		if !tween.is_active():
			tween.start()
		$Timer.start()

func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		player.connect("bounce_on", self,"_on_Shibastronaut_bounce_on")

func start(pos: Vector2):
	self.position = pos
	_Shape.set_deferred("disabled", true)
	_Shape.shape = SegmentShape2D.new()
	_Line.modulate.a = 0.5

func drag(pos: Vector2):
	_Line.points[1] = pos
	_Shape.shape.b = pos

func end(pos: Vector2):
	_Line.points[1] = pos
	_Shape.shape.b = pos
	
	bounce_coef = calculate_bounce_coef(pos.length())
	
	_Shape.set_deferred("disabled", false)
	_Line.modulate.a = 1.0
	
func calculate_bounce_coef(length: float) -> float:
	var base = 1.0 - clamp(length/(max_length - min_length), 0, 1)
	return lerp(min_coef, max_coef, base)

func _on_Timer_timeout():
	queue_free()
