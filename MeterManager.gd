extends Control

# Value can be - or + depending if player gets the note right
signal ChangeSnakeMeter(Value)
signal ChangeCharmMeter(Value)
signal ChangeOtherMeter(Value)



func EmitOneOfMeters(Area):
	print("Change a value")

func  EmitChangeSnakeMeter(Value): 
	emit_signal("ChangeSnakeMeter", Value )
	
func  EmitChangeCharmMeter(Value): 
	emit_signal("ChangeCharmMeter", Value)
	
func  EmitOtherCharmMeter(Value): 
	emit_signal("ChangeOtherMeter", Value)


func _on_snake_charmer_call_meter_manager(CurrentArea):
	if CurrentArea == "Area 1":
		EmitChangeCharmMeter(2)
	
	if CurrentArea == "Area 2":
		EmitOtherCharmMeter(2)
	EmitChangeCharmMeter(-1) 
	EmitOtherCharmMeter(-1) 
