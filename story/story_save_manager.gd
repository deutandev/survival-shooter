extends Node

const SAVE_PATH := "user://story_lock_status.save"

# Story unlocked status 
var chapter_unlocks := {
	"chapter_intro": false, 
	"chapter_one": false,
	"chapter_first_die": false,
	"chapter_two": false,
	"chapter_three": false,
}

func _ready():
	load_unlocks()

func is_unlocked(chapter_key: String) -> bool:
	return chapter_unlocks.get(chapter_key, false)

func unlock_chapter(chapter_key: String) -> void:
	chapter_unlocks[chapter_key] = true
	save_unlocks()

func save_unlocks():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(chapter_unlocks)
	print("Saved unlocks:", chapter_unlocks)

func load_unlocks():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var loaded_data = file.get_var()
		print("Loaded unlocks:", loaded_data)
		if typeof(loaded_data) == TYPE_DICTIONARY:
			chapter_unlocks.merge(loaded_data, true)

func reset_unlocks():
	chapter_unlocks = {
		"chapter_intro": false, 
		"chapter_one": false,
		"chapter_first_die": false,
		"chapter_two": false,
		"chapter_three": false,
	}
	save_unlocks()
