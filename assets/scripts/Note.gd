extends Node2D
class_name Note

var velocity = 10
var lane = 0

@onready var note_texture = $NoteTexture

var notes = [
	preload("res://assets/sprites/buttons/left.png"),
	preload("res://assets/sprites/buttons/up.png"),
	preload("res://assets/sprites/buttons/down.png"),
	preload("res://assets/sprites/buttons/right.png"),
]

var colors = [
	Color(3, 1, 2),
	Color(1, 5, 1),
	Color(1, 10, 10),
	Color(5, 5, 1)
]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.y -= velocity * delta
