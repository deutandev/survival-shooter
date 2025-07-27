extends Node
class_name SkillOrbDropManager

@export var skill_orb_scene: PackedScene
@export var orb_data_list: Array[SkillOrbData]

const DROP_CHANCE := 0.1

func drop_skill_orb(position: Vector2):
	if randf() <= DROP_CHANCE:
		var chosen_data: SkillOrbData = orb_data_list.pick_random()
		var orb = skill_orb_scene.instantiate() as Node2D
		orb.orb_data = chosen_data
		get_tree().current_scene.add_child(orb)
		orb.global_position = position
