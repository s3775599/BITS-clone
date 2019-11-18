extends Control

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
	# Sets global current scene vars
	Global.current_scene = self
	Global.intro = false
	Global.title = false
	Global.found_codes = []
	Global.can_click = true
	Global.barry_solved = false
	Global.john_solved = false
	# Generates minigame console codes
	Global.code_array = $ConsoleMiniGame.generate_console_codes()
	# Plays fade-in animation
	$AnimationPlayer.play('FadeIn')
	# Plays the scrolling Russian text in the background
	play_russian_text1()
	play_russian_text2()
	play_russian_text3()
	play_russian_text4()
	$BackgroundSFX.play()


# This function updates every frame
func _process(delta):
	# Shows the current panel code on the middle monitor
	display_current_code()
	# Shows found codes if/when discovered
	display_found_codes()
	# Check is the minigame has been won (all codes found)
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


# Formats and displays currently found codes
func display_found_codes():
	var all_found = []
	for code in Global.found_codes:
		all_found.append(PoolStringArray(code).join("-"))
	$BackgroundMain/BackgroundWallpaper/CentreMiddleGlass/FoundCodes.bbcode_text = PoolStringArray(all_found).join("")


# Formats and displays current code
func display_current_code():
	$BackgroundMain/BackgroundWallpaper/CentreMiddleGlass/CurrentSequence.bbcode_text = PoolStringArray(Global.current_code).join("-")


func john_smash():
	Global.hide_john()
	Global.can_click = false
	normalise_background()
	# Short pause
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# Barry is animated being sucked out the airlock
	$Crew/JohnConsole/AnimationPlayer.play('JohnConsoleSmash')
	# Another pause
	t.set_wait_time(3)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# Plays John's dialogue
	darken_background()
	Global.show_john()
	$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("fix"))


# Barry/airlock sequence
func airlock_barry_out():
	# Hide's Barry's close-up
	$Popups/BarryPopup.hide()
	Global.barry_close = false
	Global.can_click = false
	Global.barry_gone = true
	# Short pause
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# Barry is animated being sucked out the airlock
	$Crew/BarryConsole/AnimationPlayer.play('BarryAirlock')
	# Another pause
	t.set_wait_time(1)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# Plays John's dialogue
	Global.show_john()
	$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("airlock1"))


# John solves the airlock sequence
func john_fix_airlock():
	# Hides John's close-up
	Global.john_close = false
	Global.can_click = false
	Global.hide_john()
	# 3 second pause
	var t = Timer.new()
	t.set_wait_time(3)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# Stops the airlock warning lights animation
	$AnimationPlayer.stop(true)
	self.set_modulate(Color(1, 1, 1))
	darken_background()
	# Stops the warning siren
	$AudioStreamPlayer.stop()
	# Short pause
	t.set_wait_time(1)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# John comes back on-screen
	Global.show_john()
	$Popups/JohnPopup.set_text(john_dialogue.john_dialogues("airlock7"))


# Darkens the background while a dialogue is playing
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
	print("over john")
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
	print("over barry")
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


# Архипелаг ГУЛАГ. 1918–1956: Опыт художественного исследования. Т. 1 — Солженицын А.И.. [online]
# Православная художественная литература.
# Available at: https://azbyka.ru/fiction/arxipelag-gulag-tom-1-aleksandr-solzhenicyn/
# [Accessed 28 Oct. 2019].
func play_russian_text1():
	var text_node_1 = $BackgroundMain/BackgroundWallpaper/LeftLeftGlass/RussianText1
	var arhipelag_GULAG = ["Как попадают на этот таинственный Архипелаг? Туда ежечасно летят самолёты, плывут корабли, гремят", "поезда — но ни единая надпись на них не указывает места назначения. И билетные кассиры, и агенты Совтуриста и", "Интуриста будут изумлены, если вы спросите у них туда билет. Ни всего Архипелага в целом, ни одного из", "бесчисленных его островков они не знают, не слышали. Те, кто едут Архипелагом управлять — попадают", "туда через училища МВД. Те, кто едут Архипелаг охранять — призываются через военкоматы. А те, кто едут", "туда умирать, как мы с вами, читатель, те должны пройти непременно и единственно — через арест."]
	while true:
		for text in arhipelag_GULAG:
			background_text_display(text, text_node_1, .075)
			var t = Timer.new()
			t.set_wait_time(2.3)
			t.set_one_shot(false)
			self.add_child(t)
			t.start()
			yield(t, "timeout")


