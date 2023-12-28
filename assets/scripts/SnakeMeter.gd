
extends ProgressBar

 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_meter_manager_change_snake_meter(Value):
	if Value > 0 :
		value += Value
	else: 
		value -=1
	
	CheckValueOfProgressBar()
func CheckValueOfProgressBar():
	if value == 0:
		print("You lost due to snake")
