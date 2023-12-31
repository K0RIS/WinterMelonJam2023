extends CanvasLayer

const MAX_COMBO = 10

var shake_open = "[shake rate=20.0 level=5 connected=1]"
var shake_close = "[/shake]"

var speed_mult_scalar = 1

@onready var wrong_note_player = $WrongNotePlayer

const WRONG_NOTE = [
	preload("res://assets/sound/music/Wrong/Wrong_1.wav"),
	preload("res://assets/sound/music/Wrong/Wrong_2.wav"),
	preload("res://assets/sound/music/Wrong/Wrong_3.wav"),
	preload("res://assets/sound/music/Wrong/Wrong_4.wav"),
	preload("res://assets/sound/music/Wrong/Wrong_5.wav"),
	preload("res://assets/sound/music/Wrong/Wrong_6.wav"),
	preload("res://assets/sound/music/Wrong/Wrong_7.wav"),
	preload("res://assets/sound/music/Wrong/Wrong_8.wav"),
	preload("res://assets/sound/music/sfx/Combo.wav"),
	preload("res://assets/sound/music/sfx/Combo_Lost.wav")
]

@onready var score = $VBoxContainer/Score
@onready var combo = $VBoxContainer/Combo
@onready var status = $Status

var current_combo = 0.0
var current_score = 0.0

var _combo_volume_db: float = -80.0
var _target_combo_volume_db: float = -80.0

var bus_indices: AudioBusIndices

class AudioBusIndices:
	var Principal = -1
	var Ney = -1
	var Combo = -1

func _ready():
	bus_indices = AudioBusIndices.new()
	bus_indices.Principal = AudioServer.get_bus_index("Principal")
	bus_indices.Ney = AudioServer.get_bus_index("Ney")
	bus_indices.Combo = AudioServer.get_bus_index("Combo")
	AudioServer.set_bus_volume_db(bus_indices.Combo, _combo_volume_db)

func _physics_process(delta):
	_combo_volume_db = lerp(_combo_volume_db, _target_combo_volume_db, 0.05)
	AudioServer.set_bus_volume_db(bus_indices.Combo, _combo_volume_db)

func break_combo():
	for meter in get_tree().get_nodes_in_group("SnakeMeter"):
		meter.value -= 5
	for snake in get_tree().get_nodes_in_group("snake"):
		snake.on_hit()
	
	if current_combo >= 10 and _target_combo_volume_db == 0:
		wrong_note_player.stream = WRONG_NOTE[9]
		wrong_note_player.play()
		
	current_combo = 0
	combo.text = str(current_combo)
	score.text = str(current_score)
	_target_combo_volume_db = -80
	AudioServer.set_bus_mute(bus_indices.Ney, true)
	


func add_to_combo():
	current_combo += 1
	current_combo = clampi(current_combo, 0, MAX_COMBO)
	if current_combo >= 10 and _target_combo_volume_db != 0:
		_target_combo_volume_db = 0
		wrong_note_player.stream = WRONG_NOTE[8]
		wrong_note_player.play()
	if current_combo >= 10:	
		combo.text = shake_open + "x" + str(current_combo) + shake_close
	else:
		combo.text = "x" + str(current_combo)
		score.text = str(current_score)
	AudioServer.set_bus_mute(bus_indices.Ney, false)


func add_points(Dist):
	var percent_of_point 
	if Dist > 25:
		status.text = "Too soon"
		break_combo()
		wrong_note()
	elif Dist < -25:
		status.text = "Too slow"
		break_combo()
		wrong_note()
	elif abs(Dist) <= 50 and abs(Dist) >= 30:
		status.text = "Good"
		add_to_combo()
	elif abs(Dist) < 30 and abs(Dist) >= 10:
		status.text = "Great!"
		add_to_combo()
	elif abs(Dist) < 10: 
		status.text = "Perfect!"
		add_to_combo()
		
	
	current_score += current_combo * speed_mult_scalar * 100 
	if current_combo >= 10:
		score.text = shake_open + str(current_score) + shake_close
	else:
		score.text = str(current_score)

func wrong_note():
	wrong_note_player.stream = WRONG_NOTE[randi() % 8]
	wrong_note_player.play()

func on_missed_note():
	status.text = "Missed!"
	break_combo()
	

