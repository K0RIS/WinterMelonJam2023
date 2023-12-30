extends Node2D

@onready var snake_meter = $Node2D/SnakeArea/SnakeMeter
@onready var charm_meter = $Node2D/CrowdArea/CharmMeter
@onready var placeholder_meter = $Node2D/PlaceholderArea/PlaceholderMeter

@onready var crowd_one = $Node2D/CrowdArea/AnimatedSprite2D
@onready var crowd_two = $Node2D/PlaceholderArea/AnimatedSprite2D2

@onready var snake = $Node2D/SnakeArea/Snake

signal snake_lose

func _on_snake_meter_bar_empty():
	emit_signal("snake_lose")


func _on_charm_meter_bar_empty():
	$RockThrower.StartTimer()


func _on_place_holder_bar_empty():
	$RockThrower2.StartTimer()

func _on_snake_meter_value_changed(value):
	var target = int(((value)/100)*7) + 1
	target = clampi(target, 1, 7)
	snake.play(str(target))


func _on_charm_meter_value_changed(value):
	var target = int(((value)/100)*3)
	target = clampi(target, 0, 2)
	crowd_one.play(str(target))
	
	if value >= 10:
		$RockThrower.StopTimer()


func _on_place_holder_value_changed(value):
	var target = int(((value)/100)*3)
	target = clampi(target, 0, 2)
	crowd_two.play(str(target))
	
	if value >= 10:
		$RockThrower2.StopTimer()


func _on_snake_area_body_entered(body):
	if body is SnakeCharmer:
		snake_meter.has_player = true


func _on_snake_area_body_exited(body):
	if body is SnakeCharmer:
		snake_meter.has_player = false

func _on_crowd_area_body_entered(body):
	if body is SnakeCharmer:
		charm_meter.has_player = true


func _on_crowd_area_body_exited(body):
	if body is SnakeCharmer:
		charm_meter.has_player = false


func _on_placeholder_area_body_entered(body):
	if body is SnakeCharmer:
		placeholder_meter.has_player = true


func _on_placeholder_area_body_exited(body):
	if body is SnakeCharmer:
		placeholder_meter.has_player = false


func _on_snake_meter_bar_not_empty():
	pass # Replace with function body.


func _on_charm_meter_bar_not_empty():
	#$RockThrower.StopTimer() # 
	pass


func _on_placeholder_meter_bar_not_empty():
	#$RockThrower2.StopTimer()
	pass
