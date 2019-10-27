extends Node

func _process(delta):
	check_match()


func generate_combination():
	var combination = []
	for number in range(4):
		randomize()
		combination.append(randi() % 2)
	return combination


func generate_console_codes():
	var code
	while Global.code_array.size() < 4:
		code = generate_combination()
		if code != [0, 0, 0, 0]:
			for c in Global.code_array:
				if c == code:
					Global.code_array.remove(Global.code_array.find(code))
#					code = generate_combination()
			Global.code_array.append(code)
	print(Global.code_array)
	return Global.code_array


func check_match():
	var code_index
	for code in Global.code_array:
		if Global.current_code == code:
			Global.found_codes.append(code)
			code_index = Global.code_array.find(code)
			Global.code_array.remove(code_index)
