extends CharacterBody2D
class_name SnakeCharmer
signal  died
const SPEED = 800.0
const JUMP_VELOCITY = -400.0

@onready var rhythm_game = $Node/RhythmGame
@onready var sprite = $AnimatedSprite2D

var CurrentArea :String
signal CallMeterManager(CurrentArea)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var MaxHealth = 3
var CurrentHealth = 3

var taking_damage = false

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		sprite.flip_h = false
	elif  direction < 0:
		sprite.flip_h = true
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_hit_box_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	CurrentArea = area.name
	
	
func _on_hit_box_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	CurrentArea = "None"



func _on_timer_timeout():
	emit_signal("CallMeterManager", CurrentArea)

func _on_rock_hit_box_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if not taking_damage:
		CurrentHealth -= 1
		CheckHealth()
		taking_damage = true
		sprite.modulate = Color(100, 100, 100)
		$hit_timer.start()
		$HitEffect.play()

func  CheckHealth():
	if CurrentHealth <= 0:
		emit_signal("died")

func _on_hit_timer_timeout():
	taking_damage = false
	sprite.modulate = Color(1, 1, 1)
