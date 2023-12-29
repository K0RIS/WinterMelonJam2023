
extends ProgressBar

@export var decrement_velocity = 3
@export var increment_velocity = 1

var has_player = false

signal bar_empty
signal bar_not_empty
func _physics_process(delta):
	if !has_player:
		value -= decrement_velocity * delta
	else:
		value += increment_velocity * delta * ScoreManager.current_combo

func _on_value_changed(value):
	if value <= 0:
		emit_signal("bar_empty")
	if value > 0:
		emit_signal("bar_not_empty")
