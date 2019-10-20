extends Node2D

onready var lever1 = get_node("Console/Lever1")
onready var lever2 = get_node("Console/Lever2")
onready var button1 = get_node("Console/Button1")
onready var button2 = get_node("Console/Button2")

onready var screen1 = get_node("Images/AK47")
onready var screen2 = get_node("Images/Barry")
onready var screen3 = get_node("Images/RussianFlag")
onready var screen4 = get_node("Images/RussianText")
onready var screen5 = get_node("Images/MiddleScreen")

onready var options = [button1, button2, lever1, lever2]

var currentSequence = [0,0,0,0]

func _ready():
	pass # Replace with function body.

func _process(delta):
	for x in len(options):
		if options[x].pressed == true:
			currentSequence[x] = 1
		else:
			currentSequence[x] = 0
	check_sequence()
	if Input.is_action_pressed("ui_down"):
		print(currentSequence)

func check_sequence():
	if currentSequence[0] == 1:
		#button1 = on
		if currentSequence[1] == 1:
			#button2 is on
			if currentSequence[2] == 1:
				#lever1 is on
				if currentSequence[3] == 1:
					#lever2 is on
					# currentSequence == 1,1,1,1
					setScreenState(1)
				else:
					#lever2 is off
					setScreenState(2)
			else:
				#lever1 is off
				setScreenState(3)
		else:
			#button2 is off
			setScreenState(4)
	else:
		#button1 = off
		setScreenState(5)


func setScreenState(x):
	match x:
		1:
			screen1.visible = false
		2:
			screen2.visible = false
		3:
			screen2.visible = true
			screen3.visible = false
		4:
			screen3.visible = true
			screen4.visible = false
			screen3.visible = true
		5:
			screen1.visible = false
			screen3.visible = true
			screen4.visible = false
			screen2.visible = true
#		6:
#		7:
#		8:
#		9:
#		10:
#		11:
#		12:
#		13:
#		14:
#		15: