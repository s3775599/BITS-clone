extends Node2D
# Refrences
# Audio SFX from : https://kenney.nl/assets/ui-audio
# Music file from : https://freesound.org/people/zimbot/sounds/322054/ --- CC Licence
# Music file from : https://freesound.org/people/GeronimoGeronimo/sounds/338065/ --- CC Licence

func _ready():
	Global.title = true

func _on_NewGameArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		$SFXSelect.play()
		get_tree().change_scene("res://Scenes/Intro.tscn")


func _on_AboutGameArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		toggle_about()

func _on_Back_pressed():
	toggle_about()

func toggle_about():
	$AboutCtrl.visible = not $AboutCtrl.visible
	$Buttons.visible = not $Buttons.visible
	$Options.visible = not $Options.visible


func _on_ExitGameArea_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		$SFXSelect.play()
		get_tree().quit()

# Mouse over color changes

func _on_NewGameArea_mouse_entered():
	$Options/NewGameArea/NewGameSprite.set_modulate(Color('a9a9a9'))
	$SFXRollOver.play()

func _on_NewGameArea_mouse_exited():
	$Options/NewGameArea/NewGameSprite.set_modulate(Color(1,1,1))

func _on_AboutGameArea_mouse_entered():
	$Options/AboutGameArea/AboutGameSprite.set_modulate(Color('a9a9a9'))
	$SFXRollOver.play()

func _on_AboutGameArea_mouse_exited():
	$Options/AboutGameArea/AboutGameSprite.set_modulate(Color(1,1,1))

func _on_ExitGameArea_mouse_entered():
	$Options/ExitGameArea/ExitGameSprite.set_modulate(Color('a9a9a9'))
	$SFXRollOver.play()

func _on_ExitGameArea_mouse_exited():
	$Options/ExitGameArea/ExitGameSprite.set_modulate(Color(1,1,1))


