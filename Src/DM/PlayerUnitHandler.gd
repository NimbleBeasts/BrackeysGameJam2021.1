extends Node

#How many units you have in total.
var unit_count : int = 0

#How many units you have that are not occupied.
var available_units : int = 0

#Listen for units being added.
var already_ready : bool = false
func _ready() -> void :
	if not already_ready :
		already_ready = true
		Events.connect(Events.ADD_UNIT, self, "add_unit")

func add_unit() -> void :
	print(str(unit_count))
	unit_count += 1
	available_units += 1
	print(str(unit_count))
