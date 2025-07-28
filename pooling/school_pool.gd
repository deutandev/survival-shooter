extends ObjectPool
class_name SchoolPool

@export var gears_per_school: int = 4
@export var formation_radius: float = 40.0

func spawn_school_formation(spawn_position: Vector2) -> Array[Node]:
	var school_gears: Array[Node] = []
	
	# Get 4 gears from pool
	for i in range(gears_per_school):
		var gear = get_object()
		if gear:
			# Position in formation
			var angle = (i * PI * 2) / gears_per_school
			var offset = Vector2(cos(angle), sin(angle)) * formation_radius
			gear.global_position = spawn_position + offset
			school_gears.append(gear)
	
	return school_gears
