extends Control

# Vars for dialogue nodes
onready var intro_dialogue = get_node('Dialogues/IntroDialogue')
onready var john_dialogue = get_node("Dialogues/JohnDialogue")
onready var barry_dialogue = get_node("Dialogues/BarryDialogue")

onready var t = $Timer

func _ready():
	# Set global current scene vars
	Global.current_scene = self
	Global.intro = true
	# Play fade-in animation
	$AnimationPlayer.play("FadeIn")
	# set and starts timer
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# PLays second short animation to lower lights for dialogue
	$AnimationPlayer.play("LowerLights")
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# Runs the intro sequence
	$BackgroundSFX.play()
	intro()
	


func _input(event):
	# Shortcut to skip the Intro
	if Input.is_action_just_pressed("ui_cancel"):
		Global.close_dialogues()
		Global.scene_change("res://Scenes/Main.tscn")


func intro():
	show_player()
	# Calls the first Intro dialogue lines from the intro_dialogue script
	$Popups/PlayerPopup.set_text(intro_dialogue.intro_dialogues("i1"))
	


# Shows player dialogue box
func show_player():
	Global.player_close = true
	$Popups/PlayerPopup.show()


func darken_background():
	# Modulates the background while a dialogue is on-screen
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
