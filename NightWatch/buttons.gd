extends Area2D

# sequence is the array to match
var sequence = [3,5,6]

# clicked is the array the player is filling with their 'clicks'
var clicked = [0,0,0]

# the position in the array
var clickPosition = 0

# has the puzzle been solved controlling whether the user can click on sprites anymore?
var solved = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# This will check if the sequence has been matched, I would of thought there was a better way to see if arrays are duplicates
# apparrently not.
func _process(delta):
	#$Control/CodeLabel.text = str(clicked[0]) + ',' + str(clicked[1]) + ',' + str(clicked[2])
	#if clickPosition < sequence.size():
	#	if clicked[0] == sequence[0] and clicked[1] == sequence[1] and clicked[2] == sequence[2]:
	#		$Control/WinLabel.visible = true
	# UNCOMMENT if we want to limit the amount of times they can try.
	#elif clickPosition > sequence.size():
	#	$Control/FailLabel.visible = true
	
	if clicked[0] == sequence[0] and clicked[1] == sequence[1] and clicked[2] == sequence[2]:
		#$Control/WinLabel.show()
		solved = true		
	else:
		#$Control/WinLabel.hide()
		solved = false
	if clicked[0] == 0 and clicked[1] == 1 and clicked[2] == 0:
		$Katyusha.play()
		print(clicked)


# This handles the input, it will cycle the current clicked position in the array
func _on_buttons_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# This condition checks for array position and if the puzzle has been solved
			if clickPosition < sequence.size() && !solved:
				if shape_idx == 0:
					$topLeft.visible = not $topLeft.visible
					clicked[clickPosition] = shape_idx
				elif shape_idx == 1:
					$topMiddle.visible = not $topMiddle.visible
					clicked[clickPosition] = shape_idx
				elif shape_idx == 2:
					$topRight.visible = not $topRight.visible
					clicked[clickPosition] = shape_idx
				elif shape_idx == 3:
					$botLeft.visible = not $botLeft.visible
					clicked[clickPosition] = shape_idx
				elif shape_idx == 5:
					$botMiddle.visible = not $botMiddle.visible
					clicked[clickPosition] = shape_idx
				elif shape_idx == 6:
					$botRight.visible = not $botRight.visible
					clicked[clickPosition] = shape_idx
				clickPosition += 1
			else: 
				# reset the position
				clickPosition = 0