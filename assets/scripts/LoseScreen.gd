extends Control

@onready var final_score = $CenterContainer/VBoxContainer/RichTextLabel3

func _on_back_button_down():
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://assets/scenes/main_menu.tscn")
	
func _process(delta):
	final_score.text = str(ScoreManager.current_score)


func Pause():
	get_tree().paused = true
