extends Node

# gets Nodes as variables
onready var outro_script = get_node("/root/Outro")
onready var outro_anim = get_node("/root/Outro/AnimationPlayer")
onready var player_popup = get_node("/root/Outro/Popups/PlayerPopup")
onready var barry_popup = get_node("/root/Outro/Popups/BarryPopup")
onready var john_popup = get_node("/root/Outro/Popups/JohnPopup")
onready var barry_anim = get_node("/root/Outro/Crew/BarryClose/AnimationPlayer")
onready var barry_console_anim = get_node("/root/Outro/Crew/BarryConsole/AnimationPlayer")
onready var john_anim = get_node("/root/Outro/Crew/JohnClose/AnimationPlayer")

func _ready():
	Global.player_close = true


func outro_dialogues(id):
	match id:
		"o1":
			return [["", "All the monitors seem fine now, how's your station, John?"], ["o2"]]
		"o2":
			return [["It looks like we're back to normal.", "[ -- continue -- ]"], ["branch1"]]
		"o3":
			return [["", "Systems check, Barry?"], ["o4"]]
		"o4":
			return [["No backward Rs as far as I can see.", "[ -- continue -- ]"], ["branch2"]]
		#
		# Barry airlock ending
		#
		"oairlock1":
			return [["", "Looks like. Right back to where we were before."], ["oairlock2"]]
		"oairlock2":
			return [["Well, except for. . . you know.", "[ -- continue -- ]"], ["oairlock3"]]
		"oairlock3":
			return [["", ". . .Barry! COMPUTER!"], ["oairlock4"]]
		"oairlock4":
			return [["", "{ COMPUTER } : Standing by."], ["oairlock5"]]
		"oairlock5":
			return [["", "Locate Barry! Prepare intercept pods for an emergency rescue!"], ["oairlock6"]]
		"oairlock6":
			return [["", "{ COMPUTER } : Barry is located directly behind you."], ["oairlock7"]]
		"oairlock7":
			return [["", ". . ."], ["oairlock8"]]
		"oairlock8":
			return [["", "Barry?"], ["oairlock9"]]
		"oairlock9":
			return [["Hello.", "[ -- continue -- ]"], ["oairlock10"]]
		"oairlock10":
			return [["", "You're alive?"], ["oairlock11"]]
		"oairlock11":
			return [["Looks like.", "[ -- continue -- ]"], ["oairlock12"]]
		"oairlock12":
			return [["How did you get back in?", "[ -- continue -- ]"], ["oairlock13"]]
		"oairlock13":
			return [["I was falling down the corridor, banging on the walls and floor all the way towards the open airlock, and I was watching my life flashing in front of my eyes. . .", "[ -- continue -- ]"], ["oairlock14"]]
		"oairlock14":
			return [["And I was just up to the part where I was signing up for the League which, considering I was about to die right at that moment, was pouring salt and vinegar into the wound really.", "[ -- continue --]"], ["oairlock15"]]
		"oairlock15":
			return [["And then the doors shut right in front of me.", "[ -- continue -- ]"], ["oairlock16"]]
		"oairlock16":
			return [["So I went to the ship's pub.", "[ -- continue --]"], ["oairlock17"]]
		"oairlock17":
			return [["", "Well. Good to have you back, Barry."], ["oairlock18"]]
		"oairlock18":
			return [["Yeah. Great.", "[ -- continue --]"], ["oairlock19"]]
		"oairlock19":
			return [["", "How's that systems report, John?"], ["end_outro"]]
		#
		# Player solved alone ending
		#
		"oplayer1":
			return [["You've done it, Sir!", "[ -- continue --]"], ["oplayer2"]]
		"oplayer2":
			return [["Well done, Sir!", "[ -- continue --]"], ["oplayer3"]]
		"oplayer3":
			return [["", "I'm glad we're back on track now."], ["oplayer4"]]
		"oplayer4":
			return [["You did a great job, Sir.", "[ -- continue --]"], ["oplayer5"]]
		"oplayer5":
			return [["", "Why didn't either of you fix this?"], ["oplayer6"]]
		"oplayer6":
			return [["I didn't know how to, Sir.", "[ -- continue --]"], ["oplayer7"]]
		"oplayer7":
			return [["I was trying really hard, Sir.", "[ -- continue --]"], ["oplayer8"]]
		"oplayer8":
			return [["", "It was a matter of flicking those switches there."], ["oplayer9"]]
		"oplayer9":
			return [["Which switches?", "[ -- continue --]"], ["oplayer10"]]
		"oplayer10":
			return [["", "Those bright little red switches right next to you, John."], ["oplayer11"]]
		"oplayer11":
			return [["Oh yes, those bright little red switches. And that fixed it?", "[ -- continue --]"], ["oplayer12"]]
		"oplayer12":
			return [["", "I pressed them a few times and played around a bit and it seemed to fix it."], ["oplayer13"]]
		"oplayer13":
			return [["Well, now.", "[ -- continue --]"], ["oplayer14"]]
		"oplayer14":
			return [["", "It was pretty simple, actually."], ["oplayer15"]]
		"oplayer15":
			return [["Well how about that.", "[ -- continue --]"], ["oplayer16"]]
		"oplayer16":
			return [["", "So, why didn't either of you do anything?"], ["oplayer17"]]
		"oplayer17":
			return [["It was Barry's mistake to fix.", "[ -- continue --]"], ["oplayer18"]]
		"oplayer18":
			return [["I knew one of these switches opens the airlock but I couldn't remember which.", "[ -- continue --]"], ["oplayer19"]]
		"oplayer19":
			return [["", "Barry."], ["oplayer20"]]
		"oplayer20":
			return [["Technically, by not doing anything I've saved everyone's lives.", "[ -- continue --]"], ["oplayer21"]]
		"oplayer21":
			return [["", "Barry, stop talking."], ["end_outro"]]
		#
		# Solved with Barry's help
		#
		"obarry1":
			return [["", "It looks like we did it, Barry."], ["obarry2"]]
		"obarry2":
			return [["That's a relief. I thought I was up for Sunday slop-out duty for sure.", "[ -- continue --]"], ["obarry3"]]
		"obarry3":
			return [["", "Barry, your boredom experiments nearly put us all in serious danger. If you were me, what would you do about this now?"], ["obarry4"]]
		"obarry4":
			return [["I'd try to forget all about this and move on.", "[ -- continue --]"], ["obarry5"]]
		"obarry5":
			return [["", "No, Barry."], ["obarry6"]]
		"obarry6":
			return [["Be given a stern warning and told not to do it again?", "[ -- continue --]"], ["obarry7"]]
		"obarry7":
			return [["", "No, Barry."], ["obarry8"]]
		"obarry8":
			return [[". . . slop bucket?", "[ -- continue --]"], ["obarry9"]]
		"obarry9":
			return [["", "Yes, Barry."], ["obarry10"]]
		"obarry10":
			return [["Uh . . . understood, Sir.", "[ -- continue --]"], ["obarry11"]]
		"obarry11":
			return [["", "Systems report, John?"], ["end_outro"]]
		#
		# Solved with John's help
		#
		"ojohn1":
			return [["I think we've done it, Sir.", "[ -- continue --]"], ["ojohn2"]]
		"ojohn2":
			return [["Well done, guys!", "[ -- continue --]"], ["ojohn3"]]
		"ojohn3":
			return [["", "Yes, thanks for your contribution, Barry."], ["ojohn4"]]
		"ojohn4":
			return [["Yeah, thanks a lot Barry.", "[ -- continue --]"], ["ojohn5"]]
		"ojohn5":
			return [["You know, you two were dealing with it so well, I didn't want to get in the way.", "[ -- continue --]"], ["ojohn6"]]
		"ojohn6":
			return [["", "Well that's very generous of you Barry. You can keep that generous momentum up by volunteering for Sunday slop-out duty."], ["ojohn7"]]
		"ojohn7":
			return [["Uh . . . yes Sir.", "[ -- continue --]"], ["ojohn8"]]
		"ojohn8":
			return [["", "Systems report, John?"], ["end_outro"]]
		#
		# Solved with both NPC's help
		#
		"oteam1":
			return [["I think we've done it, Sir.", "[ -- continue --]"], ["oteam2"]]
		"oteam2":
			return [["", "I think you might be right."], ["oteam3"]]
		"oteam3":
			return [["What a relief!", "[ -- continue --]"], ["oteam4"]]
		"oteam4":
			return [["", "John, Barry, well done."], ["oteam5"]]
		"oteam5":
			return [["Thank you, Sir.", "[ -- continue --]"], ["oteam6"]]
		"oteam6":
			return [["Thank you, Sir.", "[ -- continue --]"], ["oteam7"]]
		"oteam7":
			return [["", "Barry, you nearly got us all killed."], ["oteam8"]]
		"oteam8":
			return [["Uh . . . ", "[ -- continue --]"], ["oteam9"]]
		"oteam9":
			return [["", "But at least you salvaged the situation a little bit."], ["oteam10"]]
		"oteam10":
			return [["Yes, Sir.", "[ -- continue --]"], ["oteam11"]]
		"oteam11":
			return [["", "You have an extra day of slop duties. Now go and grab your mop and bucket."], ["oteam12"]]
		"oteam12":
			return [["Uh . . . yes Sir. Right away, Sir.", "[ -- continue --]"], ["oteam13"]]
		"oteam13":
			return [["", "How about that systems report, John?"], ["end_outro"]]


