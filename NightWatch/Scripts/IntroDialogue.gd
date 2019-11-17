extends Node

# gets Nodes as variables
onready var intro_script = get_node("/root/Intro")
onready var intro_anim = get_node("/root/Intro/AnimationPlayer")
onready var player_popup = get_node("/root/Intro/Popups/PlayerPopup")
onready var barry_popup = get_node("/root/Intro/Popups/BarryPopup")
onready var john_popup = get_node("/root/Intro/Popups/JohnPopup")
onready var barry_anim = get_node("/root/Intro/Crew/BarryClose/AnimationPlayer")
onready var barry_console_anim = get_node("/root/Intro/Crew/BarryConsole/AnimationPlayer")
onready var john_anim = get_node("/root/Intro/Crew/JohnClose/AnimationPlayer")
onready var audio_stream_player = get_node('/root/Main/AudioStreamPlayer')

func _ready():
	Global.player_close = true

# all the intro dialogue lines
func intro_dialogues(id):
	match id:
		"i1":
			return [["", ". . . scanning Quadrant 3, 216 to 322 degrees. Delta V looks good. Report on Quadrant 1, how are we looking Barry?"], ["i2"]]
		"i2":
			return [["Everything's fine mate.", "[ -- continue -- ]"], ["i3"]]
		"i3":
			return [["", "I beg your pardon, Barry?"], ["i4"]]
		"i4":
			return [["All good.", "[ -- continue --]"], ["i5"]]
		"i5":
			return [["", "Barry, I know we've been out here a long time but that doesn't give you licence to drop protocol whenever you feel like it. Got it?"], ["i6"]]
		"i6":
			return [["{sigh} Yes SIR Lieutenant SIR sorry SIR.", "[ -- continue -- ]"], ["i7"]]
		"i7":
			return [["", "Systems report, John?"], ["i8"]]
		"i8":
			return [["It's fine, it's whatever.", "[ -- continue -- ]"], ["i9"]]
		"i9":
			return [["", "JOHN."], ["i10"]]
		"i10":
			return [["What? What do you want me to say? It's exactly the same as it was last shift. We haven't done anything since the last shift. Nothing's changed. Nothing every changes. It's the SAME.", "[ -- continue -- ]"], ["i11"]]
		"i11":
			return [["", "What's gotten into you two?", "One more outburst like that and I'll have to file a report of insubordination!", "Are you sure nothing's changed?", "Well that's good to know."], ["i11a", "i11b", "i11c", "i11d"]]
		"i11a":
			return [["Nothing.", "[ -- continue -- ]"], ["i11a1"]]
		"i11a1":
			return [["Nothing.", "[ -- continue -- ]"], ["i11r"]]
		"i11r":
			return [["", "What's gotten into you two?", "One more outburst like that and I'll have to file a report of insubordination!", "Are you sure nothing's changed?", "Well that's good to know."], ["i11a", "i11b", "i11c", "i11d"]]
		"i11s":
			return [["", "What's gotten into you two?", "One more outburst like that and I'll have to file a report of insubordination!", "Are you sure nothing's changed?", "Well that's good to know."], ["i11a", "i11b", "i11c", "i11d"]]
		"i11b":
			return [["Oh no, not that. Anything but that.", "[ -- continue -- ]"], ["i11b1"]]
		"i11b1":
			return [["", "John, you are an Engineer in the Australian National Astrophysics League. Doesn't that mean anything to you?"], ["i11b1a"]]
		"i11b1a":
			return [["It means I get to spend the best years of my life in deep space.", "[ -- continue -- ]"], ["i11b1a1"]]
		"i11b1a1":
			return [["", "Exactly! It's the adventure of a lifetime!", "You don't sound very enthusiastic."], ["i11b1a1a", "i11b1a1b"]]
		"i11b1a1a":
			return [["Oh, it's a hoot.", "[ -- continue -- ]"], ["i11"]]
		"i11b1a1b":
			return [["Gee I wonder why.", "[ -- continue -- ]"], ["i11b1a1b1"]]
		"i11b1a1b1":
			return [["", "If you don't like it, you can always quit."], ["i11b1a1b1a"]]
		"i11b1a1b1a":
			return [["Wait, really?", "[ -- continue -- ]"], ["i11b1a1b1a1"]]
		"i11b1a1b1a1":
			return [["", "Of course. But that means you won't have access to any ship-distributed food."], ["i11b1a1b1a1a"]]
		"i11b1a1b1a1a":
			return [["Oh.", "[ -- continue -- ]"], ["i11b1a1b1a1a1"]]
		"i11b1a1b1a1a1":
			return [["", "Or oxygen."], ["i11b1a1b1a1a1a"]]
		"i11b1a1b1a1a1a":
			return [["Now all things considered, that doesn't sound so bad.", "[ -- continue -- ]"], ["i11"]]
		"i11c":
			return [["Yes, I'm sure.", "[ -- continue -- ]"], ["i11c1"]]
		"i11c1":
			return [["", "Did you look at your console?", "Are you really sure?", "Are you saying that because you're sure, or because you want me to stop asking about it?"], ["i11c1a", "i11c1b", "i11c1c"]]
		"i11c1a":
			return [["Yes.", "[ -- continue -- ]"], ["i11c1a1"]]
		"i11c1a1":
			return [["", "Well, okay. As long as you're sure that you're sure.", "John you've been looking directly at me the whole time."], ["i11c1a1a", "i11c1a1b"]]
		"i11c1a1a":
			return [["Yes, I'm sure that I'm sure.", "[ -- continue --]"], ["i11c1a1a1"]]
		"i11c1a1a1":
			return [["", "Surely you wouldn't say that you're sure that you're sure if you weren't really sure, because that sure would be a sure-fire way to ensure the failure of the mission."], ["i11c1a1a1a"]]
		"i11c1a1a1a":
			return [["I sure would like to end this conversation now.", "[ -- continue --]"], ["i11"]]
		"i11c1a1b":
			return [[". . .", "[ -- continue --]"], ["i11"]]
		"i11c1b":
			return [["Yes, I'm really sure.", "[ -- continue -- ]"], ["i11c1b1"]]
		"i11c1b1":
			return [["", "Are you really REALLY extra sure?"], ["i11c1b1a"]]
		"i11c1b1a":
			return [["Yes, I'm really REALLY extra sure. . .", "[ -- continue -- ]"], ["i11c1b1a1"]]
		"i11c1b1a1":
			return [["", "Are you really REALLY super-duper positive cross my EVA suit and hope to be blown out of the airlock extra sure?"], ["i11c1b1a1a"]]
		"i11c1b1a1a":
			return [["YES.", "[ -- continue -- ]"], ["i11c1b1a1a1"]]
		"i11c1b1a1a1":
			return [["", "Check your console anyway."], ["i11c1b1a1a1a"]]
		"i11c1b1a1a1a":
			return [["OKAY FINE.", "[ -- continue -- ]"], ["i11c1b1a1a1a1"]]
		"i11c1b1a1a1a1":
			return [["", "'Sir'."], ["i11c1b1a1a1a1a"]]
		"i11c1b1a1a1a1a":
			return [[". . . 'SIR'.", "[ -- continue -- ]"], ["i12"]]
		"i11c1c":
			return [["Take your pick.", "[ -- continue -- ]"], ["i11"]]
		"i11d":
			return [["Playing favourites, are we?", "[ -- continue -- ]"], ["i11d1"]]
		"i11d1":
			return [["", "What are you talking about?", "No.", "Of course not.", "Yes."], ["i11d1a", "i11d1b", "i11d1c", "i11d1d"]]
		"i11d1a":
			return [["You chew my ear off when I talk like that, but he gets away with anything.", "[ -- continue -- ]"], ["i11d1a1"]]
		"i11d1a1":
			return [["", "That's not true."], ["i11d1a1a"]]
		"i11d1a1a":
			return [["Yes it is.", "[ -- continue -- ]"], ["i11d1a1a1"]]
		"i11d1a1a1":
			return [["", "No it isn't."], ["i11d1a1a1a"]]
		"i11d1a1a1a":
			return [["Yes it is!", "[ -- continue -- ]"], ["i11d1a1a1a1"]]
		"i11d1a1a1a1":
			return [["", "No it isn't."], ["i11d1a1a1a1a"]]
		"i11d1a1a1a1a":
			return [["YES IT IS!", "[ -- continue -- ]"], ["i11d1a1a1a1a1"]]
		"i11d1a1a1a1a1":
			return [["", "Who's Lieutenant?"], ["i11d1a1a1a1a1a"]]
		"i11d1a1a1a1a1a":
			return [[". . . you are.", "[ -- continue -- ]"], ["i11r"]]
		"i11d1b":
			return [["It sure looks like it.", "[ -- continue -- ]"], ["i11r"]]
		"i11d1c":
			return [["Yeah, right.", "[ -- continue -- ]"], ["i11r"]]
		"i11d1d":
			return [[". . .", "[ -- continue -- ]"], ["i11s"]]
		"i12":
