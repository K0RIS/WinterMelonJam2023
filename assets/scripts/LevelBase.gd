extends Node

@onready var snake_charmer = $SnakeCharmer

func _ready():
	start_game()

func start_game():
	ScoreManager.visible = true
	ScoreManager.score.text = "0"
	ScoreManager.combo.text = "x0"
	snake_charmer.rhythm_game.start_track()
