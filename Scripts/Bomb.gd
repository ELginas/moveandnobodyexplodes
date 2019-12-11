extends Node2D

func _ready():
	add_to_group("Bomb")


func set_text(text):
	$TimeText.text = text