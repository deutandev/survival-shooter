extends Node

@export var chapter_prices := {
	"chapter_intro": 5,
	"chapter_one": 5,
	"chapter_first_die": 5,
	"chapter_two": 5,
	"chapter_three": 5,
}

func is_purchased(chapter_key: String) -> bool:
	if StorySaveManager.is_unlocked(chapter_key):
		return true

	var price = chapter_prices.get(chapter_key, -1)
	if price < 0:
		return false

	if CoinData.total_coins >= price:
		CoinData.add_to_total_coins(-price)
		StorySaveManager.unlock_chapter(chapter_key)
		return true
	return false
