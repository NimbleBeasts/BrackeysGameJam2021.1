extends Node

func _ready():
	Events.connect("event_choice", self, "eventChoice")

#signal event_choice(type, id, choice) #Types.EventTypes
func eventChoice(type, id, choice):
	print("DM/Events: eventChoice selected: " + str(choice) + " type:" + str(Types.EventTypes.keys()[type]) + " id: " + str(id))
	#TODO: do the stuff here
	
	match type:
		Types.EventTypes.TurnRandom:
			#TODO: Quick and dirty for now, we better check the actual consequences type
			if id == 2: 
				Events.emit_signal("window_show", Types.WindowType.Char, Types.CharEventType.Sacrifice)


