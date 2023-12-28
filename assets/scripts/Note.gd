extends Node2D
class_name Note

var velocity = 10
var lane = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print(velocity)
	position.y -= velocity * delta
