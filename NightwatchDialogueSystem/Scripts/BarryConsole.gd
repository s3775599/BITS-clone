extends Area2D

func _ready():
	pass


func _on_BarryConsole_mouse_entered():
	$JohnConsoleSprite.set_modulate(Color('4d39df'))


func _on_BarryConsole_mouse_exited():
	$JohnConsoleSprite.set_modulate(Color('ffffff'))


func _on_BarryConsole_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
