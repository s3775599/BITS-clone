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
			return [["Yes I thought about that, but we don't have enough methylaluniminestricate to counter the secondary neurotrioxin-3 inversion.","[ -- end -- ]"],["0","end"]]
		"3a3a1a2":
			return [["I don't thank a lowly \"engineer\" has any busness fiddling with a G38k Kermit Quantum AI Nanoflux Supercomputer","I bet you really hate that computer"],["0","3a3a1a2a1"]]
		"3a3a1a2a1":
			return [[". . .", "I bet you're disappointed that the League reduced you to a button-pushing errand-boy"], ["0","3a3a1a2a1a"]]
		"3a3a1a2a1a":
			return [[". . . ", "I bet you feel like you really wasted your youth on all that study."], ["0","3a3a1a2a1a1"]]
		"3a3a1a2a1a1":
			return [[". . .", "I bet you'd really like to show this computer how you really feel."], ["0","smash"]]
		"smash":
			return [["SMASH CONSOLE... LIKE HARD!","[ -- continue -- ]"],["0","fix"]]
		"fix":
			return [["Hey! It looks like . . . That's fixed it a bit!","[ -- John has fixed the computer interface by 25% -- ]"],["0","end"]]
		"4a":
			return [["Oh, Give me a break.","[ -- end -- ]"],["0","end"]]

