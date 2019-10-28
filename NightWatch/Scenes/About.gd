extends Control

func _ready():
	$About/Control/Body.push_align(RichTextLabel.ALIGN_CENTER)
	print("this is a print")