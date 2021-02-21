extends Node
class_name UnitGetter


var unit_handler : PlayerUnitHandler setget set_unit_handler


func add_unit_by_chance() -> void :
	unit_handler.add_unit_by_chance()

func set_unit_handler(new_unit_handler : PlayerUnitHandler) -> void :
	unit_handler = new_unit_handler

func set_temp_slotted_units(units : Array) -> void :
	unit_handler.temp_slot_units(units)

func get_available_units() -> Array :
	return unit_handler.get_available_units()

func get_available_units_count() -> int :
	return unit_handler.get_available_units_count()

func get_units_by_ids(ids : Array) -> Array :
	return unit_handler.get_units_by_ids(ids)

func get_temp_slotted_units_count() -> int :
	return unit_handler.get_temp_slot_units_count()

func gift_units(unit_count : int) -> void :
	unit_handler.gift_units(unit_count)
	var payload = {"text":str(unit_count)+" "+tr("ARRIVALS"), "meaning":"neutral"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

func kill_units(units_to_kill : Array) -> void :
	unit_handler.kill_units(units_to_kill)
	var names = ""
	var count = 0
	for unit in units_to_kill:
		names += unit.name
		if count != len(units_to_kill)-1:
			names += ", "
		count += 1
	var payload = {"text":tr("DEADS")+" "+str(names), "meaning":"negative"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

func retrieve_temp_slotted_units() -> Array :
	return unit_handler.retrieve_temp_slotted_units()

func return_units(returning_units : Array) -> void :
	unit_handler.return_units(returning_units)
