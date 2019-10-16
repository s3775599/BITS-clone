extends Control

var can_click = true
var john_close = false
var barry_close = false
onready var john_dialogue = get_node("JohnDialogue")
onready var barry_dialogue = get_node("BarryDialogue")

func _process(delta):
	if john_close or barry_close:
		$BackgroundArea/BackgroundSprite.set_modulate(Color('464646'))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('464646'))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('464646'))


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
		$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideIn')
		john_close = true
		can_click = false
		show_john_dialogue()
		

func _on_BarryConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if john_close:
			$BackgroundArea/JohnClose/AnimationPlayer.play('BarryCloseSlideOut')
			barry_close = false
		$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
		barry_close = true
		can_click = false
		show_barry_dialogue()


func show_john_dialogue():
	$CanvasLayer/JohnPopup.show()
	$CanvasLayer/JohnPopup.set_text(john_dialogue.john_dialogues("1"))


func show_barry_dialogue():
	$CanvasLayer/BarryPopup.show()
	$CanvasLayer/BarryPopup.set_text(barry_dialogue.barry_dialogues("1"))


func intro():
	$CanvasLayer/PlayerPopup.show()
	$CanvasLayer/PlayerPopup.set_text(intro_dialogues("1"))


func intro_dialogues(id):
	match id:
		"1":
			return [["PLAYER: . . .scanning Quadrant 3, 216 to 322 degrees. Delta V looks good. Report on Quadrant 1, how are we looking Barry?", "[ -- continue -- ]"], ["0", "2"]]
		"2":
			return [["Everything's fine mate.", "[ -- continue -- ]"], ["0", "3"]]

func _on_BarryPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		barry_close = false
		$CanvasLayer/BarryPopup.hide()
		$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
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
		$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideOut')
	else:
		var next_dialogue = john_dialogue.john_dialogues(button_id)
		print("next_dialogue = ", next_dialogue)
		$CanvasLayer/JohnPopup.set_text(next_dialogue)


func _on_PlayerPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		$CanvasLayer/PlayerPopup.hide()
		$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
	else:
		match button_id:
			"2":
				$CanvasLayer/PlayerPopup.hide()
				$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
				barry_close = true
				can_click = false
				$CanvasLayer/BarryPopup.show()
				$CanvasLayer/BarryPopup.set_text(intro_dialogues(button_id))
			
		
