extends Node2D

signal start

var playing: bool = false

var line_scene = preload("res://scenes/BounceRope/BounceRope.tscn")
var start_drag_pos: Vector2
var end_drag_pos: Vector2
var temp_line
var min_pressed_time = 0.2 #s
var min_drag_distance = 0.2
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.



func _on_TouchController_dragged(pos, relative, pressed_time):
	if temp_line:
		temp_line.drag(pos - start_drag_pos)

func _on_TouchController_start_pressing(pos):
	start_drag_pos = pos
	if temp_line:
		pass
	else:
		temp_line = line_scene.instance()
		add_child(temp_line)
		temp_line.start(pos)

func _on_TouchController_stop_pressing(pos, pressed_time):
	end_drag_pos = pos
	if temp_line:
		temp_line.end(end_drag_pos-start_drag_pos)
		temp_line = null
		
		emit_signal("start")
