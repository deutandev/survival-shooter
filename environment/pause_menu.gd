extends Control

@onready var pause_panel := $PausePanel
@onready var game_button_sfx := %GameButtonSfx

func _ready():
	resume()
	
func _process(_delta: float) -> void:
	isPressedEsc()

func resume():
	get_tree().paused = false
	pause_panel.visible = false 

func pause():
	get_tree().paused = true
	pause_panel.visible = true  

func isPressedEsc():
	if Input.is_action_just_pressed("escape") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()

func _on_resume_button_pressed() -> void:
	game_button_sfx.play()
	resume()


func _on_pause_button_pressed() -> void:
	game_button_sfx.play()
	await game_button_sfx.finished 
	pause()
