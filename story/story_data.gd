extends Node

# Stores unlocked status for chapters (true = unlocked)
var chapter_unlocks := {
	"chapter_intro": false,  
	"chapter_one": false,
	"chapter_first_die": false,
	"chapter_two": false,
	"chapter_three": false,
}

func is_unlocked(chapter_key: String) -> bool:
	return chapter_unlocks.get(chapter_key, false)

func unlock_chapter(chapter_key: String) -> void:
	chapter_unlocks[chapter_key] = true

func save_data():
	var save = FileAccess.open("user://story_data.save", FileAccess.WRITE)
	save.store_var(chapter_unlocks)

func load_data():
	if FileAccess.file_exists("user://story_data.save"):
		var save = FileAccess.open("user://story_data.save", FileAccess.READ)
		chapter_unlocks = save.get_var()
