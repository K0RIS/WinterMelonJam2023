extends Node2D
@export var Rock: PackedScene
@export var muzzle_velocity = 350
@export var gravity = 250
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func shoot():
	var b = Rock.instantiate()
	add_child(b)
	b.transform = $Hand/Position2D.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.gravity = gravity
	
	
	
func  StartTimer():
	
	$Timer.start()
	
func StopTimer():
	
	$Timer.stop()
func _on_timer_timeout():
	shoot()
