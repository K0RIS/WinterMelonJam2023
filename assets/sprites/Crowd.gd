extends Node2D
@export var Rock: PackedScene
@export var muzzle_velocity = 350
@export var gravity = 250
@export var ToTheLeft = false
var rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func shoot():
	$AudioStreamPlayer.play()
	var DirChanger = 1
	if ToTheLeft:
		DirChanger =  -1
	var b = Rock.instantiate()
	add_child(b)
	b.transform = $Marker2D.global_transform
	b.velocity = b.transform.x * RandonVel() * DirChanger
	b.velocity += b.transform.y * 900 * -1
	b.gravity = RandonGrav()
	
	
	
func RandonVel():
	var my_random_number = rng.randi_range(0, 4)
	var ListOfSpeeds = [100,150,100,100,150]
	var NewSpeed = ListOfSpeeds[my_random_number]
	return NewSpeed
func RandonGrav():
	var my_random_number = rng.randi_range(0, 4)
	var ListOfGrav = [500,500,500,500 ,525]
	var NewGrav = ListOfGrav[my_random_number]
	return NewGrav
func RandonUpVal():
	var my_random_number = rng.randi_range(0, 4)
	var ListOfGrav = [5000,5000,5000,5000,5000]
	var NewGrav = ListOfGrav[my_random_number]
	return NewGrav
func  StartTimer():
	
	$Timer.start()
	
func StopTimer():
	
	$Timer.stop()
func _on_timer_timeout():
	shoot()
