extends Node

var barry_close = false
var john_close = false


func _process(delta):
	if john_close or barry_close:
		$BackgroundArea/BackgroundSprite.set_modulate(Color('464646'))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('464646'))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('464646'))


func intro_dialogues(id):
	match id:
		"1":
			return [["PLAYER: . . .scanning Quadrant 3, 216 to 322 degrees. Delta V looks good. Report on Quadrant 1, how are we looking Barry?", "[ -- continue -- ]"], ["0", "2"]]
		"2":
			return [["Everything's fine mate.", "[ -- continue -- ]"], ["0", "3"]]


func intro_sequence(button_id):
	match button_id:
			"2":
				$CanvasLayer/PlayerPopup.hide()
				$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
				barry_close = true
#				can_click = false
				$CanvasLayer/BarryPopup.show()
				intro_dialogues(button_id)