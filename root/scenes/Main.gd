extends Node

onready var _Menu = $Menu
onready var _Credits = $Credits

onready var _Continue = $Menu/VBoxContainer/CenterContainer2/VBoxContainer/Continue
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_game()
	_Continue.disabled = (Global.current_screen == 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	Global.save_pos = Vector2.ZERO
	Global.current_screen = 1
	get_tree().change_scene("res://scenes/TestScene.tscn")


func _on_Credits_pressed():
	_Menu.hide()
	_Credits.show()


func _on_Back_pressed():
	_Menu.show()
	_Credits.hide()

func _on_Continue_pressed():
	get_tree().change_scene("res://scenes/TestScene.tscn")
