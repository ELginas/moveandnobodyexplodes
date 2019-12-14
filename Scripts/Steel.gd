extends KinematicBody2D

var mouse_entered = false
var dragging = false

var start_offset = Vector2()


func _process(delta):
	if Input.is_action_just_pressed("interact_block"):
		start_offset = get_global_mouse_position() - position
	if Input.is_action_pressed("interact_block"):
		if mouse_entered:
			dragging = true
	elif dragging:
		dragging = false


func _physics_process(delta):
	if dragging:
		var new_pos = get_global_mouse_position() - start_offset
		var direction = new_pos - position
		#position = get_global_mouse_position() - start_offset
		move_and_slide(direction*10)


func _on_Steel_mouse_entered():
	mouse_entered = true


func _on_Steel_mouse_exited():
	mouse_entered = false
