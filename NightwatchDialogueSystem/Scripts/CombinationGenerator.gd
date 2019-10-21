extends Node

func generate_combination():
	var combination = []
	for number in range(4):
		randomize()
		combination.append(randi() % 2)
	return combination
