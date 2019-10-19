extends Node

func john_dialogues(id):
	match id:
		"1":
			return [["Yes SIR what is it now SIR?" , "John, you have to fix this.", "John, what should we do?", "John, I need your help", "I'm scared, John"], ["1a", "2a", "3a", "4a"]]
		"1a":
			return [["Me? You want me to fix this?", "Yes.", "No.", "I think you're the only one who can."], ["1a1", "1a2", "1a3"]]
		"1a1":
			return [["What do you imagine I can do to fix this?", "You could use you enormous brain.", "You could find someone who can help.", "You could try talking to the computer."], ["1a1a", "1a1b", "1a1c"]]
		"1a1a":
			return [["What's in it for me?", "A big thank-you and a firm handshake.", "The League's appreciation for all your hard work over the years.", "That attitude isn't helping the team now, is it?"], ["1a1a1", "1a1a2", "1a1a3"]]
		"1a1a1":
			return [["Right. Well that will certainly make up for everything.", "[ -- end -- ]"], ["end"]]
		"1a1a2":
			return [["Oh, spare me.", "Come on John, we all appreciate you here."], ["1a1a2a"]]
		"1a1a2a":
			return [["What's my surname?", "Smith.", "McCruthers.", "John", "Brzeczyszczykiewicz."], ["1a1a2a1", "1a1a2a2", "1a1a2a3", "1a1a2a4"]]
		"1a1a2a1":
			return [["You're not even trying.", "[ -- end -- ]"],["end"]]
		"1a1a2a2":
			return [["No.", "[ -- end -- ]"],["end"]]
		"1a1a2a3":
			return [["No, that's my first name.", "[ -- end -- ]"],["end"]]
		"1a1a2a4":
			return [["Just stop.", "[ -- end -- ]"],["end"]]
		"1a1a3":
			return [["The 'Team' hasn't remembered my birthday for the past eight years.", "[ -- end -- ]"], ["end"]]
		"1a1b":
			return [["Oh, of course. There's no chance I could possibly do anything. Sort it out yourselves, then.", "[ -- end --]"], ["end"]]
		"1a1c":
			return [["Do you know how to say 'Computer: change the language back to English'?", "No."], ["1a1c1"]]
		"1a1c1":
			return [["Do you know how to say 'English' in Russian?", "No."], ["1a1c1a"]]
		"1a1c1a":
			return [["Do you know any Russian at all?", "No."], ["1a1c1a1"]]
		"1a1c1a1":
			return [["Well, neither do I.", "[ -- end --]"],["end"]]
		"1a2":
			return [["Then what are you bothering me for? Go and tell Barry to fix it.", "[ -- end -- ]"], ["end"]]
		"1a3":
			return [["You're probably right.", "You're our only hope!", "We can't do it without you!", "The fate of the League rests on your shoulders!"], ["answerno", "answerno", "answerno"]]
		"answerno":
			return [["Wow, it's so nice to be needed only when you can't ask the stupid computer for help first. The answer is no.", "[ -- end -- ]"], ["end"]]
		"2a":
			return [["I think you should get Barry to fix the problem he caused.","I dont think he can.","I don't think he wants to.","I think he's caused enough damage for one day."],["2a1","2a2","2a3"]]
		"2a1":
			return [["I'm sure he'll work it out eventually.", "[ -- end -- ]"], ["end"]]
		"2a2":
			return [["I know how he feels.", "[ -- end -- ]"], ["end"]]
		"2a3":
			return [["He broke it, he can fix it. That's all I'm going to say about it.", "[ -- end -- ]"],["end"]]
		"3a":
			return [["What on Canopus do you think I can do about this?","I thought you might have some ideas.","I don't know.","You're an engineer, aren't you?"],["3a1","3a2","3a3"]]
		"3a1":
			return [["That's some inspirational leadership right there.","[ -- end -- ]"],["end"]]
		"3a2":
			return [["Well, neither do I.","[ -- end -- ]"],["end"]]
		"3a3":
			return [["You could say I'm an \"engineer\". You could also say that I modelled a nuclear reactor out of pinebark when I was 12, I have a first-class degree in quantum propulsion systems, and I was headhunted by the Australian National Astrophysics League before I'd even taken my final exams with promises of overseeing the biggest and most powerful engines humanity had ever devised.","..."],["3a3a"]]
		"3a3a":
			return [["Then these stupid AI computers came along and now I press buttons all day asking the computer to find answers to things I devoted my life to studying, and the only tech I'm allowed to go anywhere near is the coffee machine.","..."],["3a3a1"]]
		"3a3a1":
			return [["And we ran out of coffee three years ago.","..."],["3a3a1a"]]
		"3a3a1a":
			return [["But sure. \"Engineer\".","I bet you could fix it.","Can you think of some way to fix this?"],["3a3a1a1","3a3a1a2"]]
		"3a3a1a1":
			return [["I bet you I'm not going to.","What if you align the phase manifold?","What if you check the combustion seals?","What about lubricating the flux probes?","What if you restart the synaptic motivators?","What about flooding the vac inhibitors with sodium trihydroflurodoxetine to trigger a hydrolygesic feedback decouplement?"],["3a3a1a1a","3a3a1a1b","3a3a1a1c","3a3a1a1d","3a3a1a1e"]]
		"3a3a1a1a":
			return [["We don't have enough titanium.","[ -- end -- ]"],["end"]]
		"3a3a1a1b":
			return [["I am NOT going into the reactor chamber again.","[ -- end -- ]"],["end"]]
		"3a3a1a1c":
			return [["We used the last of the WD40 on the squeaky chair in the comms room.","[ -- end -- ]"],["end"]]
		"3a3a1a1d":
			return [["I don't think I could begin to explain in simple terms why that wouldn't work.","[ -- end -- ]"],["end"]]
		"3a3a1a1e":
			return [["Yes I thought about that, but we don't have enough methylaluniminestricate to counter the secondary neurotrioxin-3 inversion.","[ -- end -- ]"],["end"]]
		"3a3a1a2":
			return [["I don't thank a lowly \"engineer\" has any busness fiddling with a G38k Kermit Quantum AI Nanoflux Supercomputer","I bet you really hate that computer"],["3a3a1a2a1"]]
		"3a3a1a2a1":
			return [[". . .", "I bet you're disappointed that the League reduced you to a button-pushing errand-boy"], ["3a3a1a2a1a"]]
		"3a3a1a2a1a":
			return [[". . . ", "I bet you feel like you really wasted your youth on all that study."], ["3a3a1a2a1a1"]]
		"3a3a1a2a1a1":
			return [[". . .", "I bet you'd really like to show this computer how you really feel."], ["smash"]]
		"smash":
			return [["SMASH CONSOLE... LIKE HARD!","[ -- continue -- ]"],["fix"]]
		"fix":
			return [["Hey! It looks like . . . That's fixed it a bit!","[ -- John has fixed the computer interface by 25% -- ]"],["end"]]
		"4a":
			return [["Oh, Give me a break.","[ -- end -- ]"],["end"]]