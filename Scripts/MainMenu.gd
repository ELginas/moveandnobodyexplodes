extends Control


func play_game():
	pass


func exit_game():
	get_tree().quit()


func _on_PlayButton_pressed():
	exit_game()


func _on_ExitButton_pressed():
	play_game()
