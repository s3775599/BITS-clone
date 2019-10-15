extends Control

var can_click = true
var john_close = false
var barry_close = false

func _process(delta):
	#pass
	if john_close or barry_close:
		$BackgroundArea/BackgroundSprite.set_modulate(Color('464646'))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('464646'))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('464646'))
		#if john_close:
		#	$CanvasLayer/JohnPopup.popup()


func _input(event):
	if Input.is_action_just_pressed("ui_right"):
		$BackgroundArea/BarryConsole/AnimationPlayer.play('BarryConsoleSlowOut')
	if Input.is_action_just_pressed("ui_left"):
		$BackgroundArea/BarryConsole/AnimationPlayer.play('BarryConsoleFastIn')
	if john_close:
#		$BackgroundArea/JohnPopup.popup()
		pass
	if barry_close:
#		$BackgroundArea/BarryPopup.popup()
		pass

	
func _on_BarryConsole_mouse_entered():
	if not barry_close:
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false

func _on_BarryConsole_mouse_exited():
	$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


func _on_JohnConsole_mouse_entered():
	if not john_close:
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color('4d39df'))
	else:
		can_click = false

func _on_JohnConsole_mouse_exited():
	$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1, 1, 1))
	can_click = true


func _on_JohnConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if barry_close:
			$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideOut')
			barry_close = false
		$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideIn')
		john_close = true
		can_click = false
		show_john_dialogue()
		

func _on_BarryConsole_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
		if john_close:
			$BackgroundArea/JohnClose/AnimationPlayer.play('BarryCloseSlideOut')
			barry_close = false
		$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
		barry_close = true
		can_click = false
		show_barry_dialogue()
		
#func _on_BarryConsole_input_event(viewport, event, shape_idx):
#	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click == true:
#		if john_close:
#			$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideOut')
#			john_close = false
#		$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideIn')
#		barry_close = true
#		$BackgroundArea/BarryPopup.popup()
#		can_click = false
#		show_barry_dialogue()


func show_john_dialogue():
	$CanvasLayer/JohnPopup.show()
	$CanvasLayer/JohnPopup.set_text(john_dialogues("1"))

func show_barry_dialogue():
	$CanvasLayer/BarryPopup.show()
	$CanvasLayer/BarryPopup.set_text(barry_dialogues("1"))


func dialogue(dialogue_lines):
	$CanvasLayer/JohnPopup.show()


