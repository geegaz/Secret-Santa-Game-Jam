extends Area2D

signal advance

func _on_WinGoal_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("advance")
		
		$CollisionShape2D.set_deferred("disabled", true)
		
		var tween = $Tween
		tween.interpolate_property(
			$Sprite, "modulate:a",
			1.0, 0.0,
			0.8
		)
		if !tween.is_active():
			tween.start()
		
		$Timer.start()
		yield(get_tree().create_timer(.5), "timeout")
		queue_free()
