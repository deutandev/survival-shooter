extends Node2D

@export var object_scene: PackedScene
@export var object_count := 100

var object_pool := []
var object_index := 0

func _ready() -> void:
	# object_scene should be assigned via the inspector or with a constant path
	for i in range(object_count):
		var obj = object_scene.instantiate()
		object_pool.append(obj)
		add_child(obj)
		
		# Connect to the object's died signal for automatic reset
		if obj.has_signal("died"):
			obj.died.connect(_on_object_died)
		
		reset_object(obj)

func reset_object(obj) -> void:
	var collider = obj.get_node("CollisionShape2D")
	obj.visible = false
	obj.set_physics_process(false)
	obj.set_process(false)
	collider.call_deferred("set_disabled", true)
	
	# Reset mob-specific properties
	if obj.has_method("reset_mob"):
		obj.call_deferred("reset_mob")

func get_object() -> Node2D:
	# Circular buffer - wrap around when reaching the end
	if object_index >= object_count:
		object_index = 0
	
	var obj = object_pool[object_index]
	var collider = obj.get_node("CollisionShape2D")
	
	object_index += 1
	obj.visible = true
	obj.set_physics_process(true)
	obj.set_process(true)
	collider.call_deferred("set_disabled", false)
	
	# Apply enemy data to the mob
	#if object_data and obj.has_method("apply_enemy_data"):
		#obj.apply_enemy_data(object_data)
	
	return obj

func _on_object_died(obj: Node2D) -> void:
	# Reset the object when it dies (makes it available for reuse)
	call_deferred("reset_object", obj)
