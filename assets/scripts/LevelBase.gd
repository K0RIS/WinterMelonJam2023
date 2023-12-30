extends Node

@onready var snake_charmer = $SnakeCharmer
@onready var lose_screen = $LoseScreen

func _ready():
	ScoreManager.current_combo = 0
	ScoreManager.current_score = 0
	start_game()
	

func start_game():
	ScoreManager.visible = true
	ScoreManager.score.text = "0"
	ScoreManager.combo.text = "x0"
	snake_charmer.rhythm_game.start_track()
	$HBoxContainer.visible = true
	$Timer.start()
	


func _on_environmental_areas_snake_lose():
	$EnvironmentalAreas/RockThrower.StopTimer()
	$EnvironmentalAreas/RockThrower2.StopTimer()
	ScoreManager.visible = false
	lose_screen.visible = true
	$LoseScreen.Pause()

func _on_snake_charmer_died():
	$EnvironmentalAreas/RockThrower.StopTimer()
	$EnvironmentalAreas/RockThrower2.StopTimer()
	ScoreManager.visible = false
	lose_screen.visible = true
	$LoseScreen.Pause()


func _on_ready_up_screen_start_game():
	pass


func _on_timer_timeout():
	$HBoxContainer.visible = false
