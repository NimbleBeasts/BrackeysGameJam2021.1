extends Node
class_name PlayerUnitHandler

onready var unit_getter = Types.unit_getter

#How many units you have in total.
var unit_count : int = 20 setget  ,get_unit_count

#Units you will potentially use on expeditions.
var slotted_units : int = 0

#How many units you have that are not occupied.
var available_units : int = 20

#Listen for units being added.
var already_ready : bool = false
func _ready() -> void :
	if not already_ready :
		already_ready = true
		Events.connect(Events.ADD_UNIT, self, "add_unit")
		Events.connect(Events.UNIT_SLOTTED, self, "slot_units")
		unit_getter.set_unit_handler(self)

func add_unit() -> void :
	unit_count += 1
	available_units += 1

#Return number of units not away from camp. Either available or sleeping.
func get_available_units() -> int :
	return available_units

func get_unit_count() -> int :
	return unit_count

func slot_units(num_units : int = 1) -> void :
	assert(num_units <= available_units)
	available_units -= num_units
	slotted_units += num_units

