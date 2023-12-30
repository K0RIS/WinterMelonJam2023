extends CanvasLayer

const MAX_COMBO = 10

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
	if current_combo >= 10 and _target_combo_volume_db == 0:
		wrong_note_player.stream = WRONG_NOTE[9]
		wrong_note_player.play()
		
	current_combo = 0
	combo.text = "x" + str(current_combo)
	_target_combo_volume_db = -80
	AudioServer.set_bus_mute(bus_indices.Ney, true)
	


func add_to_combo():
	current_combo += 1
	current_combo = clampi(current_combo, 0, MAX_COMBO)
	if current_combo >= 10 and _target_combo_volume_db != 0:
		_target_combo_volume_db = 0
		wrong_note_player.stream = WRONG_NOTE[8]
		wrong_note_player.play()
	combo.text = "x" + str(current_combo)
	AudioServer.set_bus_mute(bus_indices.Ney, false)


func add_points(Dist):
	var percent_of_point 
	if Dist > 50:
		status.text = "Too soon"
		break_combo()
		wrong_note()
	elif Dist <- 50:
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
		
	
	current_score += current_combo * 100
	score.text = str(current_score)

func wrong_note():
	wrong_note_player.stream = WRONG_NOTE[randi() % 8]
	wrong_note_player.play()

func on_missed_note():
	status.text = "Missed!"
	break_combo()
	

