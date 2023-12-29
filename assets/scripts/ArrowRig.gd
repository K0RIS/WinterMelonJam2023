extends Control

const DEATH_OFFSET = -50 #pixels off of target a note will be before it is a miss

@onready var note = preload("res://assets/scenes/Note.tscn")

@onready var spawn_lane_1 = $Lanes/Lane1/SpawnAnchor/Spawn
@onready var spawn_lane_2 = $Lanes/Lane2/SpawnAnchor/Spawn
@onready var spawn_lane_3 = $Lanes/Lane3/SpawnAnchor/Spawn
@onready var spawn_lane_4 = $Lanes/Lane4/SpawnAnchor/Spawn

@onready var lane_target_1 = $Lanes/Lane1/Target
@onready var lane_target_2 = $Lanes/Lane2/Target
@onready var lane_target_3 = $Lanes/Lane3/Target
@onready var lane_target_4 = $Lanes/Lane4/Target

var _spawn_dist: float = 0
signal  AddPoints(Dist)
signal  MissedNote

func _physics_process(delta):
	for note in get_tree().get_nodes_in_group("note"):
		if (get_note_dist(note) < DEATH_OFFSET):
			ScoreManager.on_missed_note()
			emit_signal("MissedNote")
			note.queue_free()

func _input(event):
	if Input.is_action_just_pressed("up"): #2
		for note in get_tree().get_nodes_in_group("note"):
			if note.lane == 2:
				check_accuracy(note)
				break
	if Input.is_action_just_pressed("down"): #3
		for note in get_tree().get_nodes_in_group("note"):
			if note.lane == 3:
				check_accuracy(note)
				break
	if Input.is_action_just_pressed("left"): # 1
		for note in get_tree().get_nodes_in_group("note"):
			if note.lane == 1:
				check_accuracy(note)
				break
	if Input.is_action_just_pressed("right"): #4
		for note in get_tree().get_nodes_in_group("note"):
			if note.lane == 4:
				check_accuracy(note)
				break


func check_accuracy(note: Note):
	var dist = get_note_dist(note)
	ScoreManager.add_points(dist)
	note.queue_free()


func get_note_dist(note: Note) -> float:
	return note.global_position.y - lane_target_1.global_position.y


func spawn_note(lane: int, sec_per_beat: float):
	var new_note = note.instantiate()
	add_child(new_note)
	new_note.lane = lane
	
	match lane:
		1:
			new_note.global_position = spawn_lane_1.global_position
			new_note.velocity = get_note_dist(new_note) / sec_per_beat
		2:
			new_note.global_position = spawn_lane_2.global_position
			new_note.velocity = get_note_dist(new_note) / sec_per_beat
		3:
			new_note.global_position = spawn_lane_3.global_position
			new_note.velocity = get_note_dist(new_note) / sec_per_beat
		4:
			new_note.global_position = spawn_lane_4.global_position
			new_note.velocity = get_note_dist(new_note) / sec_per_beat

