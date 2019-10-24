extends Area2D

var one = false
var two = false
var three = false
var four = false

var code_array = []
var current_code = []
var found_codes = []

func _ready():
	toggle_lights()
	code_array = generate_console_codes()
	print(code_array)


func _process(delta):
	check_match()


func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		print("current code: " + String(current_code))


func generate_console_codes():
	var code
	while code_array.size() < 4:
		code = get_node('/root/Main/CombinationGenerator').generate_combination()
		if code != [0, 0, 0, 0]:
			for c in code_array:
				if c == code:
					code = get_node('/root/Main/CombinationGenerator').generate_combination()
			code_array.append(code)
	return code_array


func generate_combination():
	var combination = []
	for number in range(4):
		randomize()
		combination.append(randi() % 2)
	return combination


func toggle_lights():
	if one:
		$GridContainer/ConsoleButton1.id = 1
		$GridContainer/OneZero.set_modulate(Color('ff2828'))
		$GridContainer/OneOne.set_modulate(Color('ffffff'))
	else:
		$GridContainer/ConsoleButton1.id = 0
		$GridContainer/OneZero.set_modulate(Color('ffffff'))
		$GridContainer/OneOne.set_modulate(Color('ff2828'))
	if two:
		$GridContainer/ConsoleButton2.id = 1
		$GridContainer/TwoZero.set_modulate(Color('ff2828'))
		$GridContainer/TwoOne.set_modulate(Color('ffffff'))
	else:
		$GridContainer/ConsoleButton2.id = 0
		$GridContainer/TwoZero.set_modulate(Color('ffffff'))
		$GridContainer/TwoOne.set_modulate(Color('ff2828'))
	if three:
		$GridContainer/ConsoleButton3.id = 1
		$GridContainer/ThreeZero.set_modulate(Color('ff2828'))
		$GridContainer/ThreeOne.set_modulate(Color('ffffff'))
	else:
		$GridContainer/ConsoleButton3.id = 0
		$GridContainer/ThreeZero.set_modulate(Color('ffffff'))
		$GridContainer/ThreeOne.set_modulate(Color('ff2828'))
	if four:
		$GridContainer/ConsoleButton4.id = 1
		$GridContainer/FourZero.set_modulate(Color('ff2828'))
		$GridContainer/FourOne.set_modulate(Color('ffffff'))
	else:
		$GridContainer/ConsoleButton4.id = 0
		$GridContainer/FourZero.set_modulate(Color('ffffff'))
		$GridContainer/FourOne.set_modulate(Color('ff2828'))
	get_current_code()


func get_current_code():
	current_code = []
	current_code.append($GridContainer/ConsoleButton1.id)
	current_code.append($GridContainer/ConsoleButton2.id)
	current_code.append($GridContainer/ConsoleButton3.id)
	current_code.append($GridContainer/ConsoleButton4.id)


func check_match():
	var code_index
	for code in code_array:
		if current_code == code:
			found_codes.append(code)
			code_index = code_array.find(code)
			code_array.remove(code_index)


func _on_ConsoleButton1_pressed():
	one = not one
	toggle_lights()


func _on_ConsoleButton2_pressed():
	two = not two
	toggle_lights()


func _on_ConsoleButton3_pressed():
	three = not three
	toggle_lights()


func _on_ConsoleButton4_pressed():
	four = not four
	toggle_lights()
