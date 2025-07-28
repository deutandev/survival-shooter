extends Node2D

@onready var gameover_panel := %GameoverPanel
@export var player : CharacterBody2D
const MAIN_MENU_PATH := "res://environment/main_menu/mainMenu.tscn"

@onready var final_score_label := %FinalScoreLabel
@onready var final_coin_label := %FinalCoinLabel

func _ready():
	gameover_panel.visible = false
	player.player_died.connect(_on_player_died)

func _on_player_died():
	get_tree().paused = true
	final_coin_label.text = "Coin: " + str(GameStats.coin_count)
	final_score_label.text = "Score: " + str(GameStats.score)
	gameover_panel.visible = true
	call_deferred("_return_to_main_menu")
	
func _return_to_main_menu():
	set_score_coin()
	await get_tree().create_timer(3.0, true).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
	
func set_score_coin():
	# Set total coin
	CoinData.add_to_total_coins(GameStats.coin_count)
	# Set highscore
	ScoreData.get_highscore(GameStats.score)
