extends Node
class_name EventsGetter

var event_handler : EventHandler setget set_event_handler


func set_event(event : Dictionary) -> void :
	event_handler.set_event(event)

func set_event_handler(eh : EventHandler) -> void :
	event_handler = eh
