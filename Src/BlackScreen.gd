extends ColorRect



func _ready():
	hide()
	Events.connect("window_black_screen_show", self, "show")
	Events.connect("window_black_screen_hide", self, "hide")
