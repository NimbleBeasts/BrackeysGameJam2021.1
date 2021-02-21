extends Node
class_name EventHandler

var event : Dictionary 

var help : JSONEventHelper = JSONEventHelper.new()


func _ready():
	Events.connect("event_choice", self, "handle_choice")
	Types.events_getter.event_handler = self

func set_event(data : Dictionary) -> void :
	event = data

#signal event_choice(type, id, choice) #Types.EventTypes
#Deprecated.
func eventChoice(type : int, id : int, choice : String):
	print("DM/Events: eventChoice selected: " + str(choice) + " type:" + str(Types.EventTypes.keys()[type]) + " id: " + str(id))

	match type:
		Types.EventTypes.TurnRandom:
			if id == 2: 
				Events.emit_signal("window_show", Types.WindowType.Char, Types.CharEventType.Sacrifice)

func handle_choice(choice : String) -> void :
	help.handle_choice(event, choice)
