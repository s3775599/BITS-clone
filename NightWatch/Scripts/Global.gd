extends Node

# Sets the current working scene
var current_scene = null

# Vars to indicate which character is on-screen
var john_close = false
var barry_close = false
var player_close = false

# Var is indicate if it's possible to click on an NPC
var can_click = false

# Vars to indicate if Intro or Outro are running 
var intro = false
var outro = false

var title = false

var player_popup = false
var barry_gone = false

# Vars for solved dialogue puzzles
var john_solved = false
var barry_solved = false

# The minigame codes
var code_array = []
# The current active code on the panel
var current_code = []
# Codes which the player has found
var found_codes = []

# Sound files
var airlock_warning_alarm = "res://SFX/airlock_extract.ogg"
var console_click1 = "res://SFX/click3.ogg"
var console_click2 = "res://SFX/rollover6.ogg"
var dialogue_click = "res://SFX/finger-tap-2-4.ogg"
var background = "res://SFX/322054__zimbot__engineroomsteady.ogg"
var language_switch = "res://SFX/error-bleep-2.ogg"
var barry_uhoh = "res://SFX/uh-oh.ogg"

func _ready():
	# Code to get the current scene, taken from Godot docs
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func _process(delta):
	# Sets player popup position according to scene
	if intro:
		player_popup = get_node('/root/Intro/Popups/PlayerPopup')
	elif outro:
		player_popup = get_node('/root/Outro/Popups/PlayerPopup')
	elif title:
		player_popup = null
	else:
		player_popup = get_node('/root/Main/Popups/PlayerPopup')


# Manages button IDs to clicks from the Player dialogue box
func player_button(button_id):
	# Ends the dialogue if the last button signal was "end" (Main scene only)
	if button_id == "end":
		close_dialogues()
	# Changes from Intro to Main scenes
	elif button_id == "end_intro":
		close_dialogues()
		scene_change("res://Scenes/Main.tscn")
	# Changes from Outro scene back to Title screen
	elif button_id == "end_outro":
		close_dialogues()
		scene_change("res://Scenes/Title.tscn")
	else:
		if intro:
		# Calls the next line of dialogue
			current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
		else:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence(button_id)


# Manages button IDs to clicks from John's dialogue box
func john_button(button_id):
	# End the dialogue from a Main scene conversation
	if button_id == "end":
		close_dialogues()
		# Lightens the background for the main scene, otherwise stays dark
		if not intro and not outro:
			current_scene.normalise_background()
	# Button IDs beginnig with i are from the Intro dialogue
	elif button_id[0] == "i":
		current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
	# Button IDs beginning with o are from the Outro dialogue
	elif button_id[0] == "o":
		current_scene.get_node('Dialogues/OutroDialogue').outro_sequence(button_id)
	elif button_id == "smash":
		current_scene.john_smash()
	# ID for the Barry/airlock sequence
	elif button_id == "airlock_close":
		# Calls the function which manages John's dialogue in the Barry/airlock sequence
		current_scene.john_fix_airlock()
	# When John's dialogue puzzle is solved
	elif button_id == "solved":
		current_scene.dialogue_solved()
	# The first dialogue fork of the outro
	elif button_id == "branch1":
		# Barry/airlock ending
		if barry_gone:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("oairlock1")
		else:
			#continues to next fork
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("o3")
	else:
		# Calls John's next line of dialogue
		var next_dialogue = current_scene.get_node('Dialogues/JohnDialogue').john_dialogues(button_id)
		current_scene.get_node('Popups/JohnPopup').set_text(next_dialogue)


func barry_button(button_id):
	# End the dialogue from a Main scene conversation
	if button_id == "end":
		Global.close_dialogues()
		# Lightens the background for the main scene, otherwise stays dark
		if not intro and not outro:
			current_scene.normalise_background()
	# Button IDs beginnig with i are from the Intro dialogue
	elif button_id[0] == "i":
		current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
	# Button IDs beginning with o are from the Outro dialogue
	elif button_id[0] == "o":
		current_scene.get_node('Dialogues/OutroDialogue').outro_sequence(button_id)
	# The second dialogue fork of the outro
	elif button_id == "branch2":
		# Player solved the game without NPC help
		if not barry_solved and not john_solved:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("oplayer1")
		# Player solved game with Barry's help
		elif barry_solved and not john_solved:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("obarry1")
		# Player solved game with John's help
		elif not barry_solved and john_solved:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("ojohn1")
		# Player solved game with both NPC's help
		elif john_solved and barry_solved:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("oteam1")
	# The Baarry/airlock sequence
	elif button_id == "airlock_barry_out":
		current_scene.airlock_barry_out()
	# When John's dialogue puzzle is solved
	elif button_id == "solved":
		current_scene.dialogue_solved()
	else:
		# Calls Barry's next line of dialogue
		var next_dialogue = current_scene.get_node('Dialogues/BarryDialogue').barry_dialogues(button_id)
		current_scene.get_node('Popups/BarryPopup').set_text(next_dialogue)


# Manages transitions between scenes
func scene_change(scene_path):
	# Begins the FadeOut animation
	current_scene.get_node('AnimationPlayer').play("FadeOut")
	# Sets and starts a timer
	var t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# After timer ends (to allow for animation to finish), changes the scene
	get_tree().change_scene(scene_path)


# Closes all currently running dialogues
func close_dialogues():
	if player_close:
		hide_player()
	if john_close:
		hide_john()
	if barry_close:
		hide_barry()


# Shows Barry's close-up and dialogue box
func show_barry():
	# Plays slide-in animation, sets global vars and shows dialogue box
	current_scene.get_node('Crew/BarryClose/AnimationPlayer').play('BarryCloseSlideIn')
	barry_close = true
	can_click = false
	current_scene.get_node('Popups/BarryPopup').show()


# Shows John's close-up and dialogue box
func show_john():
	# Plays slide-in animation, sets global vars and shows dialogue box
	current_scene.get_node('Crew/JohnClose/AnimationPlayer').play('JohnCloseSlideIn')
	john_close = true
	can_click = false
	current_scene.get_node('Popups/JohnPopup').show()


# Shows player dialogue box
func show_player():
	# Sets global vars and shows dialogue box
	player_close = true
	can_click = false
	current_scene.get_node('Popups/PlayerPopup').show()


# Hides Barry's close-up and dialogue box
func hide_barry():
	current_scene.get_node('Popups/BarryPopup').hide()
	current_scene.get_node('Crew/BarryClose/AnimationPlayer').play('BarryCloseSlideOut')
	barry_close = false
	can_click = true


# Hides John's close-up and dialogue box
func hide_john():
	current_scene.get_node('Popups/JohnPopup').hide()
	current_scene.get_node('Crew/JohnClose/AnimationPlayer').play('JohnCloseSlideOut')
	john_close = false
	can_click = true


# Hides Player's dialogue box
func hide_player():
	current_scene.get_node('Popups/PlayerPopup').hide()
	player_close = false
	can_click = true
