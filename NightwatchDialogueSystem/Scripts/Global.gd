extends Node

var current_scene = null

var john_close = false
var barry_close = false
var player_close = false
var can_click = false
var barry_airlock = false
var player_visible = false
var intro = false
var outro = false
var title = false
var player_popup = false
var barry_gone = false
var john_solved = false
var barry_solved = false

var code_array = []
var current_code = []
var found_codes = []

var airlock_warning_alarm = "res://SFX/airlock_warning.wav"

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func _process(delta):
	if intro:
		player_popup = get_node('/root/Intro/Popups/PlayerPopup')
	elif outro:
		player_popup = get_node('/root/Outro/Popups/PlayerPopup')
	else:
		player_popup = get_node('/root/Main/Popups/PlayerPopup')


func player_button(button_id):
	# Ends the dialogue if the last button signal was "end"
	if button_id == "end":
		close_dialogues()
	elif button_id == "end_intro" or button_id == "end_outro":
		close_dialogues()
		scene_change("res://Scenes/Title.tscn")
	else:
		if intro:
		# Calls the next line of dialogue
			current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
		else:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence(button_id)


func scene_change(scene_path):
	current_scene.get_node('AnimationPlayer').play("FadeOut")
	var t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
#	current_scene = null
	get_tree().change_scene(scene_path)


func john_button(button_id):
	if button_id == "end":
		close_dialogues()
		if not intro and not outro:
			current_scene.normalise_background()
	elif button_id[0] == "i":
		current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
	elif button_id[0] == "o":
		current_scene.get_node('Dialogues/OutroDialogue').outro_sequence(button_id)
	elif button_id == "airlock_close":
		current_scene.john_fix_airlock()
	elif button_id == "solved":
		current_scene.dialogue_solved()
	elif button_id == "branch1":
		if barry_gone:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("oairlock1")
		else:
			current_scene.get_node('Dialogues/OutroDialogue').outro_sequence("o3")
	else:
		var next_dialogue = current_scene.get_node('Dialogues/JohnDialogue').john_dialogues(button_id)
		current_scene.get_node('Popups/JohnPopup').set_text(next_dialogue)


func barry_button(button_id):
	if button_id == "end":
		Global.close_dialogues()
		if not intro and not outro:
			current_scene.normalise_background()
	elif button_id[0] == "i":
		current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
	elif button_id[0] == "o":
		current_scene.get_node('Dialogues/OutroDialogue').outro_sequence(button_id)
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
	elif button_id == "airlock_barry_out":
		current_scene.airlock_barry_out()
	elif button_id == "solved":
		current_scene.dialogue_solved()
	else:
		var next_dialogue = current_scene.get_node('Dialogues/BarryDialogue').barry_dialogues(button_id)
		current_scene.get_node('Popups/BarryPopup').set_text(next_dialogue)


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
	current_scene.get_node('Crew/BarryClose/AnimationPlayer').play('BarryCloseSlideIn')
	barry_close = true
	can_click = false
	current_scene.get_node('Popups/BarryPopup').show()


# Shows John's close-up and dialogue box
func show_john():
	current_scene.get_node('Crew/JohnClose/AnimationPlayer').play('JohnCloseSlideIn')
	john_close = true
	can_click = false
	current_scene.get_node('Popups/JohnPopup').show()


# Shows player dialogue box
func show_player():
	player_close = true
	can_click = false
	current_scene.get_node('Popups/PlayerPopup').show()


# Hides Barry's close-up and dialogue box
func hide_barry():
	current_scene.get_node('Popups/BarryPopup').hide()
	current_scene.get_node('Crew/BarryClose/AnimationPlayer').play('BarryCloseSlideOut')
	barry_close = false
	can_click


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
