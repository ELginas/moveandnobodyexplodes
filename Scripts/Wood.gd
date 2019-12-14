extends Sprite

var mouse_entered = false


func _on_StaticBody2D_mouse_entered():
	mouse_entered = true


func _on_StaticBody2D_mouse_exited():
	mouse_entered = false


func _process(delta):
	if Input.is_action_just_pressed("interact_block"):
		if mouse_entered:
			queue_free()
