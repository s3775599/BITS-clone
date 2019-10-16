extends Control

var can_click = true
var john_close = false
var barry_close = false
onready var intro_dialogue = get_node("IntroDialogue")
onready var john_dialogue = get_node("JohnDialogue")
onready var barry_dialogue = get_node("BarryDialogue")

func _process(delta):
	if john_close or barry_close:
		darken_background()


func _input(event):
	if Input.is_action_just_pressed("ui_right"):
		$BackgroundArea/BarryConsole/AnimationPlayer.play('BarryConsoleSlowOut')
	if Input.is_action_just_pressed("ui_left"):
		$BackgroundArea/BarryConsole/AnimationPlayer.play('BarryConsoleFastIn')
	if Input.is_action_just_pressed("ui_down"):
		intro()
	if john_close or barry_close:
		can_click = false


func _on_BarryConsole_mouse_entered():
	if not barry_close:
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false


func _on_BarryConsole_mouse_exited():
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


func _on_JohnConsole_mouse_entered():
	if not john_close:
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false


func _on_JohnConsole_mouse_exited():
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


func _on_JohnConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if barry_close:
			$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideOut')
			barry_close = false
		show_john()
		$CanvasLayer/JohnPopup.set_text(john_dialogue.john_dialogues("1"))
		


func _on_BarryConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if john_close:
			$BackgroundArea/JohnClose/AnimationPlayer.play('BarryCloseSlideOut')
			barry_close = false
		show_barry()
		$CanvasLayer/BarryPopup.set_text(barry_dialogue.barry_dialogues("1"))


func _on_BarryPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		barry_close = false
		$CanvasLayer/BarryPopup.hide()
		normalise_background()
		can_click = true
		$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideOut')
	else:
		var next_dialogue = barry_dialogue.barry_dialogues(button_id)
		print("next_dialogue = ", next_dialogue)
		$CanvasLayer/BarryPopup.set_text(next_dialogue)


func _on_JohnPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		john_close = false
		$CanvasLayer/JohnPopup.hide()
		normalise_background()
		can_click = true
		$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideOut')
	else:
		var next_dialogue = john_dialogue.john_dialogues(button_id)
		print("next_dialogue = ", next_dialogue)
		$CanvasLayer/JohnPopup.set_text(next_dialogue)


func _on_PlayerPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		$CanvasLayer/PlayerPopup.hide()
		normalise_background()
	else:
		intro_dialogue.intro_dialogues(button_id)
		match button_id:
			"2":
				$CanvasLayer/PlayerPopup.hide()
				show_barry()
				$CanvasLayer/BarryPopup.set_text(intro_dialogue.intro_dialogues(button_id))


func darken_background():
	$BackgroundArea/BackgroundSprite.set_modulate(Color('464646'))
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('464646'))
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('464646'))
	$BackgroundArea/Images/AK47.set_modulate(Color('464646'))
	$BackgroundArea/Images/RussianFlag.set_modulate(Color('464646'))
	$BackgroundArea/Images/RussianText.set_modulate(Color('464646'))


func normalise_background():
	$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
	$BackgroundArea/Images/AK47.set_modulate(Color(1,1,1))
	$BackgroundArea/Images/RussianFlag.set_modulate(Color(1,1,1))
	$BackgroundArea/Images/RussianText.set_modulate(Color(1,1,1))


func show_barry():
	$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
	barry_close = true
	can_click = false
	$CanvasLayer/BarryPopup.show()


func show_john():
	$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideIn')
	john_close = true
	can_click = false
	$CanvasLayer/JohnPopup.show()


func intro():
	$CanvasLayer/PlayerPopup.show()
	$CanvasLayer/PlayerPopup.set_text(intro_dialogue.intro_dialogues("1"))
