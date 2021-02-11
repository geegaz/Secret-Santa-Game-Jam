extends Control

signal goto_scene(scene_path)

func _ready():
	hide()

func appear():
	self.visible = true
	
	var tween = $Tween
	tween.interpolate_property(
		self, "modulate:a",
		self.modulate.a, 1.0,
		0.5
	)
	if !tween.is_active():
		tween.start()

func disappear():
	var tween = $Tween
	tween.interpolate_property(
		self, "modulate:a",
		self.modulate.a, 0.0,
		0.2
	)
	if !tween.is_active():
		tween.start()

func _on_Restart_pressed():
	emit_signal("goto_scene", "")

func _on_BackToMenu_pressed():
	emit_signal("goto_scene", "menu")

func _on_TerrainWalls_lose():
	appear()
