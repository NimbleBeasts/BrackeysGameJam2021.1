extends Control

const eventStructureFilePath = "res://Assets/EventWindow/events.json"
const eventWindowScene = preload("res://Src/EventWindow/EventWindow.tscn")


var activeWindow = null
var eventDB = null



func _ready():
	# Read files
	eventDB = readEventData()
	assert(eventDB != null)
	
	# Connect the childs
	$ExpeditionWindow.connect("focus_window", self, "_focus_window")
	
	# Window Management
	Events.connect(Events.WINDOW_SHOW, self, "showWindow")
	Events.connect(Events.WINDOW_CLOSE, self, "closeWindow")
	
	Events.connect(Events.WINDOW_EVENT_SHOW, self, "spawnEventWindow")


func spawnEventWindow(type, key):
	var data = getEventData(type, key)
	var window = eventWindowScene.instance()
	window.connect("focus_window", self, "_focus_window")
	window.hide()
	self.add_child(window)
	window.content.setup(data)
	window.show()


func showWindow(type): #Types.WindowType
	match type:
		Types.WindowType.Expedition:
			print("show")
			$ExpeditionWindow.show()
			_focus_window($ExpeditionWindow)
		_:
			print("WindowManager.gd: Unknown window")

func closeWindow(type): #Types.WindowType
	match type:
		Types.WindowType.Expedition:
			print("hide")
			$ExpeditionWindow.reset()
			$ExpeditionWindow.hide()
		_:
			print("WindowManager.gd: Unknown window")
			
		#TODO: focus next visible window

func getEventKeyId(key):
	if typeof(key) == TYPE_STRING:
		#TODO: get entry id 
		print("string")
	else:
		return key

func getEventData(type, key):
	var entry = null
	var id = getEventKeyId(key)
		
	match type:
		Types.EventTypes.GameplayEvent:
			
			entry = eventDB.gameplay_event[id]
		Types.EventTypes.TurnRandom:
			
			entry = eventDB.turn_random[id]
		_:
			print("WindowManager.gd: getEventData unknown type")
	print("-------------Get-------------")
	print(entry)
	return entry

# Loads the events json data file and parses it
func readEventData():
	#TODO: put it in the right spot
	var eventFile = File.new()
	assert(eventFile.file_exists(eventStructureFilePath))
	eventFile.open(eventStructureFilePath, File.READ)
	return parse_json(eventFile.get_as_text())

func _focus_window(node):
	move_child(node, get_child_count() - 1)
	
	if activeWindow:
		activeWindow.setActive(false)
	
	activeWindow = node
	activeWindow.setActive(true)
