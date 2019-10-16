extends Popup

signal button_id

var button_id

func set_text(dialogue_lines):

	var dialogue_size = dialogue_lines[0].size()
	print("dialogue_size = ", dialogue_size)
	set_button_labels(dialogue_size, dialogue_lines)
	$NinePatchRect2/RichTextLabel.bbcode_text = String(dialogue_lines[0][0])


func set_button_labels(dialogue_size, dialogue_lines):
	$NinePatchRect2/VBoxContainer/Button/buttonLabel.set_text(dialogue_lines[0][1])
	$NinePatchRect2/VBoxContainer/Button.button_id = dialogue_lines[1][1]


func _on_Button_pressed():
	button_id = $NinePatchRect2/VBoxContainer/Button.button_id
	emit_signal("button_id", button_id)
