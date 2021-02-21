extends Control

var id = null
var type = null

func _ready():
	$TitleLabel.set_text(TranslationServer.translate("MOVE_TITLE"))
	$BaseButtonPink.buttonText = TranslationServer.translate("MENU_BACK")
	$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_OK")

func reset():
	pass

func setup(event):
	pass

func _on_BaseButtonPink_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("window_close", get_parent())

func _on_BaseButtonGreen_button_up():
	if Types.resources_getter.get_food() >= 80 and Types.resources_getter.get_water() >= 120:
		# Use
		Types.resources_getter.use_water(120)
		Types.resources_getter.use_food(80)
		Events.emit_signal("move_next")
		Events.emit_signal(Events.LEFT_LOCATION)
		Events.emit_signal(Events.TURN_ENDED)
		Events.emit_signal("window_close", get_parent())
		Events.emit_signal("play_sound", "menu_click_positive")
	else:
		Events.emit_signal("play_sound", "menu_click_negative")
	