#			audio_stream_player.stream = load(Global.language_switch)
#			audio_stream_player.play()
			return [["See? Everything's . . . ", "[ -- continue -- ]"], ["i13"]]
		"i13":
			return [["", "Everything's . . .?"], ["i14"]]
		"i14":
			return [["Probably fine. SIR.", "[ -- continue -- ]"], ["i15"]]
		"i15":
			return [["", "Could you be a bit clearer on what you mean by 'probably', John?"], ["i16"]]
		"i16":
			return [["The system diagnostic looks the same as before, like I said. SIR.", "[ -- continue -- ]"], ["i17"]]
		"i17":
			return [["", "It LOOKS the same, or it IS the same?"], ["i18"]]
		"i18":
			return [["It LOOKS the same. SIR.", "[ -- continue -- ]"], ["i19"]]
		"i19":
			return [["", "So can you CONFIRM that it IS the same?"], ["i20"]]
		"i20":
			return [[". . .not exactly. SIR.", "[ -- continue -- ]"], ["i21"]]
		"i21":
			return [["", "Why not?"], ["i22"]]
		"i22":
			return [["My console is . . . in Russian.", "[ -- continue -- ]"], ["i23"]]
		"i23":
			return [["", "Your console is in Russian?"], ["i24"]]
		"i24":
			return [["My console appears to be in Russian. SIR.", "[ -- continue -- ]"], ["i25"]]
		"i25":
			return [["", "And can you explain why your console is in Russian, John?"], ["i26"]]
		"i26":
			return [["No.", "[ -- continue -- ]"], ["i27"]]
		"i27":
			return [["'SIR'.", "[ -- continue -- ]"], ["i28"]]
		"i28":
			return [["", " . . . "], ["i29"]]
		"i29":
			return [["", "Do you know anything about this, Barry?"], ["i30"]]
		"i30":
			return [["Um . . .", "[ -- continue -- ]"], ["i31"]]
		"i31":
			return [["Possibly.", "[ -- continue -- ]"], ["i32"]]
		"i32":
			return [["", "I really need a better answer than that, Barry. Why is John's console in Russian?"], ["i33"]]
		"i33":
			return [["Well. . . it was an accident.", "[ -- continue -- ]"], ["igo_on"]]
		"igo_on":
			return [["", "Go on. . . "], ["i34"]]
		"i34":
			return [["I was bored.", "[ -- continue -- ]"], ["i35"]]
		"i35":
			return [["So I was looking for a new hobby. And I thought hey, why not try learning another language?", "[ -- continue -- ]"], ["ialways"]]
		"ialways":
			return[["And I've always wanted to learn Russian.", "[ -- continue -- ]"], ["i36"]]
		"i36":
			return [["And they say immersion is the quickest way to pick up a new language, so I switched the ship's computer interface into Russian.", "[ -- continue -- ]"], ["i37"]]
		"i37":
			return [["But then I couldn't quite work out how to switch it back. . .", "[ -- continue -- ]"], ["iin_russian"]]
		"iin_russian":
			return [["Because of it being in Russian, and everything. . .", "[ -- continue -- ]"], ["i38"]]
		"i38":
			return [["It turns out language immersion takes a fairly long time.", "[ -- continue -- ]"], ["i39"]]
		"i39":
			return [["", "Are you saying you switched the ENTIRE SHIP'S COMPUTER INTERFACE?"], ["i40"]]
		"i40":
			return [["Uh. . . yes.", "[ -- continue -- ]"], ["i41"]]
		"i41":
			return [["", "But that's going to affect everyone's cons. . ."], ["i42"]]
		"i42":
			return [["", ". . ."], ["i43"]]
		"i43":
			return [["", "Oh Barry, you idiot."], ["i44"]]
		"i44":
			return [["I feel really bad about it, Sir.", "[ -- continue -- ]"], ["i45"]]
		"i45":
			return [["Computer's voice recognition should still be working though.", "[ -- continue -- ]"], ["i46"]]
		"i46":
			return [["", "COMPUTER!"], ["i47"]]
		"i47":
			return [["", "{ КОМПЮТЕР } ЧЕГО? ДАВАЙ БЫСТРЕЕ, Я ЗАНЯТ."], ["i48"]]
		"i48":
			return [["", "Barry, you complete idiot."], ["end_intro"]]


