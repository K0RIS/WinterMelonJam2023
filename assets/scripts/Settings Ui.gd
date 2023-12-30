extends Control


var master_Bus = AudioServer.get_bus_index("Master")
var music_Bus = AudioServer.get_bus_index("Music")
var sfx_Bus = AudioServer.get_bus_index("SFX")

func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(master_Bus,value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_Bus,true)
	else:
		AudioServer.set_bus_mute(master_Bus,false)

func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(music_Bus,value)
	if value == -30:
		AudioServer.set_bus_mute(music_Bus,true)
	else:
		AudioServer.set_bus_mute(music_Bus,false)

func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_Bus,value)
	if value == -30:
		AudioServer.set_bus_mute(sfx_Bus,true)
	else:
		AudioServer.set_bus_mute(sfx_Bus,false)
