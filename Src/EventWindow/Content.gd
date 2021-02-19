extends Control

var id = null
var type = null

func reset():
	pass

func _ready():
	pass # Replace with function body.

func setup(event): #{"type": type, "id": key, "entry": entry}
	assert(event)
	assert(event.entry)
	
	id = event.id
	type = event.type
	var data = event.entry

	$TitleLabel.set_text(str(data.title))
	$TitleImage.texture = load("res://Assets/EventWindow/" + str(data.thumbnail))
	$DescriptionText.bbcode_text = data.desc
	
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
	pass # Replace with function body.

func _on_BaseButtonGreen_button_up():
	pass # Replace with function body.