# the sequence of dialogue and animations/transitions in the intro
func intro_sequence(button_id):
	match button_id:
		"i2":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			# the previous dialogue and current dialogue is from the Player to Barry
			player_to_barry(button_id)
		"i3":
			# the previous dialogue and current dialogue is from Barry to the Player
			barry_to_player(button_id)
		"i4":
			player_to_barry(button_id)
		"i5":
			barry_to_player(button_id)
		"i6":
			player_to_barry(button_id)
		"i7":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"i8":
			# the previous dialogue and current dialogue is from the Player to John
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i9":
			john_to_player(button_id)
		"i10":
			player_to_john(button_id)
		"i11":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"i11a":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i11a1":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_barry(button_id)
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
		"i11r":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"i11s":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlowOut')
			barry_to_player(button_id)
		"i11b":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i11b1":
			john_to_player(button_id)
		"i11b1a":
			player_to_john(button_id)
		"i11b1a1":
			john_to_player(button_id)
		"i11b1a1a":
			player_to_john(button_id)
		"i11b1a1b":
			player_to_john(button_id)
		"i11b1a1b1":
			john_to_player(button_id)
		"i11b1a1b1a":
			player_to_john(button_id)
		"i11b1a1b1a1":
			john_to_player(button_id)
		"i11b1a1b1a1a":
			player_to_john(button_id)
		"i11b1a1b1a1a1":
			john_to_player(button_id)
		"i11b1a1b1a1a1a":
			player_to_john(button_id)
		"i11c":
			player_to_john(button_id)
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
		"i11c1":
			john_to_player(button_id)
		"i11c1a":
			player_to_john(button_id)
		"i11c1a1":
			john_to_player(button_id)
		"i11c1a1a":
			player_to_john(button_id)
		"i11c1a1a1":
			john_to_player(button_id)
		"i11c1a1a1a":
			player_to_john(button_id)
		"i11c1a1b":
			player_to_john(button_id)
		"i11c1b":
			player_to_john(button_id)
		"i11c1b1":
			john_to_player(button_id)
		"i11c1b1a":
			player_to_john(button_id)
		"i11c1b1a1":
			john_to_player(button_id)
		"i11c1b1a1a":
			player_to_john(button_id)
		"i11c1b1a1a1":
			john_to_player(button_id)
		"i11c1b1a1a1a":
			player_to_john(button_id)
		"i11c1b1a1a1a1":
			john_to_player(button_id)
		"i11c1b1a1a1a1a":
			player_to_john(button_id)
		"i11c1c":
			player_to_john(button_id)
		"i11d":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"i11d1":
			barry_to_player(button_id)
		"i11d1a":
			player_to_barry(button_id)
		"i11d1a1":
			barry_to_player(button_id)
		"i11d1a1a":
			player_to_barry(button_id)
		"i11d1a1a1":
			barry_to_player(button_id)
		"i11d1a1a1a":
			player_to_barry(button_id)
		"i11d1a1a1a1":
			barry_to_player(button_id)
		"i11d1a1a1a1a":
			player_to_barry(button_id)
		"i11d1a1a1a1a1":
			barry_to_player(button_id)
		"i11d1a1a1a1a1a":
			player_to_barry(button_id)
		"i11d1b":
			player_to_barry(button_id)
		"i11d1c":
			player_to_barry(button_id)
		"i11d1d":
			player_to_barry(button_id)
		"i12":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			player_to_john(button_id)
		"i13":
			john_to_player(button_id)
		"i14":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			barry_console_anim.play('BarryConsoleSlowOut')
			player_to_john(button_id)
		"i15":
			john_to_player(button_id)
		"i16":
			player_to_john(button_id)
		"i17":
			john_to_player(button_id)
		"i18":
			player_to_john(button_id)
		"i19":
			john_to_player(button_id)
		"i20":
			player_to_john(button_id)
		"i21":
			john_to_player(button_id)
		"i22":
			player_to_john(button_id)
		"i23":
			john_to_player(button_id)
		"i24":
			player_to_john(button_id)
		"i25":
			john_to_player(button_id)
		"i26":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			player_to_john(button_id)
		"i27":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i28":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"i29":
			john_to_player(button_id)
		"i30":
			barry_console_anim.play('BarryConsoleFastIn')
			player_to_barry(button_id)
		"i31":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"i32":
			barry_to_player(button_id)
		"i33":
			player_to_barry(button_id)
		"igo_on":
			barry_to_player(button_id)
		"i34":
			player_to_barry(button_id)
		"i35":
			player_to_barry(button_id)
		"ialways":
			player_to_barry(button_id)
		"i36":
			player_to_barry(button_id)
		"i37":
			player_to_barry(button_id)
		"iin_russian":
			player_to_barry(button_id)
		"i38":
			player_to_barry(button_id)
		"i39":
			barry_to_player(button_id)
		"i40":
			player_to_barry(button_id)
		"i41":
			barry_to_player(button_id)
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
		"i42":
			barry_to_player(button_id)
		"i43":
			barry_to_player(button_id)
		"i44":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"i45":
			barry_popup.hide()
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i46":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"i47":
			john_to_player(button_id)
		"i48":
			john_to_player(button_id)
		"end_intro":
			intro_anim.play("FadeOut")


# sets the dialogue box transition from the Player to Barry
func player_to_barry(button_id):
	player_popup.hide()
	barry_popup.show()
	barry_popup.set_text(intro_dialogues(button_id))


# sets the dialogue box transition from the Player to John
func player_to_john(button_id):
	player_popup.hide()
	john_popup.show()
	john_popup.set_text(intro_dialogues(button_id))


# sets the dialogue box transition from Barry to the Player
func barry_to_player(button_id):
	barry_popup.hide()
	player_popup.show()
	player_popup.set_text(intro_dialogues(button_id))


# sets the dialogue box transition from John to the Player
func john_to_player(button_id):
	john_popup.hide()
	player_popup.show()
	player_popup.set_text(intro_dialogues(button_id))


func john_to_barry(button_id):
	john_popup.hide()
	barry_popup.show()
	barry_popup.set_text(intro_dialogues(button_id))
