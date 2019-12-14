extends Node2D

export(int) var NEXT_LEVEL_ID = 0

const DEFUSE_TIME = 5
const RESTART_TIME = 3
const NEXT_TIME = 3

var mouse_entered = false
var player_nearby = false
var defusing = false
var defused = false
var exploded = false

var current_defuse_time = 0
var current_restart_time = 0
var current_next_time = 0

var scene_changed = false


func _ready():
	add_to_group("Bomb")
	$Progress.visible = false


func _process(delta):
	if mouse_entered and not defused and not exploded:
		if player_nearby:
			if Input.is_action_just_pressed("defuse"):
				defusing = true
				$Progress.visible = true
			
			if Input.is_action_pressed("defuse"):
				current_defuse_time += delta
				$Progress.value = $Progress.max_value / 100 * (current_defuse_time * (100 / DEFUSE_TIME))
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
	elif exploded:
		current_restart_time += delta
		if current_restart_time >= RESTART_TIME:
			get_tree().reload_current_scene()
	elif defused:
		if not scene_changed:
			current_next_time += delta
			if current_next_time >= NEXT_TIME:
				if NEXT_LEVEL_ID != 0:
					get_tree().change_scene("res://Scenes/Level"+str(NEXT_LEVEL_ID)+".tscn")
				else:
					pass
				scene_changed = true


func explode():
	exploded = true
	$Explosion.visible = true
	$Explosion.play("Explosion")
	$Sprite.visible = false
	$TimeText.visible = false
	$Progress.visible = false


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
