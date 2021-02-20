extends Control

onready var GameInstance = get_parent()

func _ready():
	$Label.set_text("Turn: " + str(GameInstance.gameState.turn))


func _unhandled_key_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		Events.emit_signal("menu_back")


func updateResourceGui(resourceType, val): #Types.ResourceType
	match resourceType:
		Types.ResourceType.Water:
			$TopBar/Water/Label.set_text(str(val))
		Types.ResourceType.Food:
			$TopBar/Food/Label.set_text(str(val))
		Types.ResourceType.Faith:
			$TopBar/Faith/Label.set_text(str(val))
		_:
			print("GameInstance.gd: Invalid Resource Type")

func endTurn():
	get_parent().gameState.turn += 1
	$Label.set_text("Turn: " + str(GameInstance.gameState.turn))


###############################################################################
# Callbacks
###############################################################################

func _on_ButtonBack_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("menu_back")


func _on_ButtonMusic_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("switch_music", !Global.userConfig.music)


func _on_ButtonSound_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("switch_sound", !Global.userConfig.sound)


func _on_ExpButton_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal(Events.WINDOW_SHOW, Types.WindowType.Expedition)


func _on_MoveButton_button_up():
	pass # Replace with function body.


func _on_TurnButton_button_up():
	endTurn()


func _on_EventSpawnButton_button_up():
	#TODO: remove
	Events.emit_signal("window_show", Types.WindowType.Event, {"eventType": Types.EventTypes.TurnRandom, "id": randi()%2 })
	Events.emit_signal("window_show", Types.WindowType.Event, {"eventType": Types.EventTypes.TurnRandom, "id": randi()%2 })
	Events.emit_signal("window_show", Types.WindowType.Event, {"eventType": Types.EventTypes.TurnRandom, "id": Data.getEventIdByName(Types.EventTypes.TurnRandom, "swordbread")})
	


func _on_SacrificeButton_button_up():
	Events.emit_signal("window_show", Types.WindowType.Char, Types.CharEventType.Expedition)


func _on_SacrificeButton2_button_up():
	Events.emit_signal("window_show", Types.WindowType.Event, {"eventType": Types.EventTypes.TurnRandom, "id": Data.getEventIdByName(Types.EventTypes.TurnRandom, "sacrifice")})


func _on_UnitsInBase_button_up():
	Events.emit_signal("window_show", Types.WindowType.Char, Types.CharEventType.Overview)


func _on_UnitButton_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("window_show", Types.WindowType.Char, Types.CharEventType.Overview)
