extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# game will quit if user hits escape - might wanna take this out after testing phase
	if Input.is_action_pressed("ui_exit"):
      get_tree().quit()
