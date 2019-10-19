extends Node

# gets Nodes from the main scene as variables
onready var main_script = get_node("/root/Main")
onready var player_popup = get_node("/root/Main/Popups/PlayerPopup")
onready var barry_popup = get_node("/root/Main/Popups/BarryPopup")
onready var john_popup = get_node("/root/Main/Popups/JohnPopup")
onready var barry_anim = get_node("/root/Main/BackgroundArea/BarryClose/AnimationPlayer")
onready var barry_console_anim = get_node("/root/Main/BackgroundArea/BarryConsole/AnimationPlayer")
onready var john_anim = get_node("/root/Main/BackgroundArea/JohnClose/AnimationPlayer")


func _ready():
	main_script.player_close = true

# all the intro dialogue lines
func intro_dialogues(id):
	match id:
		"i1":
			return [["", ". . . scanning Quadrant 3, 216 to 322 degrees. Delta V looks good. Report on Quadrant 1, how are we looking Barry?"], ["0", "i2"]]
		"i2":
			return [["Everything's fine mate.", "[ -- continue -- ]"], ["0", "i3"]]
		"i3":
			return [["", "I beg your pardon, Barry?"], ["0", "i4"]]
		"i4":
			return [["All good.", "[ -- continue --]"], ["0", "i5"]]
		"i5":
			return [["", "Barry, I know we've been out here a long time but that doesn't give you license to drop protocol whenever you feel like it. Got it?"], ["0", "i6"]]
		"i6":
			return [["{sigh} Yes [i]SIR[/i] Lieutenant [i]SIR[/i] sorry [i]SIR[/i].", "[ -- continue -- ]"], ["0", "i7"]]
		"i7":
			return [["", "Systems report, John?"], ["0", "i8"]]
		"i8":
			return [["It's fine, it's whatever.", "[ -- continue -- ]"], ["0", "i9"]]
		"i9":
			return [["", "JOHN."], ["0", "i10"]]
		"i10":
			return [["What? What do you want me to say? It's exactly the same as it was last shift. We haven't done anything since the last shift. It's all the same as the last shift.", "[ -- continue -- ]"], ["0", "i11"]]
		"i11":
			return [["", "What's gotten into you two?", "One more outburst like that and I'll have to file a report of insubordination!", "Are you sure nothing's changed?", "Well that's good to know."], ["0", "i11a", "i11b", "i11c", "i11d"]]
		"i11a":
			return [["Nothing.", "[ -- continue -- ]"], ["0", "i11a1"]]
		"i11a1":
			return [["Nothing.", "[ -- continue -- ]"], ["0", "i11r"]]
		"i11r":
			return [["", "What's gotten into you two?", "One more outburst like that and I'll have to file a report of insubordination!", "Are you sure nothing's changed?", "Well that's good to know."], ["0", "i11a", "i11b", "i11c", "i11d"]]
		"i11b":
			return [["Oh no, not that. Anything but that.", "[ -- continue -- ]"], ["0", "i11b1"]]
		"i11b1":
			return [["", "John, you are an Engineer in the Australian National Astrophysics League. What does that mean to you?"], ["0", "i11b1a"]]
		"i11b1a":
			return [["It means I get to spend the best years of my life in deep space.", "[ -- continue -- ]"], ["0", "i11b1a1"]]
		"i11b1a1":
			return [["", "Exactly! It's the adventure of a lifetime!", "You don't sound very enthusiastic."], ["0", "i11b1a1a", "i11b1a1b"]]
		"i11b1a1a":
			return [["Oh, it's a hoot.", "[ -- continue -- ]"], ["0", "i11"]]
		"i11b1a1b":
			return [["Gee I wonder why.", "[ -- continue -- ]"], ["0", "i11b1a1b1"]]
		"i11b1a1b1":
			return [["", "If you don't like it, you can always quit."], ["0", "i11b1a1b1a"]]
		"i11b1a1b1a":
			return [["Wait, really?", "[ -- continue -- ]"], ["0", "i11b1a1b1a1"]]
		"i11b1a1b1a1":
			return [["", "Of course. But that means you won't have access to any ship-distributed food."], ["0", "i11b1a1b1a1a"]]
		"i11b1a1b1a1a":
			return [["Oh.", "[ -- continue -- ]"], ["0", "i11b1a1b1a1a1"]]
		"i11b1a1b1a1a1":
			return [["", "Or oxygen."], ["0", "i11b1a1b1a1a1a"]]
		"i11b1a1b1a1a1a":
			return [["Now all things considered, that doesn't sound so bad.", "[ -- continue -- ]"], ["0", "i11"]]
		"i11c":
			return [["Yes, I'm sure.", "[ -- continue -- ]"], ["0", "i11c1"]]
		"i11c1":
			return [["", "Are you really sure?"], ["0", "i11c1a"]]
		"i11c1a":
			return [["Yes, I'm really sure.", "[ -- continue -- ]"], ["0", "i11c1a1"]]
		"i11c1a1":
			return [["", "Are you really REALLY extra sure?"], ["0", "i11c1a1a"]]
		"i11c1a1a":
			return [["Yes, I'm really REALLY extra sure. . .", "[ -- continue -- ]"], ["0", "i11c1a1a1"]]
		"i11c1a1a1":
			return [["", "Are you really REALLY super-duper positive cross-my-EVA-suit-and-hope-to-be-blown-out-of-the-airlock extra sure?"], ["0", "i11c1a1a1a"]]
		"i11c1a1a1a":
			return [["YES.", "[ -- continue -- ]"], ["0", "i11c1a1a1a1"]]
		"i11c1a1a1a1":
			return [["", "Check your console anyway."], ["0", "i11c1a1a1a1a"]]
		"i11c1a1a1a1a":
			return [["OKAY FINE.", "[ -- continue -- ]"], ["0", "i11c1a1a1a1a1"]]
		"i11c1a1a1a1a1":
			return [["", "'Sir'."], ["0", "i11c1a1a1a1a1a"]]
		"i11c1a1a1a1a1a":
			return [[". . . 'SIR'.", "[ -- continue -- ]"], ["0", "i12"]]
		"i11d":
			return [["Playing favourites, are we?", "[ -- continue -- ]"], ["0", "i11d1"]]
		"i11d1":
			return [["", "What are you talking about?", "No.", "Of course not.", "Yes."], ["0", "i11d1a", "i11d1b", "i11d1c", "i11d1d"]]
		"i11d1a":
			return [["You chew my ear off when I talk like that, but he gets away with anything.", "[ -- continue -- ]"], ["0", "i11d1a1"]]
			
		"i11d1a1":
			return [["", "That's not true."], ["0", "i11d1a1a"]]
			
		"i11d1a1a":
			return [["Yes it is.", "[ -- continue -- ]"], ["0", "i11d1a1a1"]]
			
		"i11d1a1a1":
			return [["", "No it isn't."], ["0", "i11d1a1a1a"]]
			
		"i11d1a1a1a":
			return [["Yes it is!", "[ -- continue -- ]"], ["0", "i11d1a1a1a1"]]
			
		"i11d1a1a1a1":
			return [["", "No it isn't."], ["0", "i11d1a1a1a1a"]]
			
		"i11d1a1a1a1a":
			return [["YES IT IS!", "[ -- continue -- ]"], ["0", "i11d1a1a1a1a1"]]
			
		"i11d1a1a1a1a1":
			return [["", "Who's Lieutenant?"], ["0", "i11d1a1a1a1a1a"]]
			
		"i11d1a1a1a1a1a":
			return [[". . . you are.", "[ -- continue -- ]"], ["0", "i11r"]]
		"i11d1b":
			return [["It sure looks like it.", "[ -- continue -- ]"], ["0", "i11r"]]
		"i11d1c":
			return [["Yeah, right.", "[ -- continue -- ]"], ["0", "i11r"]]
		"i11d1d":
			return [["I knew it.", "[ -- continue -- ]"], ["0", "i11r"]]
		"i12":
			return [["See? Everything's . . . ", "[ -- continue -- ]"], ["0", "i13"]]
		"i13":
			return [["", "Everything's . . .?"], ["0", "i14"]]
		"i14":
			return [["Probably fine. SIR.", "[ -- continue -- ]"], ["", "i15"]]
		"i15":
			return [["", "Could you be a bit clearer on what you mean by 'probably', John?"], ["0", "i16"]]
		"i16":
			return [["The system diagnostic looks the same as before, like I said. SIR.", "[ -- continue -- ]"], ["0", "i17"]]
		"i17":
			return [["", "It LOOKS the same, or it IS the same?"], ["0", "i18"]]
		"i18":
			return [["It LOOKS like it IS the same. SIR", "[ -- continue -- ]"], ["0", "i19"]]
		"i19":
			return [["", "So can you CONFIRM that it IS the same?"], ["0", "i20"]]
		"i20":
			return [[". . .not exactly. SIR.", "[ -- continue -- ]"], ["0", "i21"]]
		"i21":
			return [["", "Why not?"], ["0", "i22"]]
		"i22":
			return [["My console is . . . in Russian.", "[ -- continue -- ]"], ["0", "i23"]]
		"i23":
			return [["", "Your console is in Russian?"], ["0", "i24"]]
		"i24":
			return [["My console appears to be in Russian. SIR.", "[ -- continue -- ]"], ["0", "i25"]]
		"i25":
			return [["", "And can you explain why your console is in Russian, John?"], ["0", "i26"]]
		"i26":
			return [["No.", "[ -- continue -- ]"], ["0", "i27"]]
		"i27":
			return [["'SIR'.", "[ -- continue -- ]"], ["0", "i28"]]
		"i28":
			return [["", " . . . "], ["0", "i29"]]
		"i29":
			return [["", "Do you know anything about this, Barry?"], ["0", "i30"]]
		"i30":
			return [["Um . . .", "[ -- continue -- ]"], ["0", "i31"]]
		"i31":
			return [["Possibly.", "[ -- continue -- ]"], ["0", "i32"]]
		"i32":
			return [["", "I really need a better answer than that, Barry. Why is John's console in Russian?"], ["0", "i33"]]
		"i33":
			return [["Well, it was an accident.", "[ -- continue -- ]"], ["0", "i34"]]
		"i34":
			return [["I was bored.", "[ -- continue -- ]"], ["0", "i35"]]
		"i35":
			return [["So I was looking for a new hobby. And I thought hey, why not try learning another language?", "[ -- continue -- ]"], ["0", "i36"]]
		"i36":
			return [["And they say immersion is the quickest way to pick up a new language, so I switched the ship's computer interface into Russian.", "[ -- continue -- ]"], ["0", "i37"]]
		"i37":
			return [["And I couldn't quite work out how to switch it back.", "[ -- continue -- ]"], ["0", "i38"]]
		"i38":
			return [["It turns out language immersion takes a fairly long time.", "[ -- continue -- ]"], ["0", "i39"]]
		"i39":
			return [["", "You said you switched the SHIP'S COMPUTER INTERFACE into Russian?"], ["0", "i40"]]
		"i40":
			return [["Uh, yes Sir.", "[ -- continue -- ]"], ["0", "i41"]]
		"i41":
			return [["", "But that's going to affect everyone's cons. . ."], ["0", "i42"]]
		"i42":
			return [["", ". . ."], ["0", "i43"]]
		"i43":
			return [["", "Oh Barry, you idiot."], ["0", "i44"]]
		"i44":
			return [["I feel really bad about it, Sir.", "[ -- console -- ]"], ["0", "i45"]]
		"i45":
			return [["Computer's voice recognition should still be working though.", "[ -- continue -- ]"], ["0", "i46"]]
		"i46":
			return [["", "COMPUTER!"], ["0", "i47"]]
		"i47":
			return [["", "{ KOMPYUTER } CHEGO? DAVAY BYSTREE, YA ZANYAT!"], ["0", "i48"]]
		"i48":
			return [["", "Barry, you complete idiot."], ["0", "end"]]



# the sequence of dialogue and animations/transitions in the intro
func intro_sequence(button_id):
	match button_id:
		"i2":
			main_script.barry_close = true
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
			main_script.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"i8":
			# the previous dialogue and current dialogue is from the Player to John
			main_script.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i9":
			john_to_player(button_id)
		"i10":
			player_to_john(button_id)
		"i11":
			main_script.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"i11a":
			main_script.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i11a1":
			main_script.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_barry(button_id)
			main_script.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
		"i11r":
			main_script.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"i11b":
			main_script.john_close = true
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
			main_script.john_close = true
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
		"i11c1a1a1a1":
			john_to_player(button_id)
		"i11c1a1a1a1a":
			player_to_john(button_id)
		"i11c1a1a1a1a1":
			john_to_player(button_id)
		"i11c1a1a1a1a1a":
			player_to_john(button_id)
		"i11d":
			main_script.barry_close = true
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
			main_script.john_close = false
			john_anim.play('JohnCloseSlideOut')
			player_to_john(button_id)
		"i13":
			john_to_player(button_id)
		"i14":
			main_script.john_close = true
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
			main_script.john_close = false
			john_anim.play('JohnCloseSlideOut')
			player_to_john(button_id)
		"i27":
			main_script.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i28":
			main_script.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"i29":
			john_to_player(button_id)
		"i30":
			barry_console_anim.play('BarryConsoleFastIn')
			player_to_barry(button_id)
		"i31":
			main_script.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"i32":
			barry_to_player(button_id)
		"i33":
			player_to_barry(button_id)
		"i34":
			player_to_barry(button_id)
		"i35":
			player_to_barry(button_id)
		"i36":
			player_to_barry(button_id)
		"i37":
			player_to_barry(button_id)
		"i38":
			player_to_barry(button_id)
		"i39":
			barry_to_player(button_id)
		"i40":
			player_to_barry(button_id)
		"i41":
			barry_to_player(button_id)
			main_script.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
		"i42":
			barry_to_player(button_id)
		"i43":
			barry_to_player(button_id)
		"i44":
			main_script.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"i45":
			barry_popup.hide()
			main_script.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			main_script.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i46":
			main_script.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"i47":
			john_to_player(button_id)
		"i48":
			john_to_player(button_id)


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
