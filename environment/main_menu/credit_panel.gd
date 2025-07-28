extends Control

@onready var credit_panel := $CreditInfoPanel
@onready var button_sfx := %GameButtonSfx

func _ready() -> void:
	credit_close()

func credit_close():
	credit_panel.visible = false 

func credit_open():
	credit_panel.visible = true  

func _on_close_button_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	credit_close()


func _on_credit_button_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished 
	credit_open()
