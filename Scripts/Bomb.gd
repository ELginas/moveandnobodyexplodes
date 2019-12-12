extends Node2D

const defuse_time = 5

var mouse_entered = false
var player_nearby = false
var defusing = false
var defused = false

var current_defuse_time = 0


func _ready():
	add_to_group("Bomb")
	$Progress.visible = false


func _process(delta):
	if mouse_entered and not defused:
		if player_nearby:
			if Input.is_action_just_pressed("defuse"):
				defusing = true
				$Progress.visible = true
			
			if Input.is_action_pressed("defuse"):
				current_defuse_time += delta
				$Progress.value = $Progress.max_value / 100 * (current_defuse_time * (100 / defuse_time))
			elif defusing:
				defusing = false
				$Progress.visible = false
				current_defuse_time = 0
			
			if $Progress.value >= $Progress.max_value:
				defusing = false
				defused = true
				$Progress.visible = false
				get_tree().get_nodes_in_group("GameScript")[0].defused()
		elif defusing:
			defusing = false
			$Progress.visible = false
			current_defuse_time = 0


func set_text(text):
	$TimeText.text = text


func set_text_color(color):
	$TimeText.add_color_override("font_color", color)


func _on_StaticBody2D_mouse_entered():
	mouse_entered = true


func _on_StaticBody2D_mouse_exited():
	mouse_entered = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player_nearby = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player_nearby = false
