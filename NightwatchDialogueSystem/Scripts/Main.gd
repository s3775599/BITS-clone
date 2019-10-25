extends Control

onready var t = $Timer

# Godot's way of storing a Node as a variable
onready var intro_dialogue = get_node("Dialogues/IntroDialogue")
onready var john_dialogue = get_node("Dialogues/JohnDialogue")
onready var barry_dialogue = get_node("Dialogues/BarryDialogue")
onready var console = get_node("BackgroundArea/Console")

# Images on the central panels
onready var image1 = get_node('BackgroundMain/BackgroundWallpaper/CentreUpperLeftImage')
onready var image2 = get_node('BackgroundMain/BackgroundWallpaper/CentreUpperRightImage')
onready var image3 = get_node('BackgroundMain/BackgroundWallpaper/CentreLowerLeftImage')
onready var image4 = get_node('BackgroundMain/BackgroundWallpaper/CentreLowerRightImage')


func _ready():
	Global.current_scene = self
	Global.intro = false
	Global.can_click = true
	Global.code_array = $ConsoleMiniGame.generate_console_codes()
	$AnimationPlayer.play('FadeIn')
	# Plays the scrolling Russian text in the background
	play_russian_text1()
	play_russian_text2()


# This function updates every frame
func _process(delta):
	display_current_code()
	display_found_codes()
	check_for_completion()
	# darkens background when a dialogue is active
	if Global.john_close or Global.barry_close or Global.player_close:
		darken_background()
		Global.can_click = false


# Checks all input signals
func _input(event):
	# Quits from the current dialogue
	if Input.is_action_just_pressed("ui_cancel"):
		normalise_background()
		Global.close_dialogues()
	# Manually starts the intro dialogue (for testing purposes)
	if Input.is_action_just_pressed("ui_down"):
		get_tree().change_scene("res://Scenes/Intro.tscn")


func display_found_codes():
	var all_found = []
	for code in Global.found_codes:
		all_found.append(PoolStringArray(code).join("-"))
	$BackgroundMain/BackgroundWallpaper/CentreMiddleGlass/FoundCodes.bbcode_text = PoolStringArray(all_found).join("")


func display_current_code():
	$BackgroundMain/BackgroundWallpaper/CentreMiddleGlass/CurrentSequence.bbcode_text = PoolStringArray(Global.current_code).join("-")


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
	t.set_wait_time(5)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$AnimationPlayer.stop(true)
	self.set_modulate(Color(1, 1, 1))
	darken_background()
	Global.show_john()
	$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("airlock7"))


func darken_background():
	$BackgroundMain.set_modulate(Color('464646'))
	$Crew/JohnConsole.set_modulate(Color('464646'))
	$Crew/BarryConsole.set_modulate(Color('464646'))
	$Panel.set_modulate(Color('464646'))


# Restores the darkened background
func normalise_background():
	$BackgroundMain.set_modulate(Color(1,1,1))
	$Crew/JohnConsole.set_modulate(Color(1,1,1))
	$Crew/BarryConsole.set_modulate(Color(1,1,1))
	$Panel.set_modulate(Color(1,1,1))


# Collects id of pressed button from John dialogue
func _on_JohnPopup_button_id(button_id):
	Global.john_button(button_id)


# Collects id of pressed button from Barry dialogue
func _on_BarryPopup_button_id(button_id):
	Global.barry_button(button_id)


func _on_JohnConsole_mouse_entered():
	if  Global.john_close or Global.barry_close or Global.john_solved:
		Global.can_click = false
	else:
		$Crew/JohnConsole/JohnConsoleSprite.set_modulate(Color('4d39df'))


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
	if Global.barry_close or Global.john_close or Global.barry_solved:
		Global.can_click = false
	else:
		$Crew/BarryConsole/BarryConsoleSprite.set_modulate(Color('4d39df'))


func _on_BarryConsole_mouse_exited():
	$Crew/BarryConsole/BarryConsoleSprite.set_modulate(Color(1, 1, 1))
	Global.can_click = true


func _on_BarryConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Global.can_click == true:
		if Global.john_close:
			Global.hide_john()
		Global.show_barry()
		$Popups/BarryPopup.set_text(barry_dialogue.barry_dialogues("1"))


func play_russian_text1():
	var text_node_1 = $BackgroundMain/BackgroundWallpaper/LeftRightGlass/RussianText1
	var master_i_margarita = ["Однажды весною, в час небывало жаркого заката, в Москве, на Патриарших прудах, появились два", "гражданина. Первый из них, одетый в летнюю серенькую пару, был маленького роста, упитан, лыс, свою приличную шляпу", "пирожком нес в руке, а на хорошо выбритом лице его помещались сверхъестественных размеров очки в черной", "роговой оправе. Второй – плечистый, рыжеватый, вихрастый молодой человек в заломленной на затылок", "клетчатой кепке – был в ковбойке, жеваных белых брюках и в черных тапочках.Первый был не кто иной, как", "Михаил Александрович Берлиоз, председатель правления одной из крупнейших московских литературных ассоциаций,", "сокращенно именуемой МАССОЛИТ, и редактор толстого художественного журнала, а молодой спутник его – поэт", "Иван Николаевич Понырев, пишущий под псевдонимом Бездомный."]
	while true:
		for text in master_i_margarita:
			background_text_display(text, text_node_1, .1)
			t.set_wait_time(7)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")


func play_russian_text2():
	var text_node_2 = $BackgroundMain/BackgroundWallpaper/RightLeftGlass/RussianText2
	var prestupleniye_i_nakazaniye = ["Он благополучно избегнул встречи с своею хозяйкой на лестнице. Каморка его приходилась под самою кровлей", "высокого пятиэтажного дома и походила более на шкаф, чем на квартиру. Квартирная же хозяйка его, у которой он", "нанимал эту каморку с обедом и прислугой, помещалась одною лестницей ниже, в отдельной квартире, и каждый раз,", "при выходе на улицу, ему непременно надо было проходить мимо хозяйкиной кухни, почти всегда настежь", "отворенной на лестницу. И каждый раз молодой человек, проходя мимо, чувствовал какое-то болезненное и трусливое", "ощущение, которого стыдился и от которого морщился. Он был должен кругом хозяйке и боялся с нею встретиться."]
	while true:
		for text in prestupleniye_i_nakazaniye:
			background_text_display(text, text_node_2, .005)
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")


func background_text_display(text, display_node, wait_time):
	display_node.bbcode_text = String("")
	#create a timer to print text like a typewriter
	var t = Timer.new()
	t.set_wait_time(wait_time)
	t.set_one_shot(true)
	self.add_child(t)
	for letter in text:
		t.start()
		display_node.bbcode_text += String(letter)
		yield(t, "timeout")


func check_for_completion():
	match Global.found_codes.size():
		1:
			$BackgroundMain/BackgroundWallpaper/CentreUpperLeftImage.visible = false
		2:
			$BackgroundMain/BackgroundWallpaper/CentreUpperRightImage.visible = false
		3:
			$BackgroundMain/BackgroundWallpaper/CentreLowerLeftImage.visible = false
		4:
			$BackgroundMain/BackgroundWallpaper/CentreLowerRightImage.visible = false
			goto_outro()
		0:
			pass


func dialogue_solved():
	$Panel.found_codes.append($Panel.code_array[0])
	$Panel.code_array.remove(0)
	Global.close_dialogues()
	normalise_background()


func goto_outro():
	$AnimationPlayer.play("FadeOut")
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://Scenes/Title.tscn")
