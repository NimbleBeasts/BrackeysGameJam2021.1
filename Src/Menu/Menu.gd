extends Control

enum MenuState {Main, Settings, Credits}
const flags = ["en", "fr", "de"]

func _ready():
	# Event Hooks
	Events.connect_signal("menu_back", self, "_back")
	Events.connect_signal("switch_sound", self, "_switchSound")
	Events.connect_signal("switch_music", self, "_switchMusic")
	Events.connect_signal("switch_fullscreen", self, "_switchFullscreen")

	$Version.bbcode_text = "[right]"+ Global.getVersionString() + "[/right]"

	switchTo(MenuState.Main)
	
	
	TranslationServer.set_locale(Global.userConfig.language)
	$Main/ButtonLanguage/Sprite.frame = flags.find(TranslationServer.get_locale())
		

func translate():
	pass

# Play menu button sound
func playClick():
	Events.emit_signal("play_sound", "menu_click")

# Menu State Transition
func switchTo(to):
	hideAllMenuScenes()

	match to:
		MenuState.Main:
			Events.emit_signal("music_play_title_song")
			$Main.show()
		MenuState.Settings:
			updateSettings()
			$Settings.show()
		MenuState.Credits:
			$Credits.show()
		_:
			print("Invalid menu state")

# Helper function for State Transition
func hideAllMenuScenes():
	# Add menu scenes here
	$Main.hide()
	$Settings.hide()
	$Credits.hide()

# Helper function to update the config labels
func updateSettings():
	if Global.userConfig.sound:
		$Settings/ButtonSound/Text.bbcode_text = "[center]Sound: On[/center]"
	else:
		$Settings/ButtonSound/Text.bbcode_text = "[center]Sound: Off[/center]"
	
	if Global.userConfig.music:
		$Settings/ButtonMusic/Text.bbcode_text = "[center]Music: On[/center]"
	else:
		$Settings/ButtonMusic/Text.bbcode_text = "[center]Music: Off[/center]"


###############################################################################
# Callbacks
###############################################################################

# Event Hook
func _switchSound(_val):
	updateSettings()

# Event Hook
func _switchMusic(_val):
	updateSettings()

# Event Hook
func _switchFullscreen(_val):
	updateSettings()

# Event Hook
func _back():
	switchTo(MenuState.Main)


func _on_ButtonPlay_button_up():
	playClick()
	Events.emit_signal("new_game")


func _on_ButtonSettings_button_up():
	playClick()
	switchTo(MenuState.Settings)


func _on_ButtonCredits_button_up():
	playClick()
	switchTo(MenuState.Credits)


func _on_ButtonExit_button_up():
	print("Ok, Bye! Thanks for playing.")
	get_tree().quit()


func _on_ButtonBack_button_up():
	playClick()
	switchTo(MenuState.Main)


func _on_ButtonSound_button_up():
	playClick()
	Events.emit_signal("switch_sound", !Global.userConfig.sound)


func _on_ButtonMusic_button_up():
	playClick()
	Events.emit_signal("switch_music", !Global.userConfig.music)


func _on_ButtonFullscreen_button_up():
	playClick()
	Events.emit_signal("switch_fullscreen", !Global.userConfig.fullscreen)
	updateSettings()


func _on_ButtonLanguage_button_up():
	var availableLocale = TranslationServer.get_loaded_locales()
	var id = availableLocale.find(TranslationServer.get_locale()) + 1
	
	if id >= availableLocale.size():
		id = 0
	
	TranslationServer.set_locale(availableLocale[id])
	$Main/ButtonLanguage/Sprite.frame = flags.find(TranslationServer.get_locale())
	
	Global.userConfig.language = TranslationServer.get_locale()
	Global.saveConfig()
	playClick()
	print("Language: " + tr("TEST_ENTRY"))