func john_dialogues(id):
	match id:
		"1":
			return [["Yes SIR what is it now SIR?" , "John, you have to fix this.", "John, what should we do?", "John, I need your help", "I'm scared, John"], ["0", "1a", "2a", "3a", "4a"]]
		"1a":
			return [["Me? You want me to fix this?", "Yes.", "No.", "I think you're the only one who can."], ["0", "1a1", "1a2", "1a3"]]
		"1a1":
			return [["What do you imagine I can do to fix this?", "You could use you enormous brain.", "You could find someone who can help.", "You could try talking to the computer."], ["0", "1a1a", "1a1b", "1a1c"]]
		"1a1a":
			return [["What's in it for me?", "A big thank-you and a firm handshake.", "The League's appreciation for all your hard work over the years.", "That attitude isn't helping the team now, is it?"], ["0", "1a1a1", "1a1a2", "1a1a3"]]
		"1a1a1":
			return [["Right. Well that will certainly make up for everything.", "[ -- end -- ]"], ["0", "end"]]
		"1a1a2":
			return [["Oh, spare me.", "Come on John, we all appreciate you here."], ["0", "1a1a2a"]]
		"1a1a2a":
			return [["What's my surname?", "Smith.", "McCruthers.", "John", "Brzeczyszczykiewicz."], ["0", "1a1a2a1", "1a1a2a2", "1a1a2a3", "1a1a2a4"]]
		"1a1a2a1":
			return [["You're not even trying.", "[ -- end -- ]"],["0", "end"]]
		"1a1a2a2":
			return [["No.", "[ -- end -- ]"],["0", "end"]]
		"1a1a2a3":
			return [["No, that's my first name.", "[ -- end -- ]"],["0", "end"]]
		"1a1a2a4":
			return [["Just stop.", "[ -- end -- ]"],["0", "end"]]
		"1a1a3":
			return [["The 'Team' hasn't remembered my birthday for the past eight years.", "[ -- end -- ]"], ["0", "end"]]
		"1a1b":
			return [["Oh, of course. There's no chance I could possibly do anything. Sort it out yourselves, then.", "[ -- end --]"], ["0", "end"]]
		"1a1c":
			return [["Do you know how to say 'Computer: change the language back to English'?", "No."], ["0", "1a1c1"]]
		"1a1c1":
			return [["Do you know how to say 'English' in Russian?", "No."], ["0", "1a1c1a"]]
		"1a1c1a":
			return [["Do you know any Russian at all?", "No."], ["0", "1a1c1a1"]]
		"1a1c1a1":
			return [["Well, neither do I.", "[ -- end --]"],["0", "end"]]
		"1a2":
			return [["Then what are you bothering me for? Go and tell Barry to fix it.", "[ -- end -- ]"], ["0", "end"]]
		"1a3":
			return [["You're probably right.", "You're our only hope!", "We can't do it without you!", "The fate of the League rests on your shoulders!"], ["0", "answerno", "answerno", "answerno"]]
		"answerno":
			return [["Wow, it's so nice to be needed only when you can't ask the stupid computer for help first. The answer is no.", "[ -- end -- ]"], ["0", "end"]]
		"2a":
			return [["I think you should get Barry to fix the problem he caused.","I dont think he can.","I don't think he wants to.","I think he's caused enough damage for one day."],["0","2a1","2a2","2a3"]]
		"2a1":
			return [["I'm sure he'll work it out eventually.", "[ -- end -- ]"], ["0", "end"]]
		"2a2":
			return [["I know how he feels.", "[ -- end -- ]"], ["0","end"]]
		"2a3":
			return [["He broke it, he can fix it. That's all I'm going to say about it.", "[ -- end -- ]"],["0","end"]]
		"3a":
			return [["What on Canopus do you think I can do about this?","I thought you might have some ideas.","I don't know.","You're an engineer, aren't you?"],["0","3a1","3a2","3a3"]]
		"3a1":
			return [["That's some inspirational leadership right there.","[ -- end -- ]"],["0","end"]]
		"3a2":
			return [["Well, neither do I.","[ -- end -- ]"],["0", "end"]]
		"3a3":
			return [["You could say I'm an \"engineer\". You could also say that I modelled a nuclear reactor out of pinebark when I was 12, I have a first-class degree in quantum propulsion systems, and I was headhunted by the Australian National Astrophysics League before I'd even taken my final exams with promises of overseeing the biggest and most powerful engines humanity had ever devised.","..."],["0","3a3a"]]
		"3a3a":
			return [["Then these stupid AI computers came along and now I press buttons all day asking the computer to find answers to things I devoted my life to studying, and the only tech I'm allowed to go anywhere near is the coffee machine.","..."],["0","3a3a1"]]
		"3a3a1":
			return [["And we ran out of coffee three years ago.","..."],["0","3a3a1a"]]
		"3a3a1a":
			return [["But sure. \"Engineer\".","I bet you could fix it.","Can you think of some way to fix this?"],["0","3a3a1a1","3a3a1a2"]]
		"3a3a1a1":
			return [["I bet you I'm not going to.","What if you align the phase manifold?","What if you check the combustion seals?","What about lubricating the flux probes?","What if you restart the synaptic motivators?","What about flooding the vac inhibitors with sodium trihydroflurodoxetine to trigger a hydrolygesic feedback decouplement?"],["0","3a3a1a1a","3a3a1a1b","3a3a1a1c","3a3a1a1d","3a3a1a1e"]]
		"3a3a1a1a":
			return [["We don't have enough titanium.","[ -- end -- ]"],["0","end"]]
		"3a3a1a1b":
			return [["I am NOT going into the reactor chamber again.","[ -- end -- ]"],["0","end"]]
		"3a3a1a1c":
			return [["We used the last of the WD40 on the squeaky chair in the comms room.","[ -- end -- ]"],["0","end"]]
		"3a3a1a1d":
			return [["I don't think I could begin to explain in simple terms why that wouldn't work.","[ -- end -- ]"],["0","end"]]
		"3a3a1a1e":
			return [["Yes I thought about that, but we don;t have enough methylaluniminestricate to counter the secondary neurotrioxin-3 inversion.","[ -- end -- ]"],["0","end"]]
		"3a3a1a2":
			return [["I don't thank a lowly \"engineer\" has any busness fiddling with a G38k Kermit Quantum AI Nanoflux Supercomputer","I bet you really hate that computer"],["0","3a3a1a2a1"]]
		"3a3a1a2a1":
			return [["...","..."],["0","3a3a1a2a1a"]]
		"3a3a1a2a1a":
			return [["I bet you're disappointed that the League reduced you to a button-pushing errand-boy","..."],["0","3a3a1a2a1a1"]]
		"3a3a1a2a1a1":
			return [["...","..."],["0","3a3a1a2a1a1a"]]
		"3a3a1a2a1a1a":
			return [["I bet you feel like you really wasted your youth on all that study.","..."],["0","3a3a1a2a1a1a1"]]
		"3a3a1a2a1a1a1":
			return [["...","..."],["0","3a3a1a2a1a1a1a"]]
		"3a3a1a2a1a1a1a":
			return [["I bet you'd really like to show this computer how you really feel.","smash computer"],["0","smash"]]
		"smash":
			return [["SMASH CONSOLE... LIKE HARD.","..."],["0","fix"]]
		"fix":
			return [["Hey! It looks like . . . That's fixed it a bit!","John has fixed the computer interface by 25%"],["0","end"]]
		"4a":
			return [["Oh, Give me a break.","[ -- end -- ]"],["0","end"]]

func barry_dialogues(id):
	match id:
		"1":
			return [["Yes Sir, Lieutenant Sir?" , "I'm very disappointed in you, Barry.", "How could you do this, Barry?", "Barry, you need to fix this.", "I don't understand, Barry..."], ["0", "1a", "2a", "3a", "4a"]]
		"1a":
			return [["I don't know how this could have happened, Sir.", "That's a bit difficult to believe, Barry.", "We,, we need to find a way to fix it now.", "I imagine it had something to do with you fiddling with computer settings you have no business interfering with."], ["0", "1a1", "1a2", "1a3"]]

func _on_BarryPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		barry_close = false
		$CanvasLayer/BarryPopup.hide()
		$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/BarryConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/BarryClose/AnimationPlayer.play('BarryCloseSlideOut')
	else:
		var next_dialogue = barry_dialogues(button_id)
		print("next_dialogue = ", next_dialogue)
		$CanvasLayer/BarryPopup.set_text(next_dialogue)


func _on_JohnPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		john_close = false
		$CanvasLayer/JohnPopup.hide()
		$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/JohnConsole/JohnConsoleSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/JohnClose/AnimationPlayer.play('JohnCloseSlideOut')
	else:
		var next_dialogue = john_dialogues(button_id)
		print("next_dialogue = ", next_dialogue)
		$CanvasLayer/JohnPopup.set_text(next_dialogue)