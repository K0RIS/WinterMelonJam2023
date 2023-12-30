extends Node2D

class_name Rock

var velocity :Vector2 = Vector2.ZERO
var dir: Vector2 = Vector2.ZERO
@export var speed: float = 1200
var gravity: float = 1000

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	#rotation = velocity.angle()



func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	queue_free()
