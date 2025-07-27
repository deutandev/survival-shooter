extends Node2D

@onready var coin_label = %CoinLabel

func _ready():
	coin_label.text = str(CoinData.total_coins)
