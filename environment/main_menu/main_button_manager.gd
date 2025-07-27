extends Node

const GAMEPLAY_SCENE_PATH := "res://environment/map.tscn"
@onready var menu_button_sfx := %MenuButtonSfx

func _on_start_pressed() -> void:
	menu_button_sfx.play()
	await menu_button_sfx.finished 
	get_tree().change_scene_to_file(GAMEPLAY_SCENE_PATH)

func _on_quit_pressed() -> void:
	menu_button_sfx.play()
	await menu_button_sfx.finished 
	get_tree().quit()
	
