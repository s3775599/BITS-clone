extends Control

# checks is a dialogue can be initiated (i.e. none already active)
var can_click = true

# booleans to identify current active dialogue
var john_close = false
var barry_close = false
var player_close = false

# Godot's way of storing a Node as a variable
onready var intro_dialogue = get_node("IntroDialogue")
onready var john_dialogue = get_node("JohnDialogue")
onready var barry_dialogue = get_node("BarryDialogue")


func _ready():
	intro()

# this function updates every frame
func _process(delta):
	# darkens background when a dialogue is active
	if john_close or barry_close or player_close:
		darken_background()
		can_click = false


# checks all input signals
func _input(event):
	# initiates Barry dialogue
	if Input.is_action_just_pressed("ui_right"):
		$BackgroundArea/BarryConsole/AnimationPlayer.play('BarryConsoleSlowOut')
	#initiates John dialogue
	if Input.is_action_just_pressed("ui_left"):
		$BackgroundArea/BarryConsole/AnimationPlayer.play('BarryConsoleFastIn')
	# initiates Intro dialogue
	if Input.is_action_just_pressed("ui_cancel"):
		close_dialogues()
	if Input.is_action_just_pressed("ui_down"):
		intro()


# mouseover signal on Barry at the console
func _on_BarryConsole_mouse_entered():
	if not barry_close:
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false


# mouseoff signal on Barry at the console
func _on_BarryConsole_mouse_exited():
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


# mouseover signal on John at the console
func _on_JohnConsole_mouse_entered():
	if not john_close:
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false


# mouseoff signal on John at the console
func _on_JohnConsole_mouse_exited():
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


# mouse click signals on John at the console
func _on_JohnConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if barry_close:
			hide_barry()
		show_john()
		$CanvasLayer/JohnPopup.set_text(john_dialogue.john_dialogues("1"))


# mouse click signals on John at the console
func _on_BarryConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if john_close:
			hide_john()
		show_barry()
		$CanvasLayer/BarryPopup.set_text(barry_dialogue.barry_dialogues("1"))


# collects id of pressed button from Barry dialogue
func _on_BarryPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		close_dialogues()
	elif button_id[0] == "i":
		intro_dialogue.intro_sequence(button_id)
	else:
		var next_dialogue = barry_dialogue.barry_dialogues(button_id)
		$CanvasLayer/BarryPopup.set_text(next_dialogue)


# collects id of pressed button from John dialogue
func _on_JohnPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		close_dialogues()
	elif button_id[0] == "i":
		intro_dialogue.intro_sequence(button_id)
	else:
		var next_dialogue = john_dialogue.john_dialogues(button_id)
		$CanvasLayer/JohnPopup.set_text(next_dialogue)


# collects id of pressed button from Player dialogue
func _on_PlayerPopup_button_id(button_id):
	# ends the dialogue if the last button signal was "end"
	if button_id == "end":
		close_dialogues()
	else:
		# calls the next line of dialogue
		intro_dialogue.intro_sequence(button_id)


# initiates the Intro dialogue
func intro():
	show_player()
	# calls the first Intro dialogue lines from the intro_dialogue script
	$CanvasLayer/PlayerPopup.set_text(intro_dialogue.intro_dialogues("i1"))


func close_dialogues():
	if player_close:
		hide_player()
	if john_close:
		hide_john()
	if barry_close:
		hide_barry()
	normalise_background()


# makes the background dark
func darken_background():
	$BackgroundArea/BackgroundSprite.set_modulate(Color('464646'))
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('464646'))
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('464646'))
	$BackgroundArea/Images/AK47.set_modulate(Color('464646'))
	$BackgroundArea/Images/RussianFlag.set_modulate(Color('464646'))
	$BackgroundArea/Images/RussianText.set_modulate(Color('464646'))


# restores the darkened background
func normalise_background():
	$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/Images/AK47.set_modulate(Color(1,1,1))
	$BackgroundArea/Images/RussianFlag.set_modulate(Color(1,1,1))
	$BackgroundArea/Images/RussianText.set_modulate(Color(1,1,1))


# shows Barry's close-up and dialogue box
func show_barry():
	$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
	barry_close = true
	can_click = false
	$CanvasLayer/BarryPopup.show()


# shows John's close-up and dialogue box
func show_john():
	$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideIn')
	john_close = true
	can_click = false
	$CanvasLayer/JohnPopup.show()


# shows player dialogue box
func show_player():
	player_close = true
	can_click = false
	$CanvasLayer/PlayerPopup.show()


# hides Barry's close-up and dialogue box
func hide_barry():
	$CanvasLayer/BarryPopup.hide()
	$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideOut')
	barry_close = false
	can_click = true


# hides John's close-up and dialogue box
func hide_john():
	$CanvasLayer/JohnPopup.hide()
	$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideOut')
	john_close = false
	can_click = true


# hides Player's dialogue box
func hide_player():
	$CanvasLayer/PlayerPopup.hide()
	player_close = false
	can_click = true
