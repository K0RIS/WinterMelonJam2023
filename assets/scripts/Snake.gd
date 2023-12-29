extends AnimatedSprite2D

@export var current_level = 1

func _ready():
	play(str(current_level))

func _on_animation_finished():
	speed_scale *= -1
	play(str(current_level))
