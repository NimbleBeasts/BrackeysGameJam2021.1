extends Control

var id = null
var type = null

func reset():
	pass


func setup(event): #{"type": type, "id": key, "entry": entry}
	assert(event)
	assert(event.entry)
	
	id = event.id
	type = event.type
	var data = event.entry

	$TitleLabel.set_text(str(data.title))
	$TitleImage.texture = load("res://Assets/EventWindow/" + str(data.thumbnail))
	$DescriptionText.bbcode_text = data.desc + "\nData: " + str(event)
	
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
	# Do stuff
	Events.emit_signal("window_close", get_parent())

func _on_BaseButtonGreen_button_up():
	# Do stuff
	Events.emit_signal("window_close", get_parent())
	
