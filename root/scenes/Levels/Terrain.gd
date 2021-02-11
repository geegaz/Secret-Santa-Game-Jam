extends Node2D

export var screens: int = 1
var current_screen: int = 1

signal advance
signal lose
signal win

onready var _Shiba = $Shibastronaut

func _ready():
	if Global.save_pos != Vector2.ZERO:
		_Shiba.position = Global.save_pos
	if Global.current_screen != current_screen:
		current_screen = Global.current_screen
	
func _on_WinGoal_advance():
	if current_screen == screens:
		emit_signal("win")
		
	else:
		emit_signal("advance")
		
		Global.save_game(_Shiba.position, current_screen)
		current_screen += 1

func _on_Hazard_touch():
	emit_signal("lose")

func _on_Game_shiba_start():
	_Shiba.start()

func _on_Game_shiba_stop():
	_Shiba.stop()
