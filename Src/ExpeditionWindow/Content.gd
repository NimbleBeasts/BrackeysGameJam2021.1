extends Control


func _ready():
	for i in range(17):
		$CheckList.addOption("Option " + str(i))
	$CheckList.displayPage(0)
	updateButtons()
	
	
	

func reset():
	pass


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
	Events.emit_signal(Events.WINDOW_CLOSE, Types.WindowType.Expedition)

func _on_CheckList_list_active(node):
	$DummyLabel.set_text(str(node.optionText))

