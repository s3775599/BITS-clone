extends Area2D

onready var audio_stream_player = get_node('/root/Main/AudioStreamPlayer')

# Bools for panel buttons
var one = false
var two = false
var three = false
var four = false


func _ready():
	# Begins with lights active (all set to '0' [false])
	toggle_lights()


func toggle_lights():
	# Sets panel light to 1 or 0 positions
	if one:
		$ConsoleButton1.id = 1
	else:
		$ConsoleButton1.id = 0
	if two:
		$ConsoleButton2.id = 1
	else:
		$ConsoleButton2.id = 0
	if three:
		$ConsoleButton3.id = 1
	else:
		$ConsoleButton3.id = 0
	if four:
		$ConsoleButton4.id = 1
	else:
		$ConsoleButton4.id = 0
	get_current_code()


# Checks light positions and adds to the global array
func get_current_code():
	Global.current_code = []
	Global.current_code.append($ConsoleButton1.id)
	Global.current_code.append($ConsoleButton2.id)
	Global.current_code.append($ConsoleButton3.id)
	Global.current_code.append($ConsoleButton4.id)

func click():
	audio_stream_player.stream = load (Global.console_click1)
	audio_stream_player.play() 

# Signals to toggle lights
func _on_ConsoleButton1_pressed():
	click()
	# Toggles boolean var
	one = not one
	# Updates lights
	toggle_lights()


func _on_ConsoleButton2_pressed():
	click()
	two = not two
	toggle_lights()


func _on_ConsoleButton3_pressed():
	click()
	three = not three
	toggle_lights()


func _on_ConsoleButton4_pressed():
	click()
	four = not four
	toggle_lights()
