extends Node2D

@onready var narration_scene := preload("res://story/chapter_text_panel.tscn") # Your modular narration scene

var chapter_data = {
	"chapter_1": [
		"Chapter 1",
		"It is the day of your first duty as Watchmen, you're almost late.",
		"As you make your way to your stationed post, you waved to the people of Thyme City...",
		"When you arrived, another Watchmen greeted you...",
		"Surely you won't fail on the first day of the job right?",
		"- End of Chapter One -"
	],
	"chapter_2": [
		"Chapter 2",
		"You wake up with a heavy head and memories of yesterday...",
		"The city is quiet. Too quiet.",
		"- End of Chapter Two -"
	]
}

func _on_story_chapter_one_pressed():
	load_chapter("chapter_1")

func _on_story_chapter_two_pressed():
	load_chapter("chapter_2")

func load_chapter(chapter_name: String):
	var chapter_sentences = chapter_data.get(chapter_name, [])
	if chapter_sentences.is_empty():
		push_error("Chapter not found or has no content.")
		return

	var narration_instance = narration_scene.instantiate()
	narration_instance.sentences = chapter_sentences
	get_tree().current_scene.add_child(narration_instance)
