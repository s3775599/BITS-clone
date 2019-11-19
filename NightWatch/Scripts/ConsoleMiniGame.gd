extends Node

# Checks for a match on every frame
func _process(delta):
	check_match()


# Generates an individual panel code
func generate_combination():
	var combination = []
	# Loops 4 times
	for number in range(4):
		# Sets a random seed
		randomize()
		# Adds a randon number % 2 (options will be 0 or 1 only)
		combination.append(randi() % 2)
	return combination


# Generates all console minigame codes
func generate_console_codes():
	var code
	# Loops until array contains 4 codes
	while Global.code_array.size() < 4:
		# Gen a single combination
		code = generate_combination()
		# Checks if combination is valid (not all 0s, not a duplicate)
		if code != [0, 0, 0, 0]:
			for c in Global.code_array:
				if c == code:
					Global.code_array.remove(Global.code_array.find(code))
			# Adds code to global array
			Global.code_array.append(code)
	# Prints all codes to console for dev testing
	print(Global.code_array)
	return Global.code_array


# Checks for a match from found codes array
func check_match():
	var code_index
	# for each loop to check codes
	for code in Global.code_array:
		# When a match is found, add it to the found codes array
		if Global.current_code == code:
			Global.found_codes.append(code)
			# Find and remove code from code array
			code_index = Global.code_array.find(code)
			Global.code_array.remove(code_index)
