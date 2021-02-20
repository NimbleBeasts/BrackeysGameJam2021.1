extends Control

const eventStructureFilePath = "res://Assets/EventWindow/events.json"

# According to enum Types.WindowType 
const windowScenes = [
	preload("res://Src/ExpeditionWindow/ExpeditionWindow.tscn"), 
	preload("res://Src/EventWindow/EventWindow.tscn"),
	preload("res://Src/CharacterWindow/CharacterWindow.tscn"),
]

var activeWindow = null


func _ready():
	# Window Management
	Events.connect(Events.WINDOW_SHOW, self, "showWindow")
	Events.connect(Events.WINDOW_CLOSE, self, "closeWindow")


func showWindow(type, payload = null): #Types.WindowType
	var data = null
	# Parse Payload Data
	match type:
		Types.WindowType.Event:
			#{"eventType": Types.EventTypes.TurnRandom, "id": randi()%2 }
			var eventType = payload.eventType
			var eventId = payload.id
			data = Data.getEventDataById(eventType, eventId)
		Types.WindowType.Char:
			data = payload

	var window = _spawnWindow(type, data)
	_focus_window(window)
	window.rect_position += Vector2(8, 8) * get_child_count()
	Events.emit_signal("window_black_screen_show")


func closeWindow(node):
	if node:
		var openWindows = get_child_count() #Removing is asynchronous 
		node.queue_free()
		if get_child_count() <= 1:
			Events.emit_signal("window_black_screen_hide")


func _spawnWindow(type, data):
	var window = windowScenes[type].instance()
	window.connect("focus_window", self, "_focus_window")
	window.hide()
	self.add_child(window)
	if data != null:
		window.content.setup(data)
	window.show()
	return window

func _focus_window(node):
	move_child(node, get_child_count() - 1)
	
	if activeWindow:
		activeWindow.setActive(false)
	
	activeWindow = node
	activeWindow.setActive(true)
