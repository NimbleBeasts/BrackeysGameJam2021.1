extends Control

var id = null
var type = null

func reset():
	pass

#TODO: hide buttons if window is not active. emit signal on basewindow maybe

func setup(event): #{"type": type, "id": key, "entry": entry}
	assert(event)
	assert(event.entry)
	id = event.id
	type = event.type
	var data = event.entry
	
	print(TranslationServer.get_loaded_locales())
	print(tr("UNIT_PRIEST_DESC"))
	print(tr("EVENT_EXPEDITIONEND_TITLE"))
	print(tr(str(data.title)))

	$TitleLabel.set_text(TranslationServer.translate(data.title))
	$TitleImage.texture = load("res://Assets/EventWindow/" + str(data.thumbnail))
	$DescriptionText.bbcode_text = TranslationServer.translate(data.desc) + "\nData: " + str(event)
	
	if data.action.type == "yesno":
		# YesNo Choice
		$BaseButtonPink.show()
		$BaseButtonPink.buttonText = "No"
		$BaseButtonGreen.buttonText = "Yes"
	else:
		# Ok Button Only
		$BaseButtonPink.hide()
		$BaseButtonGreen.buttonText = "Ok"

func _on_BaseButtonPink_button_up():
	Events.emit_signal("event_choice", type, id, "no")
	Events.emit_signal("window_close", get_parent())

func _on_BaseButtonGreen_button_up():
	Events.emit_signal("event_choice", type, id, "yes")
	Events.emit_signal("window_close", get_parent())
	
