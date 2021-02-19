extends Control


func _ready():
	#warning-ignore:return_value_discarded
	$BaseButtonGreen.connect("pressed", Events, "emit_signal", [Events.EXPEDITION_STARTED])
	#warning-ignore:return_value_discarded
	$BaseButtonPink.connect("pressed", Events, "emit_signal", [Events.WINDOW_CLOSE, get_parent()])

func reset():
	pass

func setup(payload):
	print("ExpeditionWindow setup()")




func _on_BaseButtonPink_button_up():
	print("button")
	Events.emit_signal(Events.WINDOW_CLOSE, get_parent())

func _on_CheckList_list_active(node):
	$DummyLabel.set_text(str(node.optionText))

