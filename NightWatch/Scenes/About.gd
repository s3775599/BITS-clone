extends Control

func _ready():
	$About/Control/Body.push_align(RichTextLabel.ALIGN_CENTER)
	$About/Control/Heading.push_align(RichTextLabel.ALIGN_CENTER)