extends Node2D

@export var bpm: float = 90
var base_bpm = 0
@export var measures: int = 8
@onready var principal_track = $PrincipalTrack
@onready var flute_track = $FluteTrack
@onready var combo_track = $ComboTrack
@onready var arrow_rig = $ArrowRig
@onready var player = $"../.."

var score: int = 0
var beat_divisor: int = 1

var _sec_per_beat = 0
var _current_time: float = 0.0
var _current_beat: int = 0
var _last_beat: int = 0
var _last_song_pos = 0
var start = 0

@export var flute_delay = 0.0
var _allow_flute = false

signal beat
signal GettingFaster
func get_faster():
	$PrincipalTrack.pitch_scale += 0.5
	$FluteTrack.pitch_scale += 0.5
	$ComboTrack.pitch_scale += 0.5
	ScoreManager.speed_mult_scalar = $PrincipalTrack.pitch_scale
	

func start_track():
	principal_track.play(start)
	flute_track.play(start)
	combo_track.play(start)
	$FluteDelay.wait_time = flute_delay
	$FluteDelay.start()
	
func stop_track():
	principal_track.stop()
	flute_track.stop()
	combo_track.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	_sec_per_beat = Engine.physics_ticks_per_second / (bpm * beat_divisor)
	base_bpm = bpm
	self.position = $"../..".position
	$FluteDelay.wait_time = flute_delay


func _time_to_beat(song_position: float):
	return int(song_position / _sec_per_beat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_current_time = principal_track.get_playback_position()
	if _current_time < _last_song_pos:
		emit_signal("GettingFaster")
	_last_song_pos = _current_time
	_current_time += AudioServer.get_time_since_last_mix()
	_current_time -= AudioServer.get_output_latency()
	_current_beat = _time_to_beat(_current_time)
	
	if (_current_beat != _last_beat and _allow_flute):
		emit_signal("beat")
	_last_beat = _current_beat
	position.x = lerp(self.position.x, player.position.x, 0.1)
	position.y = lerp(self.position.y, player.position.y, 0.1)


func _on_beat():
	arrow_rig.spawn_note((randi() % 4) + 1, _sec_per_beat)


func _on_timer_timeout():
	_allow_flute = true
