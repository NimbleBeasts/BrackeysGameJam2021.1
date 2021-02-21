extends Control

onready var GameInstance = get_parent()

func _ready():
	Events.connect("move_update_gfx", self, "updateBiome")


func _unhandled_key_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		Events.emit_signal("menu_back")

func updateBiome(curId, nextId):
	$Map/Next.frame = nextId
	$Map/Current.frame = curId
	$Scenery.frame = curId


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
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("window_show", Types.WindowType.Move, null)


func _on_TurnButton_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal(Events.TURN_ENDED)
	

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
	var data = {
		"eventType": Types.EventTypes.Gameplay,
		"payload": {
			"success": true,
			"changes": {
				"water": 5,
				"faith": -1,
				"food": -2
			},
			"casualties": [] #array of uids
		},
		"id": Data.getEventIdByName(Types.EventTypes.Gameplay, "on_expedition_end")
	}
	Events.emit_signal("window_show", Types.WindowType.Event, data)


func _on_UnitButton_button_up():
	Events.emit_signal("play_sound", "menu_click")
	Events.emit_signal("window_show", Types.WindowType.Char, Types.CharEventType.Overview)


func _on_spawnfeeback_button_up():
	Events.emit_signal("window_show", Types.WindowType.ResFb, {"text":"blablabla"})

