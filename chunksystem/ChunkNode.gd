extends Node2D
class_name ChunkNode

var coords: Vector2i
var content_data = [] # Store whatever you want (e.g., tile IDs, objects)

func init_chunk(chunk_coords: Vector2i):
	coords = chunk_coords
	# Optional: generate tiles, objects, etc.

func load_data(data):
	content_data = data
	# Optional: use data to restore tile state, etc.

func get_data_to_save():
	return content_data
