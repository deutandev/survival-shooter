extends Node

var coin_count: int = 0
var score: int = 0

signal coin_changed(new_value: int)
signal score_changed(new_value: int)

func reset():
	coin_count = 0
	score = 0
	coin_changed.emit(coin_count)
	score_changed.emit(score)

func add_coin(amount: int = 1):
	coin_count += amount
	coin_changed.emit(coin_count)

func add_score(amount: int = 10):
	score += amount
	score_changed.emit(score)
