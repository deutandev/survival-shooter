extends Node2D

@onready var coin_label = %CoinLabel
@onready var highscore_label = %HighscoreLabel

func _ready():
	coin_label.text = str(CoinData.total_coins)
	highscore_label.text = str(ScoreData.highscore)
