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
var player_popup
var barry_gone = false
var john_solved = false
var barry_solved = false


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func _process(delta):
	if intro:
		player_popup = get_node('/root/Intro/Popups/PlayerPopup')
	else:
		player_popup = get_node('/root/Main/Popups/PlayerPopup')
#	if outro:
#		player_popup = get_node('/root/Outro/Popups/PlayerPopup')


func player_button(button_id):
	# Ends the dialogue if the last button signal was "end"
	if button_id == "end":
#		if $BackgroundArea/Images.visible == false:
#			$BackgroundArea/Images.visible = true
#		$BackgroundArea/BackgroundSprite.set_modulate(Color('ffffff'))
		close_dialogues()
	elif button_id == "end_intro":
		close_dialogues()
		current_scene.get_node("AnimationPlayer").play("FadeOut")
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		get_tree().change_scene("res://Scenes/Main.tscn")
	else:
		# Calls the next line of dialogue
		current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)


func john_button(button_id):
	if button_id == "end":
		close_dialogues()
	elif button_id[0] == "i":
		current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
	elif button_id == "airlock_close":
		current_scene.john_fix_airlock()
	else:
		var next_dialogue = current_scene.get_node('Dialogues/JohnDialogue').john_dialogues(button_id)
		$Popups/JohnPopup.set_text(next_dialogue)


func barry_button(button_id):
	if button_id == "end":
		Global.close_dialogues()
		#
		# change scene to main
		#
	elif button_id[0] == "i":
		current_scene.get_node('Dialogues/IntroDialogue').intro_sequence(button_id)
	elif button_id == "airlock_barry_out":
		current_scene.airlock_barry_out()
	else:
		var next_dialogue = current_scene.get_node('Dialogues/BarryDialogue').barry_dialogues(button_id)
		$Popups/BarryPopup.set_text(next_dialogue)


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