func barry_dialogues(id):
	match id:
		"1":
			return [["Yes Sir, Lieutenant Sir?" , "I'm very disappointed in you, Barry.", "How could you do this, Barry?", "Barry, you need to fix this.", "I don't understand, Barry..."], ["0", "1a", "2a", "3a", "4a"]]
		"1a":
			return [["I don't know how this could have happened, Sir.", "That's a bit difficult to believe, Barry.", "Well, we need to find a way to fix it now.", "I imagine it had something to do with you fiddling with computer settings you have no business interfering with."], ["0", "1a1", "1a2", "1a3"]]
		"1a1":
			return [["Uh, I suppose so.", "[ -- end --]"], ["0", "end"]]
		"1a2":
			return [["Yes, Sir. I'm working on it right now, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"1a3":
			return [["Uh, true", "[ -- end --]"], ["0", "end"]]
		"2a":
			return [["I didn't mean to do it, Sir.", "You didn't mean to make the computer virtually impossible to use, this jeopardising the crew, the mission and the ship?"], ["0", "2a1"]]
		"2a1":
			return [["Uh, that's correct Sir.", "Well that's great. As long as you're sorry.", "I'm pleased to hear it. I was about to put you on report, but since you're so sincerely sorry, I'll let you off."], ["0", "2a1a", "2a1b"]]
		"2a1a":
			return [["I am, Sir. Very sorry, Sir.", "[ -- continue -- ]"], ["0", "2a1a1"]]
		"2a1a1":
			return [[". . . I'll still need to fix this though, won't I Sir?", "Yes, Barry. You need to fix the computer so that we don't all die from your idiocy. That would be very good of you, thanks."], ["0", "understood"]]
		"understood":
			return [["Understood, Sir. Sorry, sir.", "[ -- end -- ]"], ["0", "end"]]
		"2a1b":
			return [["Really, Sir?", "No, Barry, you colossal moron."], ["0", "understood"]]
		"3a":
			return [["I know Sir. I'm working on it.", "Let me know how you get on.", "What are you doing to fix it?", "Do you know what's going to happen if you don't sort this out?"], ["0", "3a1", "3a2", "3a3"]]
		"3a1":
			return [["Yes, Sir. I will, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"3a2":
			return [["I'm going to try something . . .", "What's that?", "Wait, I have an idea.", "Whatever it is, Barry, you'd better have a good plan."], ["0", "3a2a", "3a2b", "3a2c"]]
		"3a2a":
			return [["I'm going to try pressing a button.", "[ -- continue -- ]"], ["0", "3a2a1"]]
		"3a2a1":
			return [[". . . nope. Nothing.", "[ -- end -- ]"], ["0", "end"]] 
		"3a2b":
			return [["What's that, Sir?", "What kind of training did you get when you were qualifying to be a pilot?", "Try pushing random buttons.", "I think you should not touch anything and let me and John try to fix this."], ["0", "3a2b1", "3a2b2", "3a2b3"]]
		"3a2b1":
			return [["Aerodynamics, vector calculus, spatial geometry, mechanical engineering, first aid, how to drink seven shots of run and vomit it out your nose into a pint glass, navigation . . . ", "Navigation! Wait, seven shots and what? No, never mind actually . . ."], ["0", "3a2b1a"]]
		"3a2b1a":
			return [[". . . what about navigation, Sir?", "You must have learned about observing your surroundings, noticing minor details and shanges of scenery?"], ["0", "3a2b1a1"]]
		"3a2b1a1":
			return [["Uh, yes Sir, I suppose so.", "If you replay the scene in your head, can you visualise the console again? All the keys and screens you saw to change the language the first time?"], ["0", "3a2b1a1a"]]
		"3a2b1a1a":
			return [[". . . Actually Sir, I think I just about can.", "[ -- continue -- ]"], ["0", "3a2b1a1a1"]]
		"3a2b1a1a1":
			return [[". . . yes . . yes . . . yes! YES! I've got it!", "You've fixed it?"], ["0", "3a2b1a1a1a"]]
		"3a2b1a1a1a":
			return [["Um . . . not completely, Sir. But it looks a bit better. I'll keep working on it.", "[ -- Barry has fixed the console by 25% -- ]"], ["0", "end"]]
		"3a2b2":
			return [["Are you sure, Sir?", "Yes.", "No."], ["0", "3a2b2a", "3a2b2b"]]
		"3a2b2a1":
			return [["Okay, Sir . . here goes . . .", "[ -- continue -- ]"], ["0", "3a2b2a1a"]]
		"3a2b2a1a":
			return [["Well, so much for that.", "[ -- end --] ** NOTE TO QA possibility here for humourous effect eg. Barry is ejected, or music start playing and can't be turned off etc."], ["0", "end"]]
		"3a2b2b":
			return [["Okay Sir. Let me know when you want me to do something, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"3a2b3":
			return [["Yes, Sir, if you say so, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"3a2c":
			return [[". . . ", "Barry?"], ["0", "3a2c1"]]
		"3a2c1":
			return [[". . .", "Barry."], ["0", "3a2c1a"]]
		"3a2c1a":
			return [[". . .", "You were going to start pushing random buttons, weren't you Barry?"], ["0", "3a2c1a1"]]
		"3a2c1a1":
			return [["Kind of yes, Sir. Sorry Sir.", "[ -- end -- ]"], ["0", "end"]]
		"3a3":
			return [["I can imagine, Sir.", "Can you imagine not being able to order those spicy kebabs from the food dispenser?", "Can you imagine not being able to activate the turbolift to get back to your quarters?", "Can you imagine the crew collectively stuffing you into the airlock?", "Can you imagine what the rest of the crew is going to do to us if they find out?"], ["0", "3a3a", "3a3b", "3a3c", "3a3d"]]
		"3a3a":
			return [["Oh, no . . . or the samosas!", "Get to work, Barry"], ["0", "understood"]]
		"3a3b":
			return [["So we're stuck here?", "And getting angrier by the minute."], ["0", "understood"]]
		"3a3c":
			return [["But they won't be able to open the outer doors without a voice confirmation.", "I'm sure they'd figure something out."], ["0", "understood"]]
		"3a3d":
			return [["I don't want to think about it.", "Soon you won't have a choice."], ["0", "understood"]]
		"4a":
			return [["Don't understand what, Sir?", "How could you change the language settings like that? Didn't it need an admin password?", "Why did you think you could learn a new language so quickly?", "Why didn't you tell us as soon as it happened?"], ["0", "4a1", "4a2", "4a3"]]
		"4a1":
			return [["Yes Sir, it did Sir.", "Do you have some higher authorisation that I don't know about?", "How did you know what the captain's password was?"], ["0", "4a1a", "4a1b"]]
		"4a1a":
			return [["No Sir, it was just luck.", "'password'?", "'qwerty'?", "'12345678'?", "'ford'?"], ["0", "4a1a1", "4a1a2", "4a1a3", "4a1a4"]]
		"4a1a1":
			return [["Not exactly, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"4a1a2":
			return [["Not quite, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"4a1a3":
			return [["That's not it, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"4a1a4":
			return [["No, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"4a1b":
			return [["Someone from the last shift left a sticky note with the password on my console.", "I guess that means another Watch is first up for cleaning the heads next Saturday, at least."], ["0", "4a1b1"]]
		"4a1b1":
			return [["That's true, Sir.", "[ -- end -- ]"], ["0", "end"]]
		"4a2":
			return [["I heard that when you go to a new country you learn the language really quickly.", "How quickly?", "Changing the computer interface isn't anything like going to a new country."], ["0", "4a2a", "4a2b"]]
		"4a2a":
			return [["Uh, I don't know. I guess . . . a few months instead of a few years?", "Barry, stop talking."], ["0", "understood"]]
		"4a2b":
			return [["Yes, Sir. I realised that after about three seconds.", "Barry, stop talking."], ["0", "understood"]]
		"4a3":
			return [["I was a bit embarrassed and hoped maybe it wouldn't be that noticeable. . .", "You thought we wouldn't notice that the computer was IN ANOTHER LANGUAGE?"], ["0", "4a3a"]]
		"4a3a":
			return [["It kind of looks a bit like English. . .", "Barry."], ["0", "4a3a1"]]
		"4a3a1":
			return [["A little bit. . .", "Barry."], ["0", "4a3a1a"]]
		"4a3a1a":
			return [["A couple of the letters look the same. . .", "Barry, stop talking."], ["0", "understood"]]


func _on_BarryPopup_button_id(button_id):
	print("button_id = ", button_id)
	if button_id == "end":
		barry_close = false
		$CanvasLayer/BarryPopup.hide()
		$BackgroundArea/BackgroundSprite.set_modulate(Color(1,1,1))
		$BackgroundArea/BarryConsole/BarryConsoleSprite.set_modulate(Color(1,1,1))
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