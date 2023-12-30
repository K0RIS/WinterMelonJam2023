extends CanvasLayer

var CanStart = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$AnimationPlayer.play("idle")
	get_tree().paused = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Start_Level") and CanStart:
		CanStart = false
		$AnimationPlayer.play("Start")
		$LevelStart.play()
func UnPause():
	get_tree().paused = false
