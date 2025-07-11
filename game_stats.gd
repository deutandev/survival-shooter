extends Node
class_name GameStats

var coin_count: int = 0
var score: int = 0

signal coin_changed(new_value: int)
signal score_changed(new_value: int)

func add_coin(amount: int = 1):
	coin_count += amount
	coin_changed.emit(coin_count)

func add_score(amount: int = 10):
	score += amount
	score_changed.emit(score)
