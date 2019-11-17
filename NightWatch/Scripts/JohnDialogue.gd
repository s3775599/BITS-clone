extends Node

onready var background_anim = get_node('/root/Main/BackgroundArea/BackgroundSprite/AnimationPlayer')
onready var main_script = get_node('/root/Main/')

func john_dialogues(id):
	match id:
		"1":
			return [["Yes SIR what is it now SIR?" , "John, you have to fix this.", "John, what should we do?", "John, I need your help", "I'm scared, John"], ["1a", "2a", "3a", "4a"]]
		"1a":
			return [["Me? You want me to fix this?", "Yes.", "No.", "I think you're the only one who can."], ["1a1", "1a2", "1a3"]]
		"1a1":
			return [["What do you imagine I can do to fix this?", "You could use your enormous brain.", "You could find someone who can help.", "You could try talking to the computer."], ["1a1a", "1a1b", "1a1c"]]
		"1a1a":
			return [["What's in it for me?", "A big thank-you and a firm handshake.", "The League's appreciation for all your hard work over the years.", "That attitude isn't helping the team now, is it?"], ["1a1a1", "1a1a2", "1a1a3"]]
		"1a1a1":
			return [["Right. Well that will certainly make up for everything.", "[ -- end -- ]"], ["end"]]
		"1a1a2":
			return [["Oh, spare me.", "Come on John, we all appreciate you here."], ["1a1a2a"]]
		"1a1a2a":
			return [["What's my surname?", "Smith?", "McCruthers?", "John?", "Brzeczyszczykiewicz?"], ["1a1a2a1", "1a1a2a2", "1a1a2a3", "1a1a2a4"]]
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
			return [["I believe this is referred to as a 'teachable moment'.", "[ -- end -- ]"], ["end"]]
		"2a2":
			return [["Well I can relate to that.", "[ -- end -- ]"], ["end"]]
		"2a3":
			return [["He broke it, he can fix it. That's all I'm going to say about it.", "[ -- end -- ]"],["end"]]
		"3a":
			return [["What on Canopus do you think I can do about this?","I thought you might have some ideas.","I don't know.","You're an engineer, aren't you?"],["3a1","3a2","3a3"]]
		"3a1":
			return [["That's some inspirational leadership right there.","[ -- end -- ]"],["end"]]
		"3a2":
			return [["Well, neither do I.","[ -- end -- ]"],["end"]]
		"3a3":
			return [["You could say I'm an 'engineer'. You could also say that I modelled a nuclear reactor out of pinebark when I was 12, I have a first-class degree in quantum propulsion systems, and I was headhunted by the Australian National Astrophysics League before I'd even taken my final exams with promises of overseeing the biggest and most powerful engines humanity had ever devised.","..."],["3a3a"]]
		"3a3a":
			return [["Then these stupid AI computers came along and now I press buttons all day asking the computer to find answers to things I devoted my life to studying, and the only tech I'm allowed to go anywhere near is the coffee machine.","..."],["3a3a1"]]
		"3a3a1":
			return [["And we ran out of coffee three years ago.","..."],["3a3a1a"]]
		"3a3a1a":
			return [["Well . . . yeah . . . but 'Engineer'.", "I bet you could fix it.","Can you think of some way to fix this?"],["3a3a1a1","3a3a1a2"]]
		"3a3a1a1":
			return [["I bet you I'm not going to.","What if you align the phase manifold?","Did you check the combustion seals?","What about lubricating the flux probes?","What about flooding the vac inhibitors with sodium trihydroflurodoxetine?"],["3a3a1a1a","3a3a1a1b","3a3a1a1c","3a3a1a1d","3a3a1a1e"]]
		"3a3a1a1a":
			return [["We don't have enough titanium.","[ -- end -- ]"], ["end"]]
		"3a3a1a1b":
			return [["I am NOT going into the reactor chamber again.","[ -- end -- ]"], ["end"]]
		"3a3a1a1c":
			return [["We used the last of the WD40 on the squeaky chair in the comms room.","[ -- end -- ]"],["end"]]
		"3a3a1a1d":
			return [["Yes I thought about that, but we don't have enough methylaluniminestricate to counter the secondary neurotrioxin-3 inversion.","[ -- end -- ]"],["end"]]
		"3a3a1a2":
			return [["I don't think a lowly 'engineer' has any business fiddling with a G38k Kermit Quantum AI Nanoflux Supercomputer","I bet you really hate that computer"],["3a3a1a2a1"]]
		"3a3a1a2a1":
			return [[". . .", "I bet you're disappointed that the League reduced you to a button-pushing errand-boy."], ["3a3a1a2a1a"]]
		"3a3a1a2a1a":
			return [[". . . ", "I bet you feel like you really wasted your youth on all that study."], ["3a3a1a2a1a1"]]
		"3a3a1a2a1a1":
			return [[". . .", "I bet you'd really like to show this computer how you really feel."], ["3a3a1a2a1a1a"]]
		"3a3a1a2a1a1a":
			return [["AAAAARGH!!","[ -- continue -- ]"],["smash"]]
		"fix":
			Global.john_solved = true
			return [["Hey! It looks like . . . That's fixed it a bit!","[ -- end -- ]"],["solved"]]
		"4a":
			return [["Oh, Give me a break.","[ -- end -- ]"],["end"]]
			
