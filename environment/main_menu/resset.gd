extends Node
class_name ResetData

const PLAYER_SAVE_PATH := "user://game_stats.save"
const STORY_SAVE_PATH := "user://story_lock_status.save"

func _ready() -> void:
	reset_all()

func reset_all():
	# Delete save files if they exist
	if FileAccess.file_exists(PLAYER_SAVE_PATH):
		var dir := DirAccess.open("user://")
		dir.remove("game_stats.save")

	if FileAccess.file_exists(STORY_SAVE_PATH):
		var dir := DirAccess.open("user://")
		dir.remove("story_lock_status.save")


	# Reset in-memory values
	CoinData.total_coins = 0
	CoinData.save()

	ScoreData.highscore = 0
	ScoreData.save()

	GameStats.reset()

	StorySaveManager.load_unlocks()
