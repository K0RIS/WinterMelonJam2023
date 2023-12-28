extends Node2D

const TICK_RATE: float = 60.0
@export var bpm: float = 90
@export var measures: int = 8
@onready var song_track = $SongTrack
@onready var flute_track = $FluteTrack
@onready var arrow_rig = $ArrowRig

var score: int = 0
var beat_divisor: int = 1

var _sec_per_beat = 0
var _current_time: float = 0.0
var _current_beat: int = 0
var _last_beat: int = 0

signal beat

# Called when the node enters the scene tree for the first time.
func _ready():
	_sec_per_beat = TICK_RATE / (bpm * beat_divisor)


func _time_to_beat(song_position: float):
	return int(song_position / _sec_per_beat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_current_time = song_track.get_playback_position() 
	_current_time += AudioServer.get_time_since_last_mix()
	_current_time -= AudioServer.get_output_latency()
	_current_beat = _time_to_beat(_current_time)
	
	if (_current_beat != _last_beat):
		emit_signal("beat")
	_last_beat = _current_beat


func _on_beat():
	arrow_rig.spawn_note((randi() % 4) + 1, _sec_per_beat)