# Barry's airlock accident lines
		"airlock1":
			return [["SIR WHAT HAPPENED? WHERE'S BARRY?", "I TOLD HIM TO PLAY AROUND WITH SOME SWITCHES!", "HE WAS PLAYING AROUND WITH SOME SWITCHES!", "I TOLD HIM NOT TO PLAY AROUND WITH ANY SWITCHES!", "I HAVE ABSOLUTELY NO IDEA!"], ["airlock1a", "airlock1b", "whatnow", "whatnow"]]
		"airlock1a":
			return [["YOU DID WHAT?? WHY DID YOU TELL HIM TO DO THAT?", "I DIDN'T HAVE ANY BETTER IDEAS!", "HE DIDN'T HAVE ANY BETTER IDEAS!"], ["whatnow", "whatnow"]]
		"airlock1b":
			return [["HE WAS WHAT?? WHY WAS HE DOING THAT?", "I TOLD HIM TO!", "I TRIED TO STOP HIM BUT I WAS TOO LATE!"], ["airlock1a", "whatnow"]]
		"whatnow":
			return [["WELL WHAT ARE WE SUPPOSED TO DO NOW?", "YOU HAVE TO CLOSE THE AIRLOCK!", "YOU HAVE TO RESCUE BARRY!"], ["airlock3", "no"]]
		"airlock3":
			return [["HOW DO YOU EXPECT ME TO DO THAT?", "YOU HAVE TO PLAY AROUND WITH THE CONSOLE!"], ["airlock4"]]
		"no":
			return [["YOU WANT ME TO WHAT?? I'M NOT GOING OUT THERE, ARE YOU CRAZY? I'M NOT EVEN WEARING AN EVA SUIT!", "YOU HAVE TO CLOSE THE AIRLOCK, THEN!"], ["airlock3"]]
		"airlock4":
			return [["AND END UP LIKE BARRY? NO WAY!", "THERE'S NO OTHER WAY!", "WHAT'S THE WORST THAT CAN HAPPEN NOW?"], ["airlock5", "airlock4b"]]
		"airlock4b":
			return [["ASK BARRY!", "THERE'S NO OTHER WAY!"], ["airlock5"]]
		"airlock5":
			return [["I REALLY HATE THIS JOB.", "[ -- continue -- ]"], ["airlock_close"]]
		"airlock7":
			return [["Looks like that's fixed it.", "Well done, John!", "My ears are ringing."], ["airlock7a", "airlock7b"]]
		"airlock7a":
			return [["Yeah. Thanks.", "[ -- end -- ]"], ["end"]]
		"airlock7b":
			Global.barry_gone = true
			return [["Right. And we've lost Barry, Sir.", "[ -- end -- ]"], ["end"]]
