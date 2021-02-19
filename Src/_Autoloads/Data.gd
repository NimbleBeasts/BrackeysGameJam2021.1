extends Node

const filePathEventExpedition = "res://Data/Events.Expedition.json"
const filePathEventGameplay = "res://Data/Events.Gameplay.json"
const filePathEventTurnRandom = "res://Data/Events.TurnRandom.json"

const filePathUnits = "res://Data/Units.json"

var events = {
	"expedition": [],
	"gameplay": [],
	"turnRandom": []
}

#Types.UnitTypes
var units = []


func _ready():
	loadGameData()

# Returns the Id for an entry
func getEventIdByName(type, eName):
	#TODO: not sure if we need different ways to handle it or all jsons have those id field
	match type:
		Types.EventTypes.Expedition:
			for i in range(events.expedition.size()):
				if events.expedition[i].id == eName:
					return i
		Types.EventTypes.Gameplay:
			for i in range(events.gameplay.size()):
				if events.gameplay[i].id == eName:
					return i
		Types.EventTypes.TurnRandom:
			for i in range(events.turnRandom.size()):
				if events.turnRandom[i].id == eName:
					return i
		_:
			print("Data.gd: getEventIdByName unknown type")
	# Error case
	return null


# Returns entry of a specific event type by id
func getEventDataById(type, id):
	var entry = null
	match type:
		Types.EventTypes.Expedition:
			entry = events.expedition[id]
		Types.EventTypes.Gameplay:
			entry = events.gameplay[id]
		Types.EventTypes.TurnRandom:
			entry = events.turnRandom[id]
		_:
			print("Data.gd: getEventDataById unknown type")
			return null
	return {"type": type, "id": id, "entry": entry}

# Load game data into variables
func loadGameData():
	# Loading Event Data
	events.expedition = readJsonFile(filePathEventExpedition)
	events.gameplay = readJsonFile(filePathEventGameplay)
	events.turnRandom = readJsonFile(filePathEventTurnRandom)
	assert(events.expedition and events.gameplay and events.turnRandom)

	units = readJsonFile(filePathUnits)
	assert(units)
	print(units)


# Reads and parses a JSON file and returns it as a variable
func readJsonFile(file):
	var eventFile = File.new()
	assert(eventFile.file_exists(file))
	eventFile.open(file, File.READ)
	return parse_json(eventFile.get_as_text())
