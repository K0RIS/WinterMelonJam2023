extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	#get_tree().change_scene_to_file()
	print("start game")


func _on_settings_pressed():
	$AnimationPlayer.play("ShowSettings")


func _on_back_pressed():
	$AnimationPlayer.play("ShowMain")


