extends Control

onready var outro_dialogue = get_node('Dialogues/OutroDialogue')
onready var john_dialogue = get_node("Dialogues/JohnDialogue")
onready var barry_dialogue = get_node("Dialogues/BarryDialogue")

onready var t = $Timer

func _ready():
	Global.current_scene = self
	Global.outro = true
	if Global.barry_gone:
		$Crew/BarryConsole/AnimationPlayer.play('BarryAirlock')
	$AnimationPlayer.play("FadeIn")
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$AnimationPlayer.play("LowerLights")
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	outro()

func _input(event):
	if Input.is_action_just_pressed("ui_select"):
		toggle_barry_airlock()
	if Input.is_action_just_pressed("ui_b"):
		toggle_barry_solved()
	if Input.is_action_just_pressed("ui_j"):
		toggle_john_solved()


func toggle_barry_solved():
	Global.barry_solved = not Global.barry_solved
	print("Barry solved: " + String(Global.barry_solved))


func toggle_john_solved():
	Global.john_solved = not Global.john_solved
	print("John solved: " + String(Global.john_solved))


func toggle_barry_airlock():
	Global.barry_gone = not Global.barry_gone
	print("Barry airlock: " + String(Global.barry_gone))


func outro():
	show_player()
	# Calls the first Intro dialogue lines from the intro_dialogue script
	$Popups/PlayerPopup.set_text(outro_dialogue.outro_dialogues("o1"))


# Shows player dialogue box
func show_player():
	Global.player_close = true
	$Popups/PlayerPopup.show()


func darken_background():
	$BackgroundIntro/BackgroundWallpaper.set_modulate(Color('464646'))
	$Crew/JohnConsole/JohnConsoleSprite.set_modulate(Color('464646'))
	$Crew/BarryConsole/BarryConsoleSprite.set_modulate(Color('464646'))


# Restores the darkened background
func normalise_background():
	$BackgroundIntro/BackgroundWallpaper.set_modulate(Color(1,1,1))
	$Crew/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
	$Crew/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))


func _on_BarryPopup_button_id(button_id):
	Global.barry_button(button_id)


func _on_JohnPopup_button_id(button_id):
	Global.john_button(button_id)


func _on_PlayerPopup_button_id(button_id):
	Global.player_button(button_id)
