extends Control

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

	for entry in unitList:
		$CheckList.addOption(entry.name, !entry.available)
		
	$CheckList.displayPage(0)
	updateButtons()
	_on_CheckList_list_active($CheckList.get_child(0))


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
	var id = findEntry(node.optionText)
	assert(id != -1)
	
	#IMPORTANT get UnitTypes id from DM units
	#var type = Types.UnitTypes.keys().find(unitList[id].type.capitalize())
	
	$Chars.frame = unitList[id].type

	$DummyLabel.set_text(str(node.optionText))


func findEntry(charName):
	for i in range(unitList.size()):
		if unitList[i].name == charName:
			return i
	return -1

func buttonAction(action):
	match action:
		ButtonActionTypes.BackToExpedition:
			Events.emit_signal(Events.WINDOW_SHOW, Types.WindowType.Expedition)
			Events.emit_signal(Events.WINDOW_CLOSE, get_parent())
			Events.emit_signal("play_sound", "menu_click")
		ButtonActionTypes.StartExpedition:
			Events.emit_signal("play_sound", "menu_click_positive")
		ButtonActionTypes.Sacrifice:
			Events.emit_signal("play_sound", "menu_click_negative")
		_:
			Events.emit_signal(Events.WINDOW_CLOSE, get_parent())
			Events.emit_signal("play_sound", "menu_click")
			

func _on_BaseButtonPink_button_up():
	buttonAction(pinkButtonAction)
	

func _on_BaseButtonGreen_button_up():
	buttonAction(greenButtonAction)

