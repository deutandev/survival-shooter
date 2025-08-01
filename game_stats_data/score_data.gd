extends Node2D

const SAVE_PATH := "user://game_stats.save"

var highscore := 0

func get_highscore(score):
	if score > highscore:
		highscore = score

func save():
	var data := _load_full_data()
	data["highscore"] = highscore

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(data)

func load():
	var data := _load_full_data()
	highscore = data.get("highscore", 0)

func _load_full_data() -> Dictionary:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		return file.get_var()
	return {}
