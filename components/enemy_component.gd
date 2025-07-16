extends Node
class_name EnemyComponent

# Base component that all enemy behaviors inherit from
var enemy: CharacterBody2D
var enemy_data: EnemyData

func _ready():
	enemy = get_parent() as CharacterBody2D

func initialize(data: EnemyData):
	enemy_data = data

func update(_delta: float):
	# Override in child components
	pass

func cleanup():
	# Override in child components for cleanup
	pass
