extends Node2D
# Refrences
# Audio SFX from : https://kenney.nl/assets/ui-audio
# Music file from : https://freesound.org/people/zimbot/sounds/322054/ --- CC Licence
# Music file from : https://freesound.org/people/GeronimoGeronimo/sounds/338065/ --- CC Licence

func _on_NewGameArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		$SFXSelect.play()
		get_tree().change_scene("res://Scenes/Main.tscn")


func _on_AboutGameArea_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func _on_ExitGameArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		$SFXSelect.play()
		get_tree().quit()


# Mouse over color changes

func _on_NewGameArea_mouse_entered():
	$NewGameArea/NewGameSprite.set_modulate(Color('a9a9a9'))
	$SFXRollOver.play()

func _on_NewGameArea_mouse_exited():
	$NewGameArea/NewGameSprite.set_modulate(Color(1,1,1))

func _on_AboutGameArea_mouse_entered():
	$AboutGameArea/AboutGameSprite.set_modulate(Color('a9a9a9'))
	$SFXRollOver.play()

func _on_AboutGameArea_mouse_exited():
	$AboutGameArea/AboutGameSprite.set_modulate(Color(1,1,1))

func _on_ExitGameArea_mouse_entered():
	$ExitGameArea/ExitGameSprite.set_modulate(Color('a9a9a9'))
	$SFXRollOver.play()

func _on_ExitGameArea_mouse_exited():
	$ExitGameArea/ExitGameSprite.set_modulate(Color(1,1,1))






