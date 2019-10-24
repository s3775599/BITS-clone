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
	print($Sprite/GridContainer/ConsoleButton1.id)
	code_array = generate_console_codes()
	print("codes: " + String(code_array))


func _process(delta):
	check_match()


func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		print("current code: " + String(current_code))


func generate_console_codes():
    var code
    var code_array = []
    for i in range(4):
        code = get_node('/root/Main/CombinationGenerator').generate_combination()
        if code != [0, 0, 0, 0]:
            for c in code_array:
                if c == code:
                    code = get_node('/root/Main/CombinationGenerator').generate_combination()
            code_array.append(code)
        else:
            i += 1
    return code_array


func generate_combination():
	var combination = []
	for number in range(4):
		randomize()
		combination.append(randi() % 2)
	return combination


func toggle_lights():
	if one:
		$Sprite/GridContainer/ConsoleButton1.id = 1
		$Sprite/GridContainer/OneZero.set_modulate(Color('ff2828'))
		$Sprite/GridContainer/OneOne.set_modulate(Color('ffffff'))
	else:
		$Sprite/GridContainer/ConsoleButton1.id = 0
		$Sprite/GridContainer/OneZero.set_modulate(Color('ffffff'))
		$Sprite/GridContainer/OneOne.set_modulate(Color('ff2828'))
	if two:
		$Sprite/GridContainer/ConsoleButton2.id = 1
		$Sprite/GridContainer/TwoZero.set_modulate(Color('ff2828'))
		$Sprite/GridContainer/TwoOne.set_modulate(Color('ffffff'))
	else:
		$Sprite/GridContainer/ConsoleButton2.id = 0
		$Sprite/GridContainer/TwoZero.set_modulate(Color('ffffff'))
		$Sprite/GridContainer/TwoOne.set_modulate(Color('ff2828'))
	if three:
		$Sprite/GridContainer/ConsoleButton3.id = 1
		$Sprite/GridContainer/ThreeZero.set_modulate(Color('ff2828'))
		$Sprite/GridContainer/ThreeOne.set_modulate(Color('ffffff'))
	else:
		$Sprite/GridContainer/ConsoleButton3.id = 0
		$Sprite/GridContainer/ThreeZero.set_modulate(Color('ffffff'))
		$Sprite/GridContainer/ThreeOne.set_modulate(Color('ff2828'))
	if four:
		$Sprite/GridContainer/ConsoleButton4.id = 1
		$Sprite/GridContainer/FourZero.set_modulate(Color('ff2828'))
		$Sprite/GridContainer/FourOne.set_modulate(Color('ffffff'))
	else:
		$Sprite/GridContainer/ConsoleButton4.id = 0
		$Sprite/GridContainer/FourZero.set_modulate(Color('ffffff'))
		$Sprite/GridContainer/FourOne.set_modulate(Color('ff2828'))
	get_current_code()
	print(code_array)


func get_current_code():
	current_code = []
	current_code.append($Sprite/GridContainer/ConsoleButton1.id)
	current_code.append($Sprite/GridContainer/ConsoleButton2.id)
	current_code.append($Sprite/GridContainer/ConsoleButton3.id)
	current_code.append($Sprite/GridContainer/ConsoleButton4.id)


func check_match():
	var code_index
	for code in code_array:
		if current_code == code:
			found_codes.append(code)
			print("found codes:" + String(found_codes))
#			print("found a code: " + String(code))
			code_index = code_array.find(code)
			code_array.remove(code_index)
#			print("codes: " + String(code_array))

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
