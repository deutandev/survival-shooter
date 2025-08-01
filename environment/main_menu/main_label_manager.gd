extends Node2D

@onready var coin_label = %CoinLabel
@onready var highscore_label = %HighscoreLabel

func _ready():
	if coin_label:
		CoinData.load_coin()
		coin_label.text = str(CoinData.total_coins)
	if highscore_label:
		ScoreData.load_score()
		highscore_label.text = str(ScoreData.highscore)
