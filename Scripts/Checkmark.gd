extends CanvasLayer

export(Vector2) var base_size


#func _ready():
#	$Image.rect_pivot_offset = base_size / 2


#func to_center(screen_size):
#	$Image.rect_position = Vector2(screen_size.x / 2 - base_size.x / 2, screen_size.y / 2 - base_size.y / 2)


func play_anim():
	$AnimationPlayer.play("Init")
	$WinSound.play()