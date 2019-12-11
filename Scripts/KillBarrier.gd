extends Area2D

func _on_KillBarrier_body_entered(body):
	if body.is_in_group("Player"):
		body.reset_pos()