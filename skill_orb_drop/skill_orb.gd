extends Area2D
class_name SkillOrb

@export var orb_data: SkillOrbData
@onready var sprite := $Sprite2D
@onready var audio := $AudioStreamPlayer2D

signal orb_collected

func _ready():
	sprite.texture = orb_data.sprite_texture
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player") and orb_data.effect_script:
		#audio.play()
		#await audio.finished 
		var effect = orb_data.effect_script.new()
		body.add_child(effect)
		effect.apply(body)
		audio.play()
		visible = false
		await audio.finished
		queue_free()
