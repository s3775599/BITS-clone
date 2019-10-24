extends Node

"""
The following function is code adapted from:

	Godotengine.org. (2017). 
	Writing to screen one letter at a time like a typewriter? - Godot Engine - Q&A. [online] 
	Available at: https://godotengine.org/qa/17327/writing-to-screen-one-letter-at-a-time-like-a-typewriter 
	[Accessed 19 Oct. 2019].

"""
func typewriter_text(display_text):
	# Create a timer to print text like a typewriter
	var t = Timer.new()
	t.set_wait_time(.005)
	t.set_one_shot(true)
	self.add_child(t)
	# Prints each individual letter according to Timer length
	for letter in text:
			t.start()
			print(letter)
			display_text.bbcode_text += String(letter)
			yield(t, "timeout")
""" 
"""