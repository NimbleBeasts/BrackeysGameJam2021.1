extends ColorRect



func _ready():
	hide()
	Events.connect("window_black_screen_show", self, "showMe")
	Events.connect("window_black_screen_hide", self, "hide")

func showMe():
	print("show")
	show()
