extends Control


var master_Bus = AudioServer.get_bus_index("Master")
var VFX_Bus = AudioServer.get_bus_index("VFX")



func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(master_Bus,value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_Bus,true)
	else:
		AudioServer.set_bus_mute(master_Bus,false)


func _on_music_2_value_changed(value):
	AudioServer.set_bus_volume_db(VFX_Bus,value)
	if value == -30:
		AudioServer.set_bus_mute(VFX_Bus,true)
	else:
		AudioServer.set_bus_mute(VFX_Bus,false)

