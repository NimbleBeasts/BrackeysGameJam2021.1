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
	
	var distance = Global.DM.get_node("EnemyArmy").counter
	var distance2 = Global.DM.get_node("EnemyArmy").counter+1
	
	$TitleLabel.set_text(TranslationServer.translate(data.title))
	$TitleImage.texture = load("res://Assets/EventWindow/" + str(data.thumbnail))
	$DescriptionText.bbcode_text = TranslationServer.translate(data.desc) + "\n"
	
	$DescriptionText.bbcode_text = $DescriptionText.bbcode_text.replace("$previous_enemy_distance", str(distance2))
	$DescriptionText.bbcode_text = $DescriptionText.bbcode_text.replace("$enemy_distance", str(distance))
	
	if data.action.type == "yesno":
		# YesNo Choice
		$BaseButtonPink.show()
		$BaseButtonPink.buttonText = tr(data.action["no"].text)
		$BaseButtonGreen.buttonText = tr(data.action["yes"].text)
	elif data.action.type == "yes":
		# Ok Button Only
		$BaseButtonPink.hide()
		var oktext = "NEXT"
		if typeof(data.action["yes"]) != TYPE_STRING or data.action["yes"] != "scripted":
			data.action["yes"].text
		$BaseButtonGreen.buttonText = tr(oktext)

func _on_BaseButtonPink_button_up():
	if type != Types.EventTypes.Gameplay:
		Events.emit_signal("event_choice", "no")
	Events.emit_signal("window_close", get_parent())

func _on_BaseButtonGreen_button_up():
	if type != Types.EventTypes.Gameplay:
		Events.emit_signal("event_choice", "yes")
	Events.emit_signal("window_close", get_parent())
	
