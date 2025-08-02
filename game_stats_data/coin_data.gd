extends Node2D

const SAVE_PATH := "user://game_stats.save"

var total_coins := 0

func add_to_total_coins(amount: int):
	total_coins += amount
	save()

func save():
	var data := _load_full_data()
	data["total_coins"] = total_coins

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(data)

func load_coin():
	var data := _load_full_data()
	total_coins = data.get("total_coins", 0)

func _load_full_data() -> Dictionary:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		return file.get_var()
	return {}
