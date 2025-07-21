extends CharacterData
class_name EnemyData

@export var damage: int = 5
@export var exp_value: int = 10

@export var movement_type: MovementType = MovementType.CHASE

enum MovementType {
	CHASE
}
