extends Node

var chunk_data: Dictionary = {} # Maps Vector2i to custom data

func add_chunk(coords: Vector2i):
	if not chunk_data.has(coords):
		chunk_data[coords] = []

func save_chunk(coords: Vector2i, data):
	chunk_data[coords] = data

func retrieve_data(coords: Vector2i) -> Variant:
	if chunk_data.has(coords):
		return chunk_data[coords]
	return []
