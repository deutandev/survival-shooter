extends Resource
class_name UpgradeData


enum UpgradeType { ADD, MULTIPLY }

@export var upgrade_type: UpgradeType = UpgradeType.ADD
@export var stat_name: String = "max_health" # target stat to affect
@export var amount: float = 20.0 # amount or multiplier
@export var label: String = "Upgrade Max HP"
@export var description: String = "+20 Max HP"
@export var icon: Texture2D
