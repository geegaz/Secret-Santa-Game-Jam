extends Node2D

signal shiba_start
signal shiba_stop
signal lose
signal win

export var terrain_path: NodePath
onready var _Terrain = get_node(terrain_path)
onready var _UI = $UI

var playing: bool = false

var line_scene = preload("res://scenes/BounceRope/BounceRope.tscn")
var start_drag_pos: Vector2
var end_drag_pos: Vector2
var min_drag_distance = 5 #pixels
var temp_line

var screens: int = 1
var current_screen: int = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	_UI.setup_charges(8)
		

func _on_TouchController_dragged(pos, relative, pressed_time):
	if temp_line:
		temp_line.drag((pos+self.position) - start_drag_pos)

func _on_TouchController_start_pressing(pos):
	start_drag_pos = (pos+self.position)
	if temp_line:
		pass
	elif _UI.charges_left > 0:
		temp_line = line_scene.instance()
		add_child(temp_line)
		temp_line.start(start_drag_pos)

func _on_TouchController_stop_pressing(pos, pressed_time):
	end_drag_pos = (pos+self.position)
	if temp_line and (end_drag_pos-start_drag_pos).length() > min_drag_distance:
		temp_line.end(end_drag_pos-start_drag_pos)
		temp_line = null
		_UI.use_charge()
		
		emit_signal("shiba_start")
		
	elif temp_line:
		temp_line.queue_free()


func _on_TerrainWalls_advance():
	emit_signal("shiba_stop")
	
	if current_screen == screens:
		emit_signal("win")
		
	else:
		for line in get_tree().get_nodes_in_group("Bounce"):
			line.queue_free()
		
		var tween = $Tween
		tween.interpolate_property(
			_Terrain, "position:y",
			_Terrain.position.y, _Terrain.position.y + 512,
			1.0
		)
		if !tween.is_active():
			tween.start()
		
		current_screen += 1
		_UI.reload_charges()

func _on_TerrainWalls_lose():
	emit_signal("lose")

func goto_scene(scene_path):
	match scene_path:
		"menu":
			pass
		_:
			get_tree().reload_current_scene()
