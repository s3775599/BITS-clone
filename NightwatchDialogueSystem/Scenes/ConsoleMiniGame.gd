extends Node2D


var one = false
var two = false
var three = false
var four = false

var code_array = []
var current_code = []

#onready var lever1 = get_node("Console/Lever1")
#onready var lever2 = get_node("Console/Lever2")
#onready var button1 = get_node("Console/Button1")
#onready var button2 = get_node("Console/Button2")
#
#onready var screen1 = get_node("Images/AK47")
#onready var screen2 = get_node("Images/Barry")
#onready var screen3 = get_node("Images/RussianFlag")
#onready var screen4 = get_node("Images/RussianText")
#onready var screen5 = get_node("Images/MiddleScreen")
#
#onready var options = [button1, button2, lever1, lever2]

#var currentSequence = [0,0,0,0]

func _ready():
	toggle_lights()
	print("codes: " + String(generate_console_codes()))

func _process(delta):
	check_match()
#	for x in len(options):
#		if options[x].pressed == true:
#			currentSequence[x] = 1
#		else:
#			currentSequence[x] = 0
#	check_sequence()
#	if Input.is_action_pressed("ui_down"):
#		print(currentSequence)

#func check_sequence():
#	if currentSequence[0] == 1:
#		#button1 = on
#		if currentSequence[1] == 1:
#			#button2 is on
#			if currentSequence[2] == 1:
#				#lever1 is on
#				if currentSequence[3] == 1:
#					#lever2 is on
#					# currentSequence == 1,1,1,1
#					setScreenState(1)
#				else:
#					#lever2 is off
#					setScreenState(2)
#			else:
#				#lever1 is off
#				setScreenState(3)
#		else:
#			#button2 is off
#			setScreenState(4)
#	else:
#		#button1 = off
#		setScreenState(5)
#
#
#func setScreenState(x):
#	match x:
#		1:
#			screen1.visible = false
#		2:
#			screen2.visible = false
#		3:
#			screen2.visible = true
#			screen3.visible = false
#		4:
#			screen3.visible = true
#			screen4.visible = false
#			screen3.visible = true
#		5:
#			screen1.visible = false
#			screen3.visible = true
#			screen4.visible = false
#			screen2.visible = true
##		6:
##		7:
##		8:
##		9:
##		10:
##		11:
##		12:
##		13:
##		14:
##		15:


func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		print("current code: " + String(current_code))


func generate_console_codes():
    var code
    var code_array = []
    for i in range(4):
        code = $CombinationGenerator.generate_combination()
        if code != [0, 0, 0, 0]:
            for c in code_array:
                if c == code:
                    code = $CombinationGenerator.generate_combination()
            code_array.append(code)
        else:
            i += 1
    return code_array


func _on_One_pressed():
	one = not one
	toggle_lights()

func _on_Two_pressed():
	two = not two
	toggle_lights()

func _on_Three_pressed():
	three = not three
	toggle_lights()

func _on_Four_pressed():
	four = not four
	toggle_lights()


func generate_combination():
	var combination = []
	for number in range(4):
		randomize()
		combination.append(randi() % 2)
	return combination


func generate_console_codes():
	var code
	for i in range(4):
		code = generate_combination()
		if code != [0, 0, 0, 0]:
			for c in code_array:
				if c == code:
					code = generate_combination()
			code_array.append(code)
		else:
			i += 1
	return code_array

func toggle_lights():
	if one:
		$Panel/GridContainer/ConsoleButton1.id = 1
		$Panel/GridContainer/OneOff.set_modulate(Color('0092bf'))
		$Panel/GridContainer/OneOn.set_modulate(Color('ffffff'))
	else:
		$Panel/GridContainer/ConsoleButton1.id = 0
		$Panel/GridContainer/OneOff.set_modulate(Color('ffffff'))
		$Panel/GridContainer/OneOn.set_modulate(Color('0092bf'))
	if two:
		$Panel/GridContainer/ConsoleButton2.id = 1
		$Panel/GridContainer/TwoOff.set_modulate(Color('0092bf'))
		$Panel/GridContainer/TwoOn.set_modulate(Color('ffffff'))
	else:
		$Panel/GridContainer/ConsoleButton2.id = 0
		$Panel/GridContainer/TwoOff.set_modulate(Color('ffffff'))
		$Panel/GridContainer/TwoOn.set_modulate(Color('0092bf'))
	if three:
		$Panel/GridContainer/ConsoleButton3.id = 1
		$Panel/GridContainer/ThreeOff.set_modulate(Color('0092bf'))
		$Panel/GridContainer/ThreeOn.set_modulate(Color('ffffff'))
	else:
		$Panel/GridContainer/ConsoleButton3.id = 0
		$Panel/GridContainer/ThreeOff.set_modulate(Color('ffffff'))
		$Panel/GridContainer/ThreeOn.set_modulate(Color('0092bf'))
	if four:
		$Panel/GridContainer/ConsoleButton4.id = 1
		$Panel/GridContainer/FourOff.set_modulate(Color('0092bf'))
		$Panel/GridContainer/FourOn.set_modulate(Color('ffffff'))
	else:
		$Panel/GridContainer/ConsoleButton4.id = 0
		$Panel/GridContainer/FourOff.set_modulate(Color('ffffff'))
		$Panel/GridContainer/FourOn.set_modulate(Color('0092bf'))
	get_current_code()


func get_current_code():
	current_code = []
	current_code.append($Panel/GridContainer/ConsoleButton1.id)
	current_code.append($Panel/GridContainer/ConsoleButton2.id)
	current_code.append($Panel/GridContainer/ConsoleButton3.id)
	current_code.append($Panel/GridContainer/ConsoleButton4.id)


func check_match():
	var code_index
	for code in code_array:
		if current_code == code:
			print("found a code: " + String(code))
			code_index = code_array.find(code)
			code_array.remove(code_index)
			print("codes: " + String(code_array))