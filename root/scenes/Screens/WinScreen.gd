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

func _on_Continue_pressed():
	emit_signal("goto_scene", "menu")

func _on_Terrain_win():
	appear()
