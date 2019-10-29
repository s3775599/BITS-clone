extends Node2D
# background image: https://opengameart.org/content/space-backgrounds-0
#	This work by Florian R. A. Angermeier (fraang) is licensed under 
#	the Creative Commons Attribution - ShareAlike 3.0 Unported License.

onready var timer = get_node("Timer")

var scroll_x = 0

func _ready():
	$Music.play()
	run_animations()

func _process(delta):
	scroll_x -= 200 * delta
	$ParallaxBackground.scroll_offset.x = scroll_x
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Main.tscn")

func run_animations():
	$NightWatch.play("NightWatch",-1,.8,false)
	timer.start()
	$Exit.start()

func _on_Timer_timeout():
	$Names.play("name",-1,.8,false)

func _on_Exit_timeout():
	# TODO: fade this back to main
	get_tree().change_scene("res://Scenes/Main.tscn")