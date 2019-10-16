extends Node

onready var main_script = get_node("/root/Main")
onready var player_popup = get_node("/root/Main/CanvasLayer/PlayerPopup")
onready var barry_popup = get_node("/root/Main/CanvasLayer/BarryPopup")
onready var john_popup = get_node("/root/Main/CanvasLayer/JohnPopup")
onready var barry_anim = get_node("/root/Main/BackgroundArea/BarryClose/AnimationPlayer")
onready var john_anim = get_node("/root/Main/BackgroundArea/JohnClose/AnimationPlayer")

func intro_dialogues(id):
	match id:
		"i1":
			return [["PLAYER: . . .scanning Quadrant 3, 216 to 322 degrees. Delta V looks good. Report on Quadrant 1, how are we looking Barry?", "[ -- continue -- ]"], ["0", "i2"]]
		"i2":
			return [["Everything's fine mate.", "[ -- continue -- ]"], ["0", "i3"]]
		"i3":
			return [["PLAYER: I beg you pardon, Barry?", "[ -- continue --]"], ["0", "i4"]]
		"i4":
			return [["All good.", "[ -- continue --]"], ["0", "i5"]]
		"i5":
			return [["PLAYER: Barry, I know we've been out here a long time but that doesn't give you license to drop protocol whenever you feel like it. Got it?", "[ -- continue -- ]"], ["0", "i6"]]
		"i6":
			return [["{sigh} Yes [i]SIR[/i] Lieutenant [i]SIR[/i] sorry [i]SIR[/i].", "[ -- continue -- ]"], ["0", "i7"]]
		"i7":
			return [["Systems report, John?", "[ -- continue -- ]"], ["0", "i8"]]
		"i8":
			return [["It's fine, it's whatever.", "[ -- continue -- ]"], ["0", "i9"]]

func intro_sequence(button_id):
	intro_dialogues(button_id)
	match button_id:
		"i2":
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"i3":
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
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)


func player_to_barry(button_id):
	player_popup.hide()
	barry_popup.show()
	barry_popup.set_text(intro_dialogues(button_id))


func player_to_john(button_id):
	player_popup.hide()
	john_popup.show()
	john_popup.set_text(intro_dialogues(button_id))


func barry_to_player(button_id):
	barry_popup.hide()
	player_popup.show()
	player_popup.set_text(intro_dialogues(button_id))

func john_to_player(button_id):
	john_popup.hide()
	player_popup.show()
	player_popup.set_text(intro_dialogues(button_id))
