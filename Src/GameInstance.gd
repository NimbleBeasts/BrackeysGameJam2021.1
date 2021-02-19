extends Control

# This will be used for save/load game
var gameState = {
	resources = { water = 20, food = 41, faith = 80 },
	turn = 0
	
}


###############################################################################
# Functions
###############################################################################

func _ready():
	initDebug()
	$Label.set_text("Turn: " + str(gameState.turn))

func initDebug():
	var cat = Debug.addCategory("Resources")
	Debug.addOption(cat, "Add Water", funcref(self, "debugAddResource"), Types.ResourceType.Water)
	Debug.addOption(cat, "Add Food", funcref(self, "debugAddResource"), Types.ResourceType.Food)
	Debug.addOption(cat, "Add Faith", funcref(self, "debugAddResource"), Types.ResourceType.Faith)
	Debug.addOption(cat, "Clear All", funcref(self, "debugClearResource"), null)

func debugAddResource(type): #Types.ResourceType
	match type:
		Types.ResourceType.Water:
			gameState.resources.water += 100
			updateResourceGui(type, gameState.resources.water)
		Types.ResourceType.Food:
			gameState.resources.food += 100
			updateResourceGui(type, gameState.resources.food)
		_:
			gameState.resources.faith += 100
			updateResourceGui(type, gameState.resources.faith)
	
func debugClearResource(_d):
	gameState.resources.water = 0
	gameState.resources.food = 0
	gameState.resources.faith = 0
	updateResourceGui(Types.ResourceType.Water, 0)
	updateResourceGui(Types.ResourceType.Food, 0)
	updateResourceGui(Types.ResourceType.Faith, 0)


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
	gameState.turn += 1
	$Label.set_text("Turn: " + str(gameState.turn))


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
	Events.emit_signal("window_show", Types.WindowType.Event, {"eventType": Types.EventTypes.TurnRandom, "id": Data.getEventIdByName(Types.EventTypes.TurnRandom, "swordbread")})
	
