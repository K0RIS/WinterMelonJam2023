extends Node

@onready var snake_charmer = $SnakeCharmer
@onready var lose_screen = $LoseScreen

func _ready():
	start_game()

func start_game():
	ScoreManager.visible = true
	ScoreManager.score.text = "0"
	ScoreManager.combo.text = "x0"
	snake_charmer.rhythm_game.start_track()
	


func _on_environmental_areas_snake_lose():
	$EnvironmentalAreas/RockThrower.StopTimer()
	$EnvironmentalAreas/RockThrower2.StopTimer()
	ScoreManager.visible = false
	lose_screen.visible = true
	

func _on_snake_charmer_died():
	$EnvironmentalAreas/RockThrower.StopTimer()
	$EnvironmentalAreas/RockThrower2.StopTimer()
	ScoreManager.visible = false
	lose_screen.visible = true
