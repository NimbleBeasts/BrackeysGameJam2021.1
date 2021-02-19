extends Control

# This will be used for save/load game
var gameState = {
	resources = { water = 20, food = 41, faith = 80 },
	turn = 0
	
}

onready var GameUi = $GameMenu

###############################################################################
# Functions
###############################################################################

func _ready():
	initDebug()
	Events.connect("event_choice", self, "eventChoice")

#signal event_choice(type, id, choice) #Types.EventTypes
func eventChoice(type, id, choice):
	print("GameInstance.gd: eventChoice selected: " + str(choice) + " type:" + str(Types.EventTypes.keys()[type]) + " id: " + str(id))
	#TODO: do the stuff here


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
			GameUi.updateResourceGui(type, gameState.resources.water)
		Types.ResourceType.Food:
			gameState.resources.food += 100
			GameUi.updateResourceGui(type, gameState.resources.food)
		_:
			gameState.resources.faith += 100
			GameUi.updateResourceGui(type, gameState.resources.faith)
	
func debugClearResource(_d):
	gameState.resources.water = 0
	gameState.resources.food = 0
	gameState.resources.faith = 0
	GameUi.updateResourceGui(Types.ResourceType.Water, 0)
	GameUi.updateResourceGui(Types.ResourceType.Food, 0)
	GameUi.updateResourceGui(Types.ResourceType.Faith, 0)
