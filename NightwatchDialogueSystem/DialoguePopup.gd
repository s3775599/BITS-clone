extends Popup

signal button_id

onready var player_popup = get_node('/root/Main/CanvasLayer/PlayerPopup')

var button_id
var vbox_size = Vector2()
var popup_size = Vector2()

func set_text(dialogue_lines):
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button.visible = false
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2.visible = false
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3.visible = false
	$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4.visible = false
	if player_popup.visible == true:
		$VBoxContainer/NinePatchRect/.visible = false
	var dialogue_size = dialogue_lines[0].size()
	set_button_visibility(dialogue_size)
	set_button_labels(dialogue_size, dialogue_lines)
	$VBoxContainer/NinePatchRect/MarginContainer/NinePatchRect/MarginContainer/RichTextLabel.bbcode_text = String(dialogue_lines[0][0])


func set_button_visibility(n):
	if n == 1:
		return
	if n > 1:
		$VBoxContainer.rect_size = Vector2(460, 88)
		$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button.visible = true
		if n > 2:
			$VBoxContainer.rect_size = Vector2(460, 118)
			$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2.visible = true
			if n > 3:
				$VBoxContainer.rect_size = Vector2(460, 158)
				$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3.visible = true
				if n > 4:
					$VBoxContainer.rect_size = Vector2(460, 198)
					$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4.visible = true


func set_button_labels(dialogue_size, dialogue_lines):
	if dialogue_size == 1:
		return
	if dialogue_size > 1:
		$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button/Label.set_text(dialogue_lines[0][1])
		$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button.button_id = dialogue_lines[1][1]
		if dialogue_size > 2:
			$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2/Label.set_text(dialogue_lines[0][2])
			$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button2.button_id = dialogue_lines[1][2]
			if dialogue_size > 3:
				$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3/Label.set_text(dialogue_lines[0][3])
				$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button3.button_id = dialogue_lines[1][3]
				if dialogue_size > 4:
					$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4/Label.set_text(dialogue_lines[0][4])
					$VBoxContainer/NinePatchRect2/MarginContainer/VBoxContainer/Button4.button_id = dialogue_lines[1][4]


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
