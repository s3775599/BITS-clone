extends Node

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
			return [["Really, Sir?", "No, Barry, you colossal moron. [ -- end -- ]"], ["0", "end"]]
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
		"3a2b2a":
			return [["Okay, Sir . . here goes . . .", "[ -- continue -- ]"], ["0", "3a2b2a1"]]
		"3a2b2a1":
			# code to turn on annoying music/flashing light/eject Barry/another effect goes here
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
			return [["Oh, no . . . or the samosas!", "Get to work, Barry. [ -- end -- ]"], ["0", "end"]]
		"3a3b":
			return [["So we're stuck here?", "And getting angrier by the minute. [ -- end -- ]"], ["0", "end"]]
		"3a3c":
			return [["But they won't be able to open the outer doors without a voice confirmation.", "I'm sure they'd figure something out. [ -- end -- ]"], ["0", "end"]]
		"3a3d":
			return [["I don't want to think about it.", "Soon you won't have a choice. [ -- end -- ]"], ["0", "end"]]
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
			return [["Uh, I don't know. I guess . . . a few months instead of a few years?", "Barry, stop talking. [ -- end -- ]"], ["0", "end"]]
		"4a2b":
			return [["Yes, Sir. I realised that after about three seconds.", "Barry, stop talking. [ -- end -- ]"], ["0", "end"]]
		"4a3":
			return [["I was a bit embarrassed and hoped maybe it wouldn't be that noticeable. . .", "You thought we wouldn't notice that the computer was IN ANOTHER LANGUAGE?"], ["0", "4a3a"]]
		"4a3a":
			return [["It kind of looks a bit like English. . .", "Barry."], ["0", "4a3a1"]]
		"4a3a1":
			return [["A little bit. . .", "Barry."], ["0", "4a3a1a"]]
		"4a3a1a":
			return [["A couple of the letters look the same. . .", "Barry, stop talking. [ -- end -- ]"], ["0", "end"]]