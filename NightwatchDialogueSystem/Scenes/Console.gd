extends Control

var one = false
var two = false
var three = false
var four = false

var code_array = []
var current_code = []

signal found
signal not_found

func _ready():
	toggle_lights()
	print("codes: " + String(generate_console_codes()))

#func _input(event):
#	if Input.is_action_just_pressed("ui_down"):
#		print("current code: " + String(current_code))

func _process(delta):
	pass

func _on_One_pressed():
	one = not one
	toggle_lights()
	check_match()

func _on_Two_pressed():
	two = not two
	toggle_lights()
	check_match()

func _on_Three_pressed():
	three = not three
	toggle_lights()
	check_match()

func _on_Four_pressed():
	four = not four
	toggle_lights()
	check_match()


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
	var found = false
	for code in code_array:
		if current_code == code:
			print("found a code: " + String(code))
			found = true
			code_index = code_array.find(code)
			code_array.remove(code_index)
			print("codes: " + String(code_array))
		else:
			found = false
	
	if found:
		emit_signal("found")
	else:
		emit_signal("not_found")