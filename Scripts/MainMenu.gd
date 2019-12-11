extends Control

const PLAY_SCENE = preload("res://Scenes/Level1.tscn")


func play_game():
	get_tree().change_scene_to(PLAY_SCENE)


func exit_game():
	get_tree().quit()


func _on_PlayButton_pressed():
	exit_game()


func _on_ExitButton_pressed():
	play_game()
