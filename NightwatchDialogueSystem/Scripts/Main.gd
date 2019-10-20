extends Control

# Checks is a dialogue can be initiated (i.e. none already active)
var can_click = true

# Booleans to identify current active dialogue
var john_close = false
var barry_close = false
var player_close = false

# Godot's way of storing a Node as a variable
onready var intro_dialogue = get_node("Dialogues/IntroDialogue")
onready var john_dialogue = get_node("Dialogues/JohnDialogue")
onready var barry_dialogue = get_node("Dialogues/BarryDialogue")


func _ready():
	#$BackgroundArea/Images.visible = false
	$AnimationPlayer.play('FadeIn')
	intro()

# This function updates every frame
func _process(delta):
	# darkens background when a dialogue is active
	if john_close or barry_close or player_close:
		darken_background()
		can_click = false


# Checks all input signals
func _input(event):
	# Quits from the current dialogue
	if Input.is_action_just_pressed("ui_cancel"):
#		if $BackgroundArea/Images.visible == false:
#			$BackgroundArea/Images.visible = true
		$BackgroundArea/BackgroundSprite.set_modulate(Color('ffffff'))
		close_dialogues()
	# Manually starts the intro dialogue (for testing purposes)
	if Input.is_action_just_pressed("ui_down"):
		intro()
	if Input.is_action_pressed("ui_left"):
		$ConsoleMiniGame.visible = not $ConsoleMiniGame.visible


# Mouseover signal on Barry at the console
func _on_BarryConsole_mouse_entered():
	if not barry_close:
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false


# Mouseoff signal on Barry at the console
func _on_BarryConsole_mouse_exited():
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


# Mouseover signal on John at the console
func _on_JohnConsole_mouse_entered():
	if not john_close:
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false


# Mouseoff signal on John at the console
func _on_JohnConsole_mouse_exited():
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


# Mouse click signals on John at the console
func _on_JohnConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if barry_close:
			hide_barry()
		show_john()
		$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("1"))


# Mouse click signals on John at the console
func _on_BarryConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if john_close:
			hide_john()
		show_barry()
		$Popups/BarryPopup.set_text(barry_dialogue.barry_dialogues("1"))


# Collects id of pressed button from Barry dialogue
func _on_BarryPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		close_dialogues()
	elif button_id[0] == "i":
		intro_dialogue.intro_sequence(button_id)
	else:
		var next_dialogue = barry_dialogue.barry_dialogues(button_id)
		$Popups/BarryPopup.set_text(next_dialogue)


# Collects id of pressed button from John dialogue
func _on_JohnPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		close_dialogues()
	elif button_id[0] == "i":
		intro_dialogue.intro_sequence(button_id)
	else:
		var next_dialogue = john_dialogue.john_dialogues(button_id)
		$Popups/JohnPopup.set_text(next_dialogue)


# Collects id of pressed button from Player dialogue
func _on_PlayerPopup_button_id(button_id):
	# Ends the dialogue if the last button signal was "end"
	if button_id == "end":
		if $BackgroundArea/Images.visible == false:
			$BackgroundArea/Images.visible = true
		$BackgroundArea/BackgroundSprite.set_modulate(Color('ffffff'))
		close_dialogues()
	else:
		# Calls the next line of dialogue
		intro_dialogue.intro_sequence(button_id)


# Initiates the Intro dialogue
func intro():
	show_player()
	# Calls the first Intro dialogue lines from the intro_dialogue script
	$Popups/PlayerPopup.set_text(intro_dialogue.intro_dialogues("i1"))


# Closes all currently running dialogues
func close_dialogues():
	if player_close:
		hide_player()
	if john_close:
		hide_john()
	if barry_close:
		hide_barry()
	normalise_background()


# Makes the background dark (for when a dialogue is running)
func darken_background():
	$BackgroundArea/BackgroundSprite.set_modulate(Color('464646'))
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('464646'))
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('464646'))
#	$BackgroundArea/Images/AK47.set_modulate(Color('464646'))
#	$BackgroundArea/Images/RussianFlag.set_modulate(Color('464646'))
#	$BackgroundArea/Images/RussianText.set_modulate(Color('464646'))


# Restores the darkened background
func normalise_background():
	$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
#	$BackgroundArea/Images/AK47.set_modulate(Color(1,1,1))
#	$BackgroundArea/Images/RussianFlag.set_modulate(Color(1,1,1))
#	$BackgroundArea/Images/RussianText.set_modulate(Color(1,1,1))


# Shows Barry's close-up and dialogue box
func show_barry():
	$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
	barry_close = true
	can_click = false
	$Popups/BarryPopup.show()


# Shows John's close-up and dialogue box
func show_john():
	$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideIn')
	john_close = true
	can_click = false
	$Popups/JohnPopup.show()


# Shows player dialogue box
func show_player():
	player_close = true
	can_click = false
	$Popups/PlayerPopup.show()


# Hides Barry's close-up and dialogue box
func hide_barry():
	$Popups/BarryPopup.hide()
	$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideOut')
	barry_close = false
	can_click = true


# Hides John's close-up and dialogue box
func hide_john():
	$Popups/JohnPopup.hide()
	$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideOut')
	john_close = false
	can_click = true


# Hides Player's dialogue box
func hide_player():
	$Popups/PlayerPopup.hide()
	player_close = false
	can_click = true
