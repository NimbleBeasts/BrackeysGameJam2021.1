extends Control

var unitList = null


func reset():
	pass

func setup(type):
	match type:
		Types.CharEventType.Expedition:
			$BaseButtonPink.buttonText = TranslationServer.translate("MENU_BACK")
			$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_START")
			unitList = Global.DM.puh.get_units_available_array()
		Types.CharEventType.Overview:
			$BaseButtonPink.hide()
			$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_OK")
			unitList = Global.DM.puh.get_units_all_array()
		Types.CharEventType.Sacrifice:
			$BaseButtonPink.hide()
			$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_SACRIFICE")
			unitList = Global.DM.puh.get_units_available_array()
		_:
			print("CharacterWindow.gd: setup unknown type")

	for entry in unitList:
		$CheckList.addOption(entry.name, !entry.available)
		
	$CheckList.displayPage(0)
	updateButtons()


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

func _on_CheckList_list_active(node):
	$DummyLabel.set_text(str(node.optionText))

func _on_BaseButtonPink_button_up():
	print("button")
	Events.emit_signal(Events.WINDOW_CLOSE, get_parent())

func _on_BaseButtonGreen_button_up():
	pass # Replace with function body.
