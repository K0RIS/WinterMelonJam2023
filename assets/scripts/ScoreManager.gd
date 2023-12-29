extends CanvasLayer

const MAX_COMBO = 10

@onready var score = $VBoxContainer/Score
@onready var combo = $VBoxContainer/Combo
@onready var status = $Status

var current_combo = 0.0
var current_score = 0.0

func break_combo():
	current_combo = 0
	combo.text = "x" + str(current_combo)

func add_to_combo():
	current_combo += 1
	current_combo = clampi(current_combo, 0, MAX_COMBO)
	combo.text = "x" + str(current_combo)

func add_points(Dist):
	var percent_of_point 
	if Dist > 50:
		status.text = "Too soon"
		break_combo()

	if Dist <- 50:
		status.text = "Too slow"
		break_combo()

	if abs(Dist) <= 50 and abs(Dist) >= 30:
		status.text = "Good"
		add_to_combo()

	if  abs(Dist) < 30 and abs(Dist) >= 10:
		status.text = "Great!"
		add_to_combo()

	if  abs(Dist) < 10: 
		status.text = "Perfect!"
		add_to_combo()
	
	current_score += current_combo * 100
	score.text = str(current_score)


func on_missed_note():
	status.text = "Missed!"
	break_combo()
