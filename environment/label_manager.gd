extends Node2D

@onready var coin_total_label = %CoinTotal
@onready var score_total_label = %ScoreTotal

func _ready():
	Game_Stats.coin_changed.connect(update_coin_label)
	Game_Stats.score_changed.connect(update_score_label)

	update_coin_label(Game_Stats.coin_count)
	update_score_label(Game_Stats.score)

func update_coin_label(new_value: int):
	coin_total_label.text = str(new_value)

func update_score_label(new_value: int):
	score_total_label.text = "Score: " + str(new_value)
