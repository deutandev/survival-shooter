extends Control

@onready var story_text := $StoryText

var sentences = [
	"Intro",
	"You live in a world of chaos. You are one of the last hopes for your kin. You are blessed with the power of Time. You are a Watchmen.",
	"Each time you fall, you become stronger than before—maybe you learn something new or you just realize something.",
	"Is it because of the blessing of Time?",
	"Or is it because of the resolve you have for being a Watchmen?",
	"Or maybe it's because of who you actually are?",
	"Only Time can tell...",
	"- End of Intro -"
]

var current_index := 0
var is_animating := false
var full_text := ""
var current_sentence := ""

const CHARS_PER_SECOND := 30.0  # static speed

func _ready():
	story_text.text = ""
	story_text.visible_ratio = 0.0
	show_next_sentence()

func _input(event):
	if event.is_action_pressed("click") or event.is_action_pressed("interact"):
		if is_animating:
			story_text.visible_ratio = 1.0
			is_animating = false
		else:
			if current_index < sentences.size():
				show_next_sentence()
			else:
				print("Narration complete!")
				return

func show_next_sentence():
	is_animating = true
	current_sentence = sentences[current_index]
	full_text += "\n\n" + current_sentence
	story_text.text = full_text

	# Start animation from the point before this sentence
	story_text.visible_ratio = float(full_text.length() - current_sentence.length()) / full_text.length()

	var duration := current_sentence.length() / CHARS_PER_SECOND
	var tween = create_tween()
	tween.tween_property(story_text, "visible_ratio", 1.0, duration)
	tween.tween_callback(Callable(self, "_on_tween_finished"))

	current_index += 1

func _on_tween_finished():
	is_animating = false
