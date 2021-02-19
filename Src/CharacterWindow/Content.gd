extends Control


func _ready():
	
	print("char window")
	for i in range(17):
		$CheckList.addOption("Option " + str(i))
	$CheckList.displayPage(0)
	updateButtons()
	
	#warning-ignore:return_value_discarded
	$BaseButtonGreen.connect("pressed", Events, "emit_signal", [Events.EXPEDITION_STARTED])
	#warning-ignore:return_value_discarded
	$BaseButtonPink.connect("pressed", Events, "emit_signal", [Events.WINDOW_CLOSE, get_parent()])

func reset():
	pass

func setup(payload):
	print("ExpeditionWindow setup()")

func updateButtons():
	var itemsPerPage = $CheckList.optionsPerPage
	var itemsTotal = $CheckList.optionCount
	var page = $CheckList.activePage
	
	if page == 0:
		$DownButton.disabled = true
	else:
		$DownButton.disabled = false

	if page < (itemsTotal - 1)/itemsPerPage :
		$UpButton.disabled = false
	else:
		$UpButton.disabled = true
	

func _on_UpButton_button_up():
	$CheckList.displayPage($CheckList.activePage + 1)
	updateButtons()

func _on_DownButton_button_up():
	$CheckList.displayPage($CheckList.activePage - 1)
	updateButtons()

func _on_BaseButtonPink_button_up():
	print("button")
	Events.emit_signal(Events.WINDOW_CLOSE, get_parent())

func _on_CheckList_list_active(node):
	$DummyLabel.set_text(str(node.optionText))

