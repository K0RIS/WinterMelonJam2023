extends CharacterBody2D

@export var speed = 15000.0 #pixels/s

func _physics_process(delta):
	velocity =  Input.get_axis("move_left", "move_right") * Vector2.RIGHT
	velocity += Input.get_axis("move_up", "move_down") * Vector2.DOWN

	velocity = velocity.normalized()
	velocity *= speed * delta
	
	move_and_slide()
