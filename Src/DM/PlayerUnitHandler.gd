extends Node
class_name PlayerUnitHandler

onready var unit_getter = Types.unit_getter


#{"uid","type","name","available"}
var units = []

#How many units you have in total.
var unit_count : int = 20 setget  ,get_unit_count

#Units you will potentially use on expeditions.
var slotted_units : int = 0

#How many units are in a temporary holding position.
var temp_slotted_units : int = 1

#How many units you have that are not occupied.
var available_units : int = 20 setget ,get_available_units

#Listen for units being added.
var already_ready : bool = false
func _ready() -> void :
	if not already_ready :
		already_ready = true
		Events.connect(Events.ADD_UNIT, self, "add_unit")
		unit_getter.set_unit_handler(self)


# Used to create the initial starting group
func create_new_group():
	add_unit_by_name("princess")
	add_unit_by_chance()
	add_unit_by_chance()
	add_unit_by_chance()
	print(units)

# Create a new unit
func add_unit_by_name(unitName) -> int:
	var unit = null
	for entry in Data.units:
		if entry.type == unitName:
			unit = {
				"uid": randi(),
				"type": unitName,
				"name": entry.names[randi() % entry.names.size()],
				"available": false
			}
			unit.uid = str(unit).sha256_text()
			units.append(unit)
			return (units.size() - 1)
	return -1

# Create a new unit by chance
func add_unit_by_chance() -> int:
	var rand = randi() % 100
	var accumulatedChance = 0
	var unit = null
	
	for entry in Data.units:
		accumulatedChance += entry.chance
		if accumulatedChance > rand:
			unit = {
				"uid": randi(),
				"type": entry.type,
				"name": entry.names[randi() % entry.names.size()],
				"available": false
			}
			unit.uid = str(unit).sha256_text()
			units.append(unit)
			return (units.size() - 1)
	return -1

func add_unit() -> void :
	print("deprecated: add_unit")
	unit_count += 1
	available_units += 1

#Move units from temp_slotting to slotted
func confirm_slotting() -> void :
	set_available_units(available_units - temp_slotted_units)
	yield(get_tree().create_timer(0.1), "timeout")
	temp_slot_units(1)

#Return number of units not away from camp. Either available or sleeping.
func get_available_units() -> int :
	return available_units

func get_unit_count() -> int :
	return unit_count

func get_temp_slot_units() -> int :
	return temp_slotted_units

func gift_units(unit_amount : int) -> void :
	set_available_units(unit_amount + available_units)

func set_available_units(num : int) -> void :
	available_units = num

func retrieve_temp_slotted_units() -> int :
	var units : int = temp_slotted_units
	slot_units(temp_slotted_units)
	temp_slot_units(1)
	return units

func slot_units(num_units : int = 1) -> void :
	assert(num_units <= available_units)
	available_units -= num_units
	slotted_units += num_units

func temp_slot_units(num_to_temp_slot : int) -> void :
	if num_to_temp_slot > available_units :
		num_to_temp_slot = available_units
	temp_slotted_units = num_to_temp_slot
	Events.emit_signal(Events.UNITS_TEMP_SLOTTED, num_to_temp_slot)

