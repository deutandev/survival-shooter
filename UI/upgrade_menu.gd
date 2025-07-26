extends Control

@export var button_scene: PackedScene
@onready var container: HBoxContainer = $HBoxContainer
@export var target: Node  # <-- The player or entity to apply upgrades to
@onready var upgrade_manager = target.get_node("UpgradeManager")
@onready var upgrade_pool = $UpgradePool

var upgrade_options: Array[UpgradeData] = []


func _ready():
	show_random_upgrades()
	print(upgrade_pool)
	for upgrade in upgrade_options:
		var button = button_scene.instantiate()
		button.text = upgrade.label
		button.pressed.connect(func(): _apply_upgrade(upgrade, target))
		container.add_child(button)


func _apply_upgrade(upgrade: UpgradeData, upgrade_target: Node):
	print("Applied upgrade:", upgrade.amount)
	upgrade_manager.apply_upgrade(upgrade, upgrade_target)
	queue_free() # optionally close the menu


func show_random_upgrades():
	var random_3 = upgrade_pool.get_random_upgrades(3)
	print(random_3)
	for upgrade in random_3:
		upgrade_options.append(upgrade)
