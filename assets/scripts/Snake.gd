extends AnimatedSprite2D

@onready var hit_timer = $HitTimer

func on_hit():
	hit_timer.start(0.0)
	modulate = Color(1, 0.25, 0.25)


func _on_hit_timer_timeout():
	modulate = Color(1, 1, 1)
