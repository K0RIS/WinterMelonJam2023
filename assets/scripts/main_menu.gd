extends CanvasLayer



func _on_start_pressed():
	get_tree().change_scene_to_file("res://assets/scenes/Debug.tscn")
	print("start game")


func _on_settings_pressed():
	$AnimationPlayer.play("ShowSettings")


func _on_back_pressed():
	$AnimationPlayer.play("ShowMain")


