extends Node2D
class_name ChunkNode

@onready var sprite: Sprite2D = $SpriteMapBg
var chunk_coords: Vector2i

func set_coords(coords: Vector2i):
	chunk_coords = coords

func set_image(image: Texture2D):
	if sprite and image:
		sprite.texture = image
