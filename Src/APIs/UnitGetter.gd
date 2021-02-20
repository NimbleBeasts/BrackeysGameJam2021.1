extends Node
class_name UnitGetter


var unit_handler : PlayerUnitHandler setget set_unit_handler


func set_unit_handler(new_unit_handler : PlayerUnitHandler) -> void :
	unit_handler = new_unit_handler

func set_temp_slotted_units(units : Array) -> void :
	unit_handler.temp_slot_units(units)

func get_available_units() -> Array :
	return unit_handler.get_available_units()

func get_available_units_count() -> int :
	return unit_handler.get_available_units_count()

func get_temp_slotted_units_count() -> int :
	return unit_handler.get_temp_slot_units_count()

func gift_units(unit_count : int) -> void :
	unit_handler.gift_units(unit_count)

func retrieve_temp_slotted_units() -> Array :
	return unit_handler.retrieve_temp_slotted_units()

func return_units(returning_units : Array) -> void :
	unit_handler.return_units(returning_units)
