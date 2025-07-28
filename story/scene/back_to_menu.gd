extends TextureButton

const STORY_SCENE_PATH := "res://story/scene/story_scene.tscn"
@onready var button_sfx := %AudioStreamPlayer2D

func _on_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	get_tree().change_scene_to_file(STORY_SCENE_PATH)
