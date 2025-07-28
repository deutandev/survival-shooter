extends Node2D

const MAIN_MENU_SCENE_PATH := "res://environment/main_menu/mainMenu.tscn"
const CHAPTER_INTRO_SCENE_PATH := "res://story/scene/chapter_prolog_panel.tscn"
const CHAPTER_ONE_SCENE_PATH := "res://story/scene/chapter_one_panel.tscn"
const CHAPTER_FIRST_DIE_SCENE_PATH := "res://story/scene/chapter_first_die_panel.tscn"
const CHAPTER_TWO_SCENE_PATH := "res://story/scene/chapter_two_panel.tscn"
const CHAPTER_THREE_SCENE_PATH := "res://story/scene/chapter_three_panel.tscn"

@onready var button_sfx := %AudioStreamPlayer2D

func _on_quit_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().quit()

func _on_back_to_menu_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)

func _on_story_chapter_intro_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(CHAPTER_INTRO_SCENE_PATH)

func _on_story_chapter_one_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(CHAPTER_ONE_SCENE_PATH)

func _on_story_chapter_first_die_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(CHAPTER_FIRST_DIE_SCENE_PATH)

func _on_story_chapter_two_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(CHAPTER_TWO_SCENE_PATH)

func _on_story_chapter_three_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(CHAPTER_THREE_SCENE_PATH)
