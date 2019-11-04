extends Popup

signal button_id

#onready var player_popup = get_node('/root/Main/Popups/PlayerPopup')
onready var display_text = get_node('VBoxContainer/DisplayRect/DisplayGlass/DisplayText')
onready var button1 = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button')
onready var button2 = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button2')
onready var button3 = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button3')
onready var button4 = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button4')
onready var button1_label = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button/Label')
onready var button2_label = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button2/Label')
onready var button3_label = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button3/Label')
onready var button4_label = get_node('VBoxContainer/ButtonRect/ButtonContainer/Button4/Label')
onready var audio_stream_player = get_node('/root/Main/AudioStreamPlayer')

# Sets an ID for a selected dialogue button
var button_id
# Controls dialogue box sizes
var vbox_size = Vector2()
var popup_size = Vector2()
# Boolean to indicate if text is currently being printed
var printing = false
# Boolean to indicate if a button has been clicked
var button_selected = false
var quit_button = false

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		quit_button = true


# This function gets dialogue lines as a param and prints it to the dialogue box and buttons
func set_text(dialogue_lines):
	quit_button = false
	button_selected = false
	# Hides all buttons by default
	button1.visible = false
	button2.visible = false
	button3.visible = false
	button4.visible = false
	# If the dialogue is the player's box (in the intro), only show the buttons window
	if Global.player_popup.visible == false:
		display_text.bbcode_text = String("")
	# Gets the number of dialogue lines and button responses
	var dialogue_size = dialogue_lines[0].size()
	# Display appripriate number of buttons
	set_button_visibility(dialogue_size)
	# Prints dialogue choices to buttons
	set_button_labels(dialogue_size, dialogue_lines)
	# Prints the dialogue line to the dialogue window like a typewriter
	typewriter_text(dialogue_lines[0][0])


#
# The following function is code adapted from:
#
# Godotengine.org. (2017). 
# Writing to screen one letter at a time like a typewriter? - Godot Engine - Q&A. [online] 
# Available at: https://godotengine.org/qa/17327/writing-to-screen-one-letter-at-a-time-like-a-typewriter 
# [Accessed 19 Oct. 2019].
#
func typewriter_text(text):
	# Create a timer to print text like a typewriter
	var t = Timer.new()
	t.set_wait_time(.005)
	t.set_one_shot(true)
	self.add_child(t)
	# Prints each individual letter according to Timer length
	for letter in text:
		# If a button has been selected, print the remaining text to the dialogue window
		if button_selected: # or quit_button:
			display_text.bbcode_text = String(text)
			break
		else:
			printing = true
			t.start()
			display_text.bbcode_text += String(letter)
			yield(t, "timeout")
	printing = false


# Displays the appropriate number of buttons according to number of available options
func set_button_visibility(n):
	if n == 1:
		return
	# Because the buttons expand to fill the VBoxContainer, the VBoxContainer itself is adjusted
	# according to how many buttons there are.
	if n > 1:
		# Adjusts the button size and position for the player or NPC dialogues, taking into account
		# the size of the NPCs' dialogue display window
		if Global.player_popup.visible:
			$VBoxContainer.rect_size = Vector2(920, 240)
			$VBoxContainer.rect_position.y = 460
		else:
			$VBoxContainer.rect_size = Vector2(920, 440)
		button1.visible = true
		if n > 2:
			if Global.player_popup.visible:
				$VBoxContainer.rect_size = Vector2(920, 520)
				$VBoxContainer.rect_position.y = 180
			else:
				$VBoxContainer.rect_size = Vector2(920, 600)
			button2.visible = true
			if n > 3:
				if Global.player_popup.visible:
					$VBoxContainer.rect_size = Vector2(920, 600)
					$VBoxContainer.rect_position.y = 100
				else:
					$VBoxContainer.rect_size = Vector2(920, 680)
				button3.visible = true
				if n > 4:
					button4.visible = true


func set_button_labels(dialogue_size, dialogue_lines):
	if dialogue_size == 1:
		return
	if dialogue_size > 1:
		button1_label.set_text(dialogue_lines[0][1])
		button1.button_id = dialogue_lines[1][0]
		if dialogue_size > 2:
			button2_label.set_text(dialogue_lines[0][2])
			button2.button_id = dialogue_lines[1][1]
			if dialogue_size > 3:
				button3_label.set_text(dialogue_lines[0][3])
				button3.button_id = dialogue_lines[1][2]
				if dialogue_size > 4:
					button4_label.set_text(dialogue_lines[0][4])
					button4.button_id = dialogue_lines[1][3]


func emit_button_signal(button_id):
	button_selected = true
	if not printing:
		emit_signal("button_id", button_id)

# can't get this to work, its supposed to play on each click through dialogue menus
# func dialogueClick():
#	audio_stream_player.stream = load (Global.dialogue_click)
#	audio_stream_player.play() 

func _on_Button_pressed():
	button_id = button1.button_id
	emit_button_signal(button_id)
	


func _on_Button2_pressed():
	button_id = button2.button_id
	emit_button_signal(button_id)


func _on_Button3_pressed():
	button_id = button3.button_id
	emit_button_signal(button_id)


func _on_Button4_pressed():
	button_id = button4.button_id
	emit_button_signal(button_id)
