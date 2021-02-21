extends Control

var ug : UnitGetter = Types.unit_getter

var unitList = null

enum ButtonActionTypes {BackToExpedition, StartExpedition, Sacrifice, Close}

var greenButtonAction = ButtonActionTypes.Close
var pinkButtonAction = ButtonActionTypes.Close

func reset():
	pass

func setup(type):
	match type:
		Types.CharEventType.Expedition:
			$BaseButtonPink.buttonText = TranslationServer.translate("MENU_BACK")
			$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_START")
			pinkButtonAction = ButtonActionTypes.BackToExpedition
			greenButtonAction = ButtonActionTypes.StartExpedition
			unitList = Global.DM.puh.get_units_available_array()
			$Title.set_text(TranslationServer.translate("CHAR_TITLE_EXPEDITION"))
		Types.CharEventType.Overview:
			$BaseButtonPink.hide()
			$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_OK")
			greenButtonAction = ButtonActionTypes.Close
			unitList = Global.DM.puh.get_units_all_array()
			$Title.set_text(TranslationServer.translate("CHAR_TITLE_OVERVIEW"))
		Types.CharEventType.Sacrifice:
			$BaseButtonPink.hide()
			$BaseButtonGreen.buttonText = TranslationServer.translate("MENU_SACRIFICE")
			greenButtonAction = ButtonActionTypes.Sacrifice
			unitList = Global.DM.puh.get_units_available_array()
			$Title.set_text(TranslationServer.translate("CHAR_TITLE_SACRIFICE"))
		_:
			print("CharacterWindow.gd: setup unknown type")

	for i in range(unitList.size()):
		$CheckList.addOption(unitList[i].name, unitList[i].uid, !unitList[i].available)
		
	$CheckList.displayPage(0)
	updateButtons()
	_on_CheckList_list_active($CheckList.get_child(0))

func buttonAction(action):
	var list = $CheckList.getChecked()
	
	match action:
		# Back to Route Selection
		ButtonActionTypes.BackToExpedition:
			Events.emit_signal(Events.WINDOW_SHOW, Types.WindowType.Expedition)
			Events.emit_signal(Events.WINDOW_CLOSE, get_parent())
			Events.emit_signal("play_sound", "menu_click")

		# Expedition Start
		ButtonActionTypes.StartExpedition:
			if list.size() == 0:
				Events.emit_signal("play_sound", "menu_click_negative")
			else:
				Events.emit_signal("play_sound", "menu_click_positive")
			#TODO: use list data and start expedition

		# Sacrifice
		ButtonActionTypes.Sacrifice:
			if list.size() == 0:
				Events.emit_signal("play_sound", "menu_click_negative")
			else:
				Events.emit_signal(Events.WINDOW_CLOSE, get_parent())
				Events.emit_signal("play_sound", "menu_click")
				#ug.kill_units(ug.get_units_by_ids(unitList))
		_:
			Events.emit_signal(Events.WINDOW_CLOSE, get_parent())
			Events.emit_signal("play_sound", "menu_click")
			

func updateButtons():
	var itemsPerPage = $CheckList.optionsPerPage
	var itemsTotal = $CheckList.optionCount
	var page = $CheckList.activePage
	
	if page == 0:
		$UpButton.disabled = true
	else:
		$UpButton.disabled = false

	if page < (itemsTotal - 1)/itemsPerPage :
		$DownButton.disabled = false
	else:
		$DownButton.disabled = true


func _on_UpButton_button_up():
	$CheckList.displayPage($CheckList.activePage - 1)
	updateButtons()

func _on_DownButton_button_up():
	$CheckList.displayPage($CheckList.activePage + 1)
	updateButtons()

func _on_CheckList_list_active(node):
	var id = findEntry(node.optionText)
	assert(id != -1)
	
	$Chars.frame = unitList[id].type
	$Description.text = TranslationServer.translate(Data.units[unitList[id].type].description)

	$DummyLabel.set_text(str(node.optionText))


func findEntry(charName):
	for i in range(unitList.size()):
		if unitList[i].name == charName:
			return i
	return -1



func _on_BaseButtonPink_button_up():
	buttonAction(pinkButtonAction)
	

func _on_BaseButtonGreen_button_up():
	buttonAction(greenButtonAction)

