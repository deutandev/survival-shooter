extends TextureButton

@export var chapter_key: String
@onready var label_node := $Label

func _ready():
	update_label()

func update_label():
	if StorySaveManager.is_unlocked(chapter_key):
		label_node.text = "Unlocked"
	else:
		var price = StoryPurchaseManager.chapter_prices.get(chapter_key)
		label_node.text = str(price)