# ЭЛЕКТРОННАЯ БИБЛИОТЕКА ModernLib.Net. (n.d.). Мастер и Маргарита - Чтение (Весь текст). [online]
# Available at: http://modernlib.net/books/bulgakov_mihail_afanasevich/master_i_margarita/read
# [Accessed 28 Oct. 2019].
func play_russian_text2():
	var text_node_2 = $BackgroundMain/BackgroundWallpaper/LeftRightGlass/RussianText2
	var master_i_margarita = ["Однажды весною, в час небывало жаркого заката, в Москве, на Патриарших прудах, появились два", "гражданина. Первый из них, одетый в летнюю серенькую пару, был маленького роста, упитан, лыс, свою приличную шляпу", "пирожком нес в руке, а на хорошо выбритом лице его помещались сверхъестественных размеров очки в черной", "роговой оправе. Второй – плечистый, рыжеватый, вихрастый молодой человек в заломленной на затылок", "клетчатой кепке – был в ковбойке, жеваных белых брюках и в черных тапочках.Первый был не кто иной, как", "Михаил Александрович Берлиоз, председатель правления одной из крупнейших московских литературных ассоциаций,", "сокращенно именуемой МАССОЛИТ, и редактор толстого художественного журнала, а молодой спутник его – поэт", "Иван Николаевич Понырев, пишущий под псевдонимом Бездомный."]
	while true:
		for text in master_i_margarita:
			background_text_display(text, text_node_2, .1)
			var t = Timer.new()
			t.set_wait_time(3.2)
			t.set_one_shot(false)
			self.add_child(t)
			t.start()
			yield(t, "timeout")


# Интернет Библиотека Алексея Комарова. (2019). Преступление и наказание. [online]
# Available at: https://ilibrary.ru/text/69/p.1/index.html
# [Accessed 28 Oct. 2019].
func play_russian_text3():
	var text_node_3 = $BackgroundMain/BackgroundWallpaper/RightLeftGlass/RussianText3
	var prestupleniye_i_nakazaniye = ["Он благополучно избегнул встречи с своею хозяйкой на лестнице. Каморка его приходилась под самою кровлей", "высокого пятиэтажного дома и походила более на шкаф, чем на квартиру. Квартирная же хозяйка его, у которой он", "нанимал эту каморку с обедом и прислугой, помещалась одною лестницей ниже, в отдельной квартире, и каждый раз,", "при выходе на улицу, ему непременно надо было проходить мимо хозяйкиной кухни, почти всегда настежь", "отворенной на лестницу. И каждый раз молодой человек, проходя мимо, чувствовал какое-то болезненное и трусливое", "ощущение, которого стыдился и от которого морщился. Он был должен кругом хозяйке и боялся с нею встретиться."]
	while true:
		for text in prestupleniye_i_nakazaniye:
			background_text_display(text, text_node_3, .075)
			var t = Timer.new()
			t.set_wait_time(2.8)
			t.set_one_shot(false)
			self.add_child(t)
			t.start()
			yield(t, "timeout")


