extends Node2D
class_name ChunkManager

@export var chunk_scene: PackedScene
@export var chunk_size: Vector2i = Vector2i(5769, 3240)
@export var load_radius: int = 2 

@export var player: CharacterBody2D
var loaded_chunks: Dictionary = {}

func _ready():
	update_loaded_chunks() # Initial load
	set_process(true)

func _process(_delta):
	update_loaded_chunks()

func update_loaded_chunks():
	if not player:
		return

	var player_chunk = get_chunk_coords(player.global_position)

	# Load surrounding chunks
	for x in range(-load_radius, load_radius + 1):
		for y in range(-load_radius, load_radius + 1):
			var chunk_coords = player_chunk + Vector2i(x, y)
			if not loaded_chunks.has(chunk_coords):
				load_chunk(chunk_coords)

	# Unload far-away chunks
	var to_unload: Array = []
	for coords in loaded_chunks.keys():
		if coords.distance_to(player_chunk) > load_radius:
			to_unload.append(coords)

	for coords in to_unload:
		unload_chunk(coords)

func get_chunk_coords(pos: Vector2) -> Vector2i:
	return Vector2i(floor(pos.x / chunk_size.x), floor(pos.y / chunk_size.y))

func load_chunk(chunk_coords: Vector2i):
	var chunk = chunk_scene.instantiate()
	var world_pos = Vector2(chunk_coords.x * chunk_size.x, chunk_coords.y * chunk_size.y)
	chunk.position = world_pos

	if chunk.has_method("init_chunk"):
		chunk.init_chunk(chunk_coords)

	add_child(chunk)
	loaded_chunks[chunk_coords] = chunk

	# Restore data if any
	var saved_data = WorldSave.retrieve_data(chunk_coords)
	if chunk.has_method("load_data"):
		chunk.load_data(saved_data)

func unload_chunk(chunk_coords: Vector2i):
	var chunk = loaded_chunks[chunk_coords]
	if chunk and chunk.has_method("get_data_to_save"):
		var data = chunk.get_data_to_save()
		WorldSave.save_chunk(chunk_coords, data)

	chunk.queue_free()
	loaded_chunks.erase(chunk_coords)
