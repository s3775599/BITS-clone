extends Area2D

var one = false
var two = false
var three = false
var four = false


func _ready():
	toggle_lights()
#	code_array = generate_console_codes()


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
	Global.get_current_code()


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
