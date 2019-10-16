extends Node

# gets Nodes from the main scene as variables
onready var main_script = get_node("/root/Main")
onready var player_popup = get_node("/root/Main/CanvasLayer/PlayerPopup")
onready var barry_popup = get_node("/root/Main/CanvasLayer/BarryPopup")
onready var john_popup = get_node("/root/Main/CanvasLayer/JohnPopup")
onready var barry_anim = get_node("/root/Main/BackgroundArea/BarryClose/AnimationPlayer")
onready var john_anim = get_node("/root/Main/BackgroundArea/JohnClose/AnimationPlayer")

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
			return [["", "What's gotten into you two?", "One more outburst like that and I'll have to file a report of insubordination!", "Are you sure nothing's changed?", "Wee that's good to know."], ["0", "i11a", "i11b", "i11c", "i11d"]]
		"i11a":
			return [["Nothing.", "[ -- continue -- ]"], ["0", "i11a1"]]
		"i11a1":
			return [["Nothing.", "[ -- continue -- ]"], ["0", "i11r"]]
		"i11r":
			return [["", "What's gotten into you two?", "One more outburst like that and I'll have to file a report of insubordination!", "Are you sure nothing's changed?", "Wee that's good to know."], ["0", "i11a", "i11b", "i11c", "i11d"]]
		"i11b":
			return [["Oh no, not that. Anything but that.", "[ -- continue -- ]"], ["0", "i11b1"]]
		"i11c":
			return
		"i11d":
			return

# the sequence of dialogue and animations/transitions in the intro
func intro_sequence(button_id):
	match button_id:
		"i2":
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
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"i8":
			# the previous dialogue and current dialogue is from the Player to John
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i9":
			john_to_player(button_id)
		"i10":
			player_to_john(button_id)
		"i11":
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"i11a":
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"i11a1":
			john_anim.play('JohnCloseSlideOut')
			john_to_barry(button_id)
			barry_anim.play('BarryCloseSlideIn')
		"i11r":
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"i11b":
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		
		
		
#			main_script.john_close = false
#			main_script.barry_close = false
#			main_script.player_close = false


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
