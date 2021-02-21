extends Control

var id = null
var type = null

func _ready():
	$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_OK")

func reset():
	pass

func setup(event):
	print(event)
	$DescriptionText.text = event["text"]
	match event["meaning"]:
		"positive": 
			$TextureRect.color = Color("3b7d4f")
		"negative": 
			$TextureRect.color = Color("ad2f45")
		_: 
			$TextureRect.color = Color("000000")

func _on_BaseButtonPink_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("window_close", get_parent())

func _on_BaseButtonGreen_button_up():
	Events.emit_signal("window_close", get_parent())
	Events.emit_signal("play_sound", "menu_click_positive")
