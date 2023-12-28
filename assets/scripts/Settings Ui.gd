extends Control


var master_Bus = AudioServer.get_bus_index("Master")




func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(master_Bus,value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_Bus,true)
	else:
		AudioServer.set_bus_mute(master_Bus,false)
