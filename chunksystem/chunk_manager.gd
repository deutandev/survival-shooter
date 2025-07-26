extends Node2D
class_name ChunkManager

@export var chunk_scene: PackedScene
@export var chunk_size: Vector2i = Vector2i(5769, 3240)  # Large sprite-based chunk
@export var chunk_buffer: int = 1  # Radius around player
@export var available_images: Array[Texture2D]
@export var player: Node2D

var loaded_chunks: Dictionary = {}
var last_player_chunk := Vector2i(-999, -999)
var chosen_image: Texture2D

func _ready():
	chosen_image = available_images.pick_random()

func _process(_delta):
	var player_chunk := get_chunk_coords(player.global_position)
	if player_chunk != last_player_chunk:
		last_player_chunk = player_chunk
		update_loaded_chunks()

func get_chunk_coords(pos: Vector2) -> Vector2i:
	return Vector2i(floor(pos.x / chunk_size.x), floor(pos.y / chunk_size.y))

func update_loaded_chunks():
	var center := get_chunk_coords(player.global_position)
	var chunks_to_keep: Dictionary = {}

	for x in range(center.x - chunk_buffer, center.x + chunk_buffer + 1):
		for y in range(center.y - chunk_buffer, center.y + chunk_buffer + 1):
			var coords = Vector2i(x, y)
			chunks_to_keep[coords] = true
			if not loaded_chunks.has(coords):
				load_chunk(coords)

	for coords in loaded_chunks.keys():
		if not chunks_to_keep.has(coords):
			unload_chunk(coords)

func load_chunk(chunk_coords: Vector2i):
	var chunk = chunk_scene.instantiate()

	add_child(chunk)
	var world_pos = Vector2(chunk_coords.x * chunk_size.x, chunk_coords.y * chunk_size.y)
	chunk.position = world_pos
	chunk.set_coords(chunk_coords)
	chunk.set_image(chosen_image)

	loaded_chunks[chunk_coords] = chunk

func unload_chunk(chunk_coords: Vector2i):
	if loaded_chunks.has(chunk_coords):
		var chunk = loaded_chunks[chunk_coords]
		if is_instance_valid(chunk):
			chunk.queue_free()
		loaded_chunks.erase(chunk_coords)