func outro_sequence(button_id):
	match button_id:
		"o2":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"o3":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"o4":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		#
		# Barry airlock ending
		#
		"oairlock1":
			john_to_player(button_id)
		"oairlock2":
			player_to_john(button_id)
		"oairlock3":
			john_to_player(button_id)
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
		"oairlock4":
			john_to_player(button_id)
		"oairlock5":
			john_to_player(button_id)
		"oairlock6":
			john_to_player(button_id)
		"oairlock7":
			barry_console_anim.play('BarryConsoleSlideIn')
			john_to_player(button_id)
		"oairlock8":
			john_to_player(button_id)
		"oairlock9":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"oairlock10":
			barry_to_player(button_id)
		"oairlock11":
			player_to_barry(button_id)
		"oairlock12":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			barry_to_john(button_id)
		"oairlock13":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			john_to_barry(button_id)
		"oairlock14":
			john_to_barry(button_id)
		"oairlock15":
			john_to_barry(button_id)
		"oairlock16":
			john_to_barry(button_id)
		"oairlock17":
			barry_to_player(button_id)
		"oairlock18":
			player_to_barry(button_id)
		"oairlock19":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		#
		# Player solved alone ending
		#
		"oplayer1":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			barry_to_john(button_id)
		"oplayer2":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			john_to_barry(button_id)
		"oplayer3":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"oplayer4":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"oplayer5":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"oplayer6":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"oplayer7":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			john_to_barry(button_id)
		"oplayer8":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"oplayer9":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"oplayer10":
			john_to_player(button_id)
		"oplayer11":
			player_to_john(button_id)
		"oplayer12":
			john_to_player(button_id)
		"oplayer13":
			player_to_john(button_id)
		"oplayer14":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"oplayer15":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"oplayer16":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"oplayer17":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"oplayer18":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			john_to_barry(button_id)
		"oplayer19":
			barry_to_player(button_id)
		"oplayer20":
			player_to_barry(button_id)
		"oplayer21":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		#
		# Solved with Barry's help
		#
		"obarry1":
			barry_to_player(button_id)
		"obarry2":
			player_to_barry(button_id)
		"obarry3":
			barry_to_player(button_id)
		"obarry4":
			player_to_barry(button_id)
		"obarry5":
			barry_to_player(button_id)
		"obarry6":
			player_to_barry(button_id)
		"obarry7":
			barry_to_player(button_id)
		"obarry8":
			player_to_barry(button_id)
		"obarry9":
			barry_to_player(button_id)
		"obarry10":
			player_to_barry(button_id)
		"obarry11":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		#
		# Solved with John's help
		#
		"ojohn1":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			barry_to_john(button_id)
		"ojohn2":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			john_to_barry(button_id)
		"ojohn3":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"ojohn4":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"ojohn5":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			john_to_barry(button_id)
		"ojohn6":
			barry_to_player(button_id)
		"ojohn7":
			player_to_barry(button_id)
		"ojohn8":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		#
		# Solved with both NPC's help
		#
		"oteam1":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			barry_to_john(button_id)
		"oteam2":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			john_to_player(button_id)
		"oteam3":
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			player_to_barry(button_id)
		"oteam4":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_to_player(button_id)
		"oteam5":
			Global.john_close = true
			john_anim.play('JohnCloseSlideIn')
			player_to_john(button_id)
		"oteam6":
			Global.john_close = false
			john_anim.play('JohnCloseSlideOut')
			Global.barry_close = true
			barry_anim.play('BarryCloseSlideIn')
			john_to_barry(button_id)
		"oteam7":
			barry_to_player(button_id)
		"oteam8":
			player_to_barry(button_id)
		"oteam9":
			barry_to_player(button_id)
		"oteam10":
			player_to_barry(button_id)
		"oteam11":
			barry_to_player(button_id)
		"oteam12":
			player_to_barry(button_id)
		"oteam13":
			Global.barry_close = false
			barry_anim.play('BarryCloseSlideOut')
			barry_console_anim.play('BarryConsoleSlideOut')
			barry_to_player(button_id)


# sets the dialogue box transition from the Player to Barry
func player_to_barry(button_id):
	player_popup.hide()
	barry_popup.show()
	barry_popup.set_text(outro_dialogues(button_id))


# sets the dialogue box transition from the Player to John
func player_to_john(button_id):
	player_popup.hide()
	john_popup.show()
	john_popup.set_text(outro_dialogues(button_id))


# sets the dialogue box transition from Barry to the Player
func barry_to_player(button_id):
	barry_popup.hide()
	player_popup.show()
	player_popup.set_text(outro_dialogues(button_id))


# sets the dialogue box transition from John to the Player
func john_to_player(button_id):
	john_popup.hide()
	player_popup.show()
	player_popup.set_text(outro_dialogues(button_id))


func john_to_barry(button_id):
	john_popup.hide()
	barry_popup.show()
	barry_popup.set_text(outro_dialogues(button_id))


func barry_to_john(button_id):
	barry_popup.hide()
	john_popup.show()
	john_popup.set_text(outro_dialogues(button_id))
