extends Control

const DEATH_OFFSET = -50 #pixels off of target a note will be before it is a miss

@export var notes_per_beat: float = 4.0

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

var buttons = [
	preload("res://assets/sprites/buttons/button_down.png"),
	preload("res://assets/sprites/buttons/button_down_pressed.png"),
	preload("res://assets/sprites/buttons/button_left.png"),
	preload("res://assets/sprites/buttons/button_left_pressed.png"),
	preload("res://assets/sprites/buttons/button_right.png"),
	preload("res://assets/sprites/buttons/button_right_pressed.png"),
	preload("res://assets/sprites/buttons/button_up.png"),
	preload("res://assets/sprites/buttons/button_up_pressed.png")
]

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
	else:
		lane_target_1.texture = buttons[2]
		
	if Input.is_action_just_pressed("right"): #4
		for note in get_tree().get_nodes_in_group("note"):
			if note.lane == 4:
				check_accuracy(note)
				break
	else:
		lane_target_4.texture = buttons[4]
	
	if Input.is_action_pressed("left"):
		lane_target_1.texture = buttons[3]
	else:
		lane_target_1.texture = buttons[2]
	if Input.is_action_pressed("right"):
		lane_target_4.texture = buttons[5]
	else:
		lane_target_4.texture = buttons[4]
	if Input.is_action_pressed("up"):
		lane_target_2.texture = buttons[7]
	else:
		lane_target_2.texture = buttons[6]
	if Input.is_action_pressed("down"):
		lane_target_3.texture = buttons[1]
	else:
		lane_target_3.texture = buttons[0]


func check_accuracy(note: Note):
	var dist = get_note_dist(note)
	ScoreManager.add_points(dist)
	note.queue_free()


func get_note_dist(note: Note) -> float:
	return note.global_position.y - lane_target_1.global_position.y


func spawn_note(lane: int, sec_per_beat: float):	
	if (randi() % 10 == 5):
		var new_note = note.instantiate()
		add_child(new_note)
		new_note.lane = lane
		while (new_note.lane == lane):
			new_note.lane = randi() % 4 + 1
		init_note(new_note, sec_per_beat)
	
	var new_note = note.instantiate()
	add_child(new_note)
	new_note.lane = lane
	init_note(new_note, sec_per_beat)
	

func init_note(new_note: Note, sec_per_beat: float):
	match new_note.lane:
		1:
			new_note.note_texture.texture = new_note.notes[0]
			new_note.modulate = new_note.colors[0]
			new_note.global_position = spawn_lane_1.global_position
		2:
			new_note.note_texture.texture = new_note.notes[1]
			new_note.modulate = new_note.colors[1]
			new_note.global_position = spawn_lane_2.global_position
		3:
			new_note.note_texture.texture = new_note.notes[2]
			new_note.modulate = new_note.colors[2]
			new_note.global_position = spawn_lane_3.global_position
		4:
			new_note.note_texture.texture = new_note.notes[3]
			new_note.modulate = new_note.colors[3]
			new_note.global_position = spawn_lane_4.global_position
	new_note.velocity = (1 / notes_per_beat) * (get_note_dist(new_note) + 100) / sec_per_beat

