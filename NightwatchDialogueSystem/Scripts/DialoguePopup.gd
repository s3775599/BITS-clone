extends Popup

signal button_id

onready var player_popup = get_node('/root/Main/Popups/PlayerPopup')

var button_id
var vbox_size = Vector2()
var popup_size = Vector2()

func set_text(dialogue_lines):
	$VBoxContainer/NinePatchRect/MarginContainer/NinePatchRect/MarginContainer/RichTextLabel.bbcode_text = String("")
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button.visible = false
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2.visible = false
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3.visible = false
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4.visible = false
	if player_popup.visible == true:
		$VBoxContainer/NinePatchRect/.visible = false
	var dialogue_size = dialogue_lines[0].size()
	set_button_visibility(dialogue_size)
	set_button_labels(dialogue_size, dialogue_lines)
	typewriter_text(dialogue_lines[0][0])

"""
The following function is code adapted from:

	Godotengine.org. (2017). 
	Writing to screen one letter at a time like a typewriter? - Godot Engine - Q&A. [online] 
	Available at: https://godotengine.org/qa/17327/writing-to-screen-one-letter-at-a-time-like-a-typewriter 
	[Accessed 19 Oct. 2019].

"""
func typewriter_text(text):
	#create a timer to print text like a typewriter
	var t = Timer.new()
	t.set_wait_time(.005)
	t.set_one_shot(true)
	self.add_child(t)

	for letter in text:
		t.start()
		print(letter)
		$VBoxContainer/NinePatchRect/MarginContainer/NinePatchRect/MarginContainer/RichTextLabel.bbcode_text += String(letter)
		yield(t, "timeout")
""" 
"""

func set_button_visibility(n):
	if n == 1:
		return
	if n > 1:
		$VBoxContainer.rect_size = Vector2(460, 80)
		$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button.visible = true
		if n > 2:
			$VBoxContainer.rect_size = Vector2(460, 220)
			$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2.visible = true
			if n > 3:
				$VBoxContainer.rect_size = Vector2(460, 300)
				$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3.visible = true
				if n > 4:
					$VBoxContainer.rect_size = Vector2(460, 360)
					$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4.visible = true


func set_button_labels(dialogue_size, dialogue_lines):
	if dialogue_size == 1:
		return
	if dialogue_size > 1:
		$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button/Label.set_text(dialogue_lines[0][1])
		$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button.button_id = dialogue_lines[1][0]#dialogue_lines[1][1]
		if dialogue_size > 2:
			$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2/Label.set_text(dialogue_lines[0][2])
			$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2.button_id = dialogue_lines[1][1]#dialogue_lines[1][2]
			if dialogue_size > 3:
				$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3/Label.set_text(dialogue_lines[0][3])
				$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3.button_id = dialogue_lines[1][2]#dialogue_lines[1][3]
				if dialogue_size > 4:
					$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4/Label.set_text(dialogue_lines[0][4])
					$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4.button_id = dialogue_lines[1][3]#dialogue_lines[1][4]


func emit_button_signal(button_id):
	emit_signal("button_id", button_id)


func _on_Button_pressed():
	button_id = $VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button.button_id
	emit_button_signal(button_id)


func _on_Button2_pressed():
	button_id = $VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2.button_id
	emit_button_signal(button_id)


func _on_Button3_pressed():
	button_id = $VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3.button_id
	emit_button_signal(button_id)


func _on_Button4_pressed():
	button_id = $VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4.button_id
	emit_button_signal(button_id)
