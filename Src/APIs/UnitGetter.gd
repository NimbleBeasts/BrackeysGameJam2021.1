extends Node
class_name UnitGetter


var unit_handler : PlayerUnitHandler setget set_unit_handler


func add_temp_slotted_unit() -> void :
	if unit_handler.get_available_units() > 0 :
		unit_handler.temp_slot_units(unit_handler.get_temp_slot_units() + 1)

func set_unit_handler(new_unit_handler : PlayerUnitHandler) -> void :
	unit_handler = new_unit_handler

func get_available_units() -> int :
	return unit_handler.get_available_units()

#These are the units you will send out.
func get_slotted_units() -> int :
	return unit_handler.slotted_units

func get_temp_slotted_units() -> int :
	return unit_handler.get_temp_slot_units()

func gift_units(unit_count : int) -> void :
	unit_handler.gift_units(unit_count)

func retrieve_temp_slotted_units() -> int :
	return unit_handler.retrieve_temp_slotted_units()

func subtract_temp_slotted_unit() -> void :
	if unit_handler.get_temp_slot_units() > 0 :
		unit_handler.temp_slot_units(unit_handler.get_temp_slot_units() - 1)
