extends Node

var current_chapter_key: String = ""

var stories := {
	"chapter_intro": [
		"Intro",
		"You live in a world of chaos. You are one of the last hopes for your kin. You are blessed with the power of Time. You are a Watchmen.",
		"Each time you fall, you become stronger than before—maybe you learn something new or you just realize something.",
		"Is it because of the blessing of Time?",
		"Or is it because of the resolve you have for being a Watchmen?",
		"Or maybe it's because of who you actually are?",
		"Only Time can tell...",
		"- End of Intro -"
	],
	"chapter_first_die": [
		"First Die",
		"You died,",
		"Or at least you thought you died.",
		"You wake up in your post, just standing there as you watch other Watchmen fight against the tide of enemies.",
		"You try to talk to other Watchmen.",
		"\"Did I just die?\"",
		"They look confused, asking if you're okay or if there's something wrong with you **today**.",
		"You must be imagining things... or maybe you're just having a bad dream.",
		"Who knows?",
		"Maybe the Writer knows :3",
		"- End of First Die -"
	],
	"chapter_one": [
		"Chapter 1",
		"It is the day of your first duty as Watchmen, you're almost late.",
		"As you make your way to your stationed post, you waved to the people of Thyme City, the last standing city in this world, to give them hope of surviving.",
		"When you arrived, another Watchmen greeted you and showed you the ropes of being a Watchmen, then gives your equipment.",
		"Surely you won't fail on the first day of the job right?",
		"- End of Chapter One -"
	],
	"chapter_two": [
		"Chapter 2",
		"Congratulations, you have survived this long.",
		"Maybe you have some questions, maybe you don't.",
		"You feel some things are different.",
		"You feel someone is missing.",
		"It feels quieter each time passes.",
		"You hesitate, whether to keep on struggling in this meaningless battle or to run and find out the truth.",
		"As you're about to make the choice...",
		"Duty calls.",
		"- End of Chapter Two -"
	],
	"chapter_three": [
		"Chapter 3",
		"You just got hit by the enemy—it was different than the usual.",
		"You didn't **die** just like before.",
		"You hit it back and you heard a familiar voice.",
		"\"Wa...ke...up...\"",
		"Yes, it was someone you knew before.",
		"Someone close to you.",
		"Someone dear to you.",
		"\"You're...our...last...ho-\"",
		"Suddenly it becomes clear to you.",
		"It's actually one of your teammates—it was a Watchmen.",
		"Yes, you just _killed_ your own kin.",
		"To be continued...",
		"- End of Chapter Three -"
	],
}
