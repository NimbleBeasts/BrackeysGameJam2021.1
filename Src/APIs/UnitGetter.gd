extends Node
class_name UnitGetter


var unit_handler : PlayerUnitHandler setget set_unit_handler


func set_unit_handler(new_unit_handler : PlayerUnitHandler) -> void :
	unit_handler = new_unit_handler

func get_available_units() -> int :
	return unit_handler.get_available_units()

#These are the units you will send out.
func get_slotted_units() -> int :
	return unit_handler.slotted_units
