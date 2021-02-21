extends Node
class_name PlayerUnitHandler

onready var unit_getter = Types.unit_getter


#{"uid","type","name","available"}. Units in total.
var units : Array = [] setget ,get_units_all_array
var available_units : Array = []


#How many units you have in total.
var unit_count : int = 6 setget  ,get_unit_count

#How many units are in a temporary holding position.
var temp_slotted_units : Array = []


#Listen for units being added.
var already_ready : bool = false
func _ready() -> void :
	if not already_ready :
		already_ready = true
		Events.connect(Events.ADD_UNIT, self, "add_unit")
		unit_getter.set_unit_handler(self)

# Used to create the initial starting group
func create_new_group():
	var pid = add_unit_by_name("princess")
	units[pid].available = false
	for _i in range(0,unit_count) :
# warning-ignore:return_value_discarded
		add_unit_by_chance(false)
	
	#Lock the first unit into being used.
	temp_slotted_units.append(units[0])

# Create a new unit
func add_unit_by_name(unitName : String) -> int:
	var unit : Unit = Unit.new()
	unit.set_by_name(unitName)
	units.append(unit)
	available_units.append(unit)
	unit_count += 1
	return (units.size() - 1)

# Create a new unit by chance
func add_unit_by_chance(show_fb = true) -> int:
	var unit : Unit = Unit.new()
	unit.set_by_chance()
	
	if show_fb:
		var payload = {"text":unit.name+" "+tr("ARRIVALONE"), "meaning":"neutral"}
		Events.emit_signal("window_show", Types.WindowType.ResFb, payload)
	
	units.append(unit)
	available_units.append(unit)
	Events.emit_signal(Events.UNITS_AVAILABLE_CHANGED, available_units)
	unit_count += 1
	
	return 0

func get_available_units_count() -> int :
	return available_units.size()

# Get avaialble units array
func get_units_available_array():
	return available_units
	
# Get all units array 
func get_units_all_array():
	return units

func get_unit_count() -> int :
	return units.size()

func get_units_by_ids(ids : Array) -> Array :
	var return_array : Array = []
	for unit in available_units :
		for id in ids :
			if unit.uid == id :
				return_array.append(unit)
	
	return return_array

func get_units_present() -> int :
	return get_available_units_count()

func get_temp_slot_units() -> Array :
	return temp_slotted_units

func get_temp_slot_units_count() -> int :
	return temp_slotted_units.size()

func gift_units(unit_amount : int) -> void :
	while unit_amount > 0 :
		unit_amount -= 1
# warning-ignore:return_value_discarded
		add_unit_by_chance()

#Remove some units from the game completely.
func kill_units(units_to_kill : Array) -> void :
	#First remove them from the units array.
	var av_changed : bool = false
	for unit in units_to_kill :
		var units_has : bool = units.has(unit)
		var av_has : bool = available_units.has(unit)
		assert(units_has || av_has)
		if units_has :
			units.remove(units.find(unit))
		if av_has :
			av_changed = true
			available_units.remove(available_units.find(unit))
		unit.queue_free()
	
	if av_changed :
		Events.emit_signal(Events.UNITS_AVAILABLE_CHANGED, available_units)
	
	Events.emit_signal(Events.UNITS_KILLED, units_to_kill)

func retrieve_temp_slotted_units() -> Array :
	#We are about to take away available units.
	for unit in temp_slotted_units :
		assert(units.has(unit))
		available_units.remove(available_units.find(unit))
	
	unit_count -= temp_slotted_units.size()
	
	var new_array : Array = []
	for unit in temp_slotted_units :
		new_array.append(unit)
	temp_slot_units([])
	
	#Let everything know that the available units count changed.
	Events.emit_signal(Events.UNITS_AVAILABLE_CHANGED, available_units)
	
	return new_array

func return_units(returning_units : Array) -> void :
	available_units += returning_units
	Events.emit_signal(Events.UNITS_RETURNED, returning_units)
	
	var names = ""
	var count = 0
	for unit in returning_units:
		names += unit.name
		if count != len(returning_units)-1:
			names += ", "
		count += 1
	var payload = {"text":str(names)+" "+tr("RETURNING"), "meaning":"positive"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)
	
	Events.emit_signal(Events.UNITS_AVAILABLE_CHANGED, available_units)

func temp_slot_units(units_temp_slot : Array) -> void :
	assert(units_temp_slot.size() <= units.size())
	for unit in units_temp_slot :
		assert(units.has(unit))
	temp_slotted_units = units_temp_slot
	
	var names = ""
	var count = 0
	for unit in units_temp_slot:
		names += unit.name
		if count != len(units_temp_slot)-1:
			names += ", "
		count += 1
	var payload = {"text":str(names)+" "+tr("GOINGOUT"), "meaning":"neutral"}
	if len(names) > 0:
		Events.emit_signal("window_show", Types.WindowType.ResFb, payload)
	
	Events.emit_signal(Events.UNITS_TEMP_SLOTTED, temp_slotted_units)
