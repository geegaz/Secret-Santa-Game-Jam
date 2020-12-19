extends Node2D

signal lose
signal advance

func _on_DeathZone_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("lose")


func _on_AdvanceZone_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("advance")
