extends Control

onready var t = $Timer

#vars for console puzzle
var code_array = []
#onready var russian_text = get_node("ConsoleMiniGame/Images/RussianText")
#onready var russian_flag = get_node("ConsoleMiniGame/Images/RussianFlag")
#onready var ak47 = get_node("ConsoleMiniGame/Images/AK47")
#onready var barryImage = get_node("ConsoleMiniGame/Images/Barry")
#onready var images = [russian_text,russian_flag,ak47,barryImage]

# Godot's way of storing a Node as a variable
onready var intro_dialogue = get_node("Dialogues/IntroDialogue")
onready var john_dialogue = get_node("Dialogues/JohnDialogue")
onready var barry_dialogue = get_node("Dialogues/BarryDialogue")
onready var console = get_node("BackgroundArea/Console")


func _ready():
	Global.current_scene = self
	Global.intro = false
	Global.can_click = true
	$AnimationPlayer.play('FadeIn')
	play_russian_text()


# This function updates every frame
func _process(delta):
	# darkens background when a dialogue is active
	if Global.john_close or Global.barry_close or Global.player_close:
		darken_background()
		Global.can_click = false
#
#	# End Game condition
#	if len(console.code_array) == 0:
#		print("GAME COMPLETE..... START OUTRO!!!")


# Checks all input signals
func _input(event):
	# Quits from the current dialogue
	if Input.is_action_just_pressed("ui_cancel"):
#		if $BackgroundArea/Images.visible == false:
#			$BackgroundArea/Images.visible = true
		normalise_background()
		Global.close_dialogues()
	# Manually starts the intro dialogue (for testing purposes)
	if Input.is_action_just_pressed("ui_down"):
		get_tree().change_scene("res://Scenes/Intro.tscn")


# Collects id of pressed button from John dialogue
func _on_JohnPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		Global.close_dialogues()
		normalise_background()
	elif button_id == "airlock_close":
		john_fix_airlock()
	else:
		var next_dialogue = john_dialogue.john_dialogues(button_id)
		$Popups/JohnPopup.set_text(next_dialogue)


# Collects id of pressed button from Barry dialogue
func _on_BarryPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		Global.close_dialogues()
		normalise_background()
	elif button_id == "airlock_barry_out":
		airlock_barry_out()
	else:
		var next_dialogue = barry_dialogue.barry_dialogues(button_id)
		$Popups/BarryPopup.set_text(next_dialogue)


func airlock_barry_out():
	Global.barry_close = false
	Global.can_click = false
	$Popups/BarryPopup.hide()
	
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$Crew/BarryConsole/AnimationPlayer.play('BarryAirlock')
	t.set_wait_time(1)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	Global.show_john()
	$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("airlock1"))


func john_fix_airlock():
	Global.john_close = false
	Global.can_click = false
	Global.hide_john()
	t.set_wait_time(4)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$AnimationPlayer.stop(true)
#	darken_background()
	$BackgroundMain.set_modulate(Color('464646'))
	$Crew/BarryConsole.set_modulate(Color('464646'))
	$Crew/JohnConsole.set_modulate(Color('464646'))
	Global.show_john()
	$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("airlock7"))


# Collects id of pressed button from Player dialogue
func _on_PlayerPopup_button_id(button_id):
	# Ends the dialogue if the last button signal was "end"
	if button_id == "end":
		if $BackgroundArea/Images.visible == false:
			$BackgroundArea/Images.visible = true
		$BackgroundArea/BackgroundSprite.set_modulate(Color('ffffff'))
		Global.close_dialogues()
	else:
		# Calls the next line of dialogue
		intro_dialogue.intro_sequence(button_id)

func darken_background():
	$BackgroundMain.set_modulate(Color('464646'))
	$Crew/JohnConsole.set_modulate(Color('464646'))
	$Crew/BarryConsole.set_modulate(Color('464646'))


# Restores the darkened background
func normalise_background():
	$BackgroundMain.set_modulate(Color(1,1,1))
	$Crew/JohnConsole.set_modulate(Color(1,1,1))
	$Crew/BarryConsole.set_modulate(Color(1,1,1))

#
## Link to signal sent from Console.gd if a match is found
#func _on_Console_found():
#	print("Got signal found")
#	$BackgroundArea/Images/MiddleScreen.set_modulate(Color('61a735'))
#	get_rand_image().visible = false
#
#
#func get_rand_image():
#	for x in len(images):
#		if images[x].visible:
#			return images[x]
#
#
#func _on_Console_not_found():
#	print("Got signal not found")
#	$BackgroundArea/Images/MiddleScreen.set_modulate(Color('b42727'))


func _on_JohnConsole_mouse_entered():
	if not Global.john_close:
		$Crew/JohnConsole/JohnConsoleSprite.set_modulate(Color('4d39df'))
	else:
		Global.can_click = false


func _on_JohnConsole_mouse_exited():
	$Crew/JohnConsole/JohnConsoleSprite.set_modulate(Color(1, 1, 1))
	Global.can_click = true


func _on_JohnConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Global.can_click == true:
		if Global.barry_close:
			Global.hide_barry()
		Global.show_john()
		$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("1"))


func _on_BarryConsole_mouse_entered():
	if not Global.barry_close:
		$Crew/BarryConsole/BarryConsoleSprite.set_modulate(Color('4d39df'))
	else:
		Global.can_click = false


func _on_BarryConsole_mouse_exited():
	$Crew/BarryConsole/BarryConsoleSprite.set_modulate(Color(1, 1, 1))
	Global.can_click = true


func _on_BarryConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Global.can_click == true:
		if Global.john_close:
			Global.hide_john()
		Global.show_barry()
		$Popups/BarryPopup.set_text(barry_dialogue.barry_dialogues("1"))

func play_russian_text():
	var node = $BackgroundMain/BackgroundWallpaper/RightLeftGlass/RussianText
	var russian_text = ["Он благополучно избегнул встречи с своею хозяйкой на лестнице. Каморка его приходилась под самою кровлей высокого пятиэтажного дома и походила более на шкаф, чем на квартиру. Квартирная же хозяйка его, у которой он нанимал эту каморку с обедом и прислугой", "помещалась одною лестницей ниже, в отдельной квартире, и каждый раз, при выходе на улицу, ему непременно надо было проходить мимо хозяйкиной кухни, почти всегда настежь отворенной на лестницу. И каждый раз молодой человек, проходя мимо, чувствовал какое-то болезненное и", "трусливое ощущение, которого стыдился и от которого морщился. Он был должен кругом хозяйке и боялся с нею встретиться. Не то чтоб он был так труслив и забит, совсем даже напротив; но с некоторого времени он был в раздражительном и напряженном состоянии, похожем на ипохондрию."]
#	var text = "Он благополучно избегнул встречи с своею хозяйкой на лестнице. Каморка его приходилась под самою кровлей высокого пятиэтажного дома и походила более на шкаф, чем на квартиру. Квартирная же хозяйка его, у которой он нанимал эту каморку с обедом и прислугой"
	while true:
		for text in russian_text:
			background_text_display(text, node)
			t.set_wait_time(5)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")


func background_text_display(text, display_node):
	$BackgroundMain/BackgroundWallpaper/RightLeftGlass/RussianText.bbcode_text = String("")
	#create a timer to print text like a typewriter
	var t = Timer.new()
	t.set_wait_time(.005)
	t.set_one_shot(true)
	self.add_child(t)
	for letter in text:
		t.start()
		print(letter)
		display_node.bbcode_text += String(letter)
		yield(t, "timeout")






