extends Node2D

var MaxCombo
var CurrentCombo
var CurrentScore
signal AddToScore



func BreakCombo():
	CurrentCombo = 0

func  AddtoCombo():
	CurrentCombo += 1
	if  CurrentCombo > MaxCombo:
		CurrentCombo = 10

func AddToCurrentScore():
	CurrentScore += CurrentCombo * 10
