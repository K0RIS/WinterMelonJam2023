extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_pressed():
	get_tree().reload_current_scene()


func _on_home_pressed():
	get_tree().paused = false
	get_tree().get_root().change_scene_to_file("res://assets/scenes/main_menu.tscn")

func  FailState():
	get_tree().paused = true
	$AnimationPlayer.play("failstate")
	$LostSound.play()
