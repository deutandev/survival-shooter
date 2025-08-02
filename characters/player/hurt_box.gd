extends Area2D

signal enemy_entered(enemy: Node2D)
signal enemy_exited(enemy: Node2D)

func _ready():
	monitoring = true
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node2D):
	if body.is_in_group("enemy"):
		print("ENEMY ENTERED:", body.name)
		enemy_entered.emit(body)

func _on_body_exited(body: Node2D):
	if body.is_in_group("enemy"):
		print("ENEMY EXITED:", body.name)
		enemy_exited.emit(body)
