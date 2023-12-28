extends Node2D

var MaxCombo
var CurrentCombo
var CurrentScore = 0.0




func BreakCombo():
	CurrentCombo = 0

func  AddtoCombo():
	CurrentCombo += 1
	if  CurrentCombo > MaxCombo:
		CurrentCombo = 10


func _on_arrow_rig_add_points(Dist):
	var percentOfPoint 
	if Dist > 50:
		$Ui/Status.text = "Too soon"
		#take damage
		return
	if Dist <-50:
		$Ui/Status.text = "Too slow"
		#take damage
		return
	if abs(Dist) <=50 and abs(Dist) >= 30:
		$Ui/Status.text = "Good"
		percentOfPoint = .5

	if  abs(Dist) <30 and abs(Dist) >= 10:
		$Ui/Status.text = "Great!"
		percentOfPoint = .8

	if  abs(Dist) <10: 
		percentOfPoint = 1
		$Ui/Status.text = "Perfect!"
	
	CurrentScore += percentOfPoint * 100
	$Ui/Score.text = "Score:" +str(CurrentScore)


func _on_arrow_rig_missed_note():
	$Ui/Status.text = "Missed!"
