extends Node

const GAMEPLAY_SCENE_PATH := "res://environment/map.tscn"
const STORY_SCENE_PATH := "res://story/scene/story_scene.tscn"
@onready var menu_button_sfx := %MenuButtonSfx

func _on_start_pressed() -> void:
	menu_button_sfx.play()
	await menu_button_sfx.finished 
	await Fade.fade_out().finished
	get_tree().change_scene_to_file(GAMEPLAY_SCENE_PATH)
	Fade.fade_in()

func _on_quit_pressed() -> void:
	menu_button_sfx.play()
	await menu_button_sfx.finished 
	get_tree().quit()

func _on_story_button_pressed() -> void:
	menu_button_sfx.play()
	await menu_button_sfx.finished 
	Fade.fade_out()
	get_tree().change_scene_to_file(STORY_SCENE_PATH)
	Fade.fade_in()

func _on_credit_button_pressed() -> void:
	pass # Replace with function body.
