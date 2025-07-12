extends Area2D


@export var damage := 1
@export var speed := 1000.0
@export var shoot_range := 1200.0

var travelled_distance := 0.0
var direction

func _physics_process(delta: float) -> void:
	direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > shoot_range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
