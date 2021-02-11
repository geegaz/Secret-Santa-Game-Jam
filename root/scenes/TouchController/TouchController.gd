extends ReferenceRect

signal start_pressing(pos)
signal stop_pressing(pos, pressed_time)
signal dragged(pos, relative, pressed_time)

var pressed: bool = false
var pressed_time: float = 0.0

onready var _Rect = $Rect
onready var limits = _Rect.get_rect()

func _physics_process(delta):
	if pressed:
		pressed_time += delta

func _input(event):
	var clamped_pos = Vector2()
	clamped_pos.x = clamp(event.position.x, limits.position.x, limits.end.x)
	clamped_pos.y = clamp(event.position.y, limits.position.y, limits.end.y)
	if event is InputEventScreenTouch:
		pressed = event.is_pressed()
		if pressed:
			pressed_time = 0.0
			emit_signal("start_pressing", clamped_pos)
		else:
			emit_signal("stop_pressing", clamped_pos, pressed_time)
	
	if event is InputEventScreenDrag:
		emit_signal("dragged", clamped_pos, event.relative, pressed_time)
