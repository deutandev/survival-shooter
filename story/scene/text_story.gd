extends Control

@onready var story_text := $StoryText

var sentences: Array = []
var current_index := 0
var is_animating := false
var full_text := ""
var current_sentence := ""

const CHARS_PER_SECOND := 30.0

func _ready():
	# Get story based on global key
	var key = StoryContent.current_chapter_key
	if StoryContent.stories.has(key):
		sentences = StoryContent.stories[key]
		current_index = 0
		full_text = ""
		story_text.text = ""
		story_text.visible_ratio = 0.0
		show_next_sentence()
	else:
		story_text.text = "[Chapter not found: %s]" % key
		print("Missing chapter key:", key)

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

func show_next_sentence():
	is_animating = true
	current_sentence = sentences[current_index]
	full_text += "\n\n" + current_sentence
	story_text.text = full_text

	# Animate only the new part
	story_text.visible_ratio = float(full_text.length() - current_sentence.length()) / full_text.length()

	var duration := current_sentence.length() / CHARS_PER_SECOND
	var tween = create_tween()
	tween.tween_property(story_text, "visible_ratio", 1.0, duration)
	tween.tween_callback(Callable(self, "_on_tween_finished"))

	current_index += 1

func _on_tween_finished():
	is_animating = false
