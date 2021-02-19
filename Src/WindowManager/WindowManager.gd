extends Control

const eventStructureFilePath = "res://Assets/EventWindow/events.json"

# According to enum Types.WindowType 
const windowScenes = [preload("res://Src/ExpeditionWindow/ExpeditionWindow.tscn"), preload("res://Src/EventWindow/EventWindow.tscn")]

var activeWindow = null
var eventDB = null



func _ready():
	
	# Window Management
	Events.connect(Events.WINDOW_SHOW, self, "showWindow")
	Events.connect(Events.WINDOW_CLOSE, self, "closeWindow")


func spawnEventWindow(type, id):
	var data = Data.getEventDataById(type, id)



func showWindow(type, payload = null): #Types.WindowType
	var data = null
	
	# Parse Payload Data
	match type:
		Types.WindowType.Event:
			#{"eventType": Types.EventTypes.TurnRandom, "id": randi()%2 }
			var eventType = payload.eventType
			var eventId = payload.id
			data = Data.getEventDataById(eventType, eventId)

	var window = _spawnWindow(type, data)
	_focus_window(window)
	Events.emit_signal("window_black_screen_show")


func closeWindow(type): #Types.WindowType
	match type:
		Types.WindowType.Expedition:
			print("hide")
			$ExpeditionWindow.reset()
			$ExpeditionWindow.hide()
		_:
			print("WindowManager.gd: Unknown window")
			
		#TODO: focus next visible window
	
	Events.emit_signal("window_black_screen_hide")

func _spawnWindow(type, data):
	var window = windowScenes[type].instance()
	window.connect("focus_window", self, "_focus_window")
	window.hide()
	self.add_child(window)
	if data:
		window.content.setup(data)
	window.show()
	return window

func _focus_window(node):
	move_child(node, get_child_count() - 1)
	
	if activeWindow:
		activeWindow.setActive(false)
	
	activeWindow = node
	activeWindow.setActive(true)
