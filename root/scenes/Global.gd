extends Node

var screens_unlockes: int = 1
var save_pos = Vector2.ZERO
var current_screen = 1
	
func save_game(pos, screen):
	save_pos = pos
	current_screen = screen
	var save_dict = {
		"pos_x" : save_pos.x,
		"pos_y" : save_pos.y,
		"screen" : current_screen
	}
	var save_game = File.new()
	save_game.open("user://shibapos.save", File.WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://shibapos.save"):
		return
	
	save_game.open("user://savegame.save", File.READ)
	var data = parse_json(save_game.get_line())
	if data != null:
		save_pos.x = data["pos_x"]
		save_pos.y = data["pos_y"]
		current_screen = data["screen"]
