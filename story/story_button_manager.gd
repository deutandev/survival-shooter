extends Node2D

const MAIN_MENU_SCENE_PATH := "res://environment/main_menu/mainMenu.tscn"

const CHAPTER_SCENES := {
	"chapter_intro": "res://story/scene/chapter_prolog_panel.tscn",
	"chapter_one": "res://story/scene/chapter_one_panel.tscn",
	"chapter_first_die": "res://story/scene/chapter_first_die_panel.tscn",
	"chapter_two": "res://story/scene/chapter_two_panel.tscn",
	"chapter_three": "res://story/scene/chapter_three_panel.tscn"
}

@onready var button_sfx := %AudioStreamPlayer2D
@onready var feedback_label := %FeedbackLabel

func _ready():
	StorySaveManager.load_unlocks()

func _on_chapter_button_pressed(chapter_key: String) -> void:
	button_sfx.play()
	await button_sfx.finished

	if StorySaveManager.is_unlocked(chapter_key):
		get_tree().change_scene_to_file(CHAPTER_SCENES[chapter_key])

	else:
		if StoryPurchaseManager.is_purchased(chapter_key):
			_update_button_label(chapter_key)
			get_tree().change_scene_to_file(CHAPTER_SCENES[chapter_key])
		else:
			_show_feedback("Not enough coins!")

func _on_back_to_menu_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)

func _show_feedback(text: String):
	feedback_label.text = text
	feedback_label.visible = true
	await get_tree().create_timer(2.0).timeout
	feedback_label.visible = false

func _update_button_label(chapter_key: String):
	for button in get_tree().get_nodes_in_group("chapter_buttons"):
		if button.chapter_key == chapter_key:
			button.update_label()
			break

func _on_story_chapter_intro_pressed() -> void:
	_on_chapter_button_pressed("chapter_intro")

func _on_story_chapter_one_pressed() -> void:
	_on_chapter_button_pressed("chapter_one")

func _on_story_chapter_first_die_pressed() -> void:
	_on_chapter_button_pressed("chapter_first_die")

func _on_story_chapter_two_pressed() -> void:
	_on_chapter_button_pressed("chapter_two")

func _on_story_chapter_three_pressed() -> void:
	_on_chapter_button_pressed("chapter_tree")