# Николай Гоголь - Вечера на хуторе близ Диканьки. [online] 
# Available at: https://libking.ru/books/prose-/prose-rus-classic/466592-2-nikolay-gogol-vechera-na-hutore-bliz-dikanki.html#book
# [Accessed 28 Oct. 2019].
func play_russian_text4():
	var text_node_4 = $BackgroundMain/BackgroundWallpaper/RightRightGlass/RussianText4
	var vechera_no_hutorye_bliz_dikanki = ["Как упоителен, как роскошен летний день в Малороссии! Как томительно-жарки те часы,", "когда полдень блещет в тишине и зное и голубой неизмеримый океан, сладострастным куполом нагнувшийся над", "землёю, кажется заснул, весь потонувши в неге, обнимая и сжимая прекрасную в воздушных объятиях своих! На нём ни облака.", "В поле ни речи. Всё как будто умерло; вверху только, в небесной глубине, дрожит жаворонок, и серебряные", "песни летят по воздушным ступеням на влюблённую землю, да изредка крик чайки или звонкий голос перепела", "отдаётся в степи. Лениво и бездумно, будто гуляющие без цели, стоят подоблачные дубы, и ослепительные удары", "солнечных лучей зажигают целые живописные массы листьев, накидывая на другие тёмную, как ночь, тень,", "по которой только при сильном ветре прыщет золото. Изумруды, топазы, яхонты эфирных насекомых сыплются", "над пёстрыми огородами, осеняемыми статными подсолнечниками. Серые стога сена и золотые снопы", "хлеба станом располагаются в поле и кочуют по его неизмеримости. Нагнувшиеся от тяжести плодов", "широкие ветви черешен, слив, яблонь, груш; небо, его чистое зеркало — река в зелёных, гордо", "поднятых рамах… как полно сладострастия и неги малороссийское лето!"]
	while true:
		for text in vechera_no_hutorye_bliz_dikanki:
			background_text_display(text, text_node_4, .05)
			var t = Timer.new()
			t.set_wait_time(2.6)
			t.set_one_shot(false)
			self.add_child(t)
			t.start()
			yield(t, "timeout")


# Manages both texts refresh rate
func background_text_display(text, display_node, wait_time):
	display_node.bbcode_text = String("")
	#create a timer to print text like a typewriter
	var t = Timer.new()
	t.set_wait_time(wait_time)
	t.set_one_shot(false)
	self.add_child(t)
	for letter in text:
		t.start()
		display_node.bbcode_text += String(letter)
		yield(t, "timeout")


# Checks if the minigame is won
func check_for_completion():
	# Sets a timer for the image animations
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	match Global.found_codes.size():
		1:
			# Starts a timer for the animation
			t.start()
			# Plays image-disappearing animation
			$BackgroundMain/AnimationPlayer.play('CentreUpperLeftImageOff')
			yield(t, "timeout")
			# After animation, removes image
			$BackgroundMain/BackgroundWallpaper/CentreUpperLeftImage.visible = false
		2:
			t.start()
			$BackgroundMain/AnimationPlayer.play('CentreUpperRightImageOff')
			yield(t, "timeout")
			$BackgroundMain/BackgroundWallpaper/CentreUpperRightImage.visible = false
		3:
			t.start()
			$BackgroundMain/AnimationPlayer.play('CentreLowerLeftImageOff')
			yield(t, "timeout")
			$BackgroundMain/BackgroundWallpaper/CentreLowerLeftImage.visible = false
		4:
			t.start()
			$BackgroundMain/AnimationPlayer.play('CentreLowerRightImageOff')
			yield(t, "timeout")
			$BackgroundMain/BackgroundWallpaper/CentreLowerRightImage.visible = false
			goto_outro()
		0:
			pass


# Adds a found code when a dialogue is solved
func dialogue_solved():
	Global.found_codes.append(Global.code_array[0])
	Global.code_array.remove(0)
	Global.close_dialogues()
	normalise_background()


# Transitions to Outro
func goto_outro():
	$AnimationPlayer.play("FadeOut")
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://Scenes/Outro.tscn")


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Global.can_click == true:
		get_tree().change_scene("res://Scenes/AnimationGlue.tscn")
