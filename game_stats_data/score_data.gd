extends Node2D

var highscore := 0

func get_highscore(score):
	if score > highscore:
		highscore = score
