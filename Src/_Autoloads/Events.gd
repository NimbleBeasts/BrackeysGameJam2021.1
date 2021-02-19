extends Node

#warning-ignore-all:unused_signal

const DEBUG_OUTPUT_ON_SIGNAL_CONNECT = false

###############################################################################
# Global Signal List
###############################################################################

# Level Management
signal new_game()

# Window Management
signal window_show(windowType) #Types.WindowType
const WINDOW_SHOW = "window_show"
signal window_close(windowType) #Types.WindowType
const WINDOW_CLOSE = "window_close"

signal window_event_show(eventType, eventId) #Types.EventTypes eventId can be of typ string or int
const WINDOW_EVENT_SHOW = "window_event_show"


#Dungeon Master. Turns, world events, etc.
signal dice_roll_created(dice_roll_dice_roll)
const DICE_ROLL_CREATED = "dice_roll_created"
signal game_lost()
const GAME_LOST = "game_lost"
signal left_location()
const LEFT_LOCATION = "left_location"
signal new_location_reached(new_location)
const NEW_LOCATION_REACHED = "new_location_reached"
signal turn_ended()
const TURN_ENDED = "turn_ended"
signal turn_started()
const TURN_STARTED = "turn_started"

#Gathering
signal expedition_cancelled()
const EXPEDITION_CANCELLED = "expedition_cancelled"
signal expedition_confirmed()
const EXPEDITION_CONFIRMED = "expedition_confirmed"
signal expedition_started()
const EXPEDITION_STARTED = "expedition_started"
signal gather_point_added(gatheringspot_spot)
const GATHER_POINT_ADDED = "gather_point_added"
signal gather_point_calculated(int_food_cost, int_water_cost)
const GATHER_POINT_CALCULATED = "gather_point_calculated"
signal gather_point_projected(int_food_cost, int_water_cost)
const GATHER_POINT_PROJECTED = "gather_point_projected"
signal gather_point_removed()
const GATHER_POINT_REMOVED = "gather_point_removed"

#Unit and resource handling
signal add_unit()
const ADD_UNIT = "add_unit"
signal energy_changed(int_new_energy_value)
const ENERGY_CHANGED = "energy_changed"
signal faith_changed(int_new_faith_value)
const FAITH_CHANGED = "faith_changed"
signal food_changed(int_new_food_value)
const FOOD_CHANGED = "food_changed"
signal unit_slotted()
const UNIT_SLOTTED = "unit_slotted"
signal units_temp_slotted(int_num_units)
const UNITS_TEMP_SLOTTED = "units_temp_slotted"
signal water_changed(int_new_water_value)
const WATER_CHANGED = "water_changed"

# Sound
signal play_sound(sound, volume, pos)

# Menu Related
signal menu_back()

# Config
signal switch_sound(value)
signal switch_music(value)
signal switch_fullscreen(value)

###############################################################################

# Global Event Connect Function
func connect(tSignal: String, target: Object, method: String, binds: Array = [], flags: int = 0):
	if Global.DEBUG and DEBUG_OUTPUT_ON_SIGNAL_CONNECT:
		print("Signal: [" + tSignal + "] -> " + str(target.name) + str(target))
	return .connect(tSignal, target, method)

# Prints the Signal Connection List
func debugGetSignalConnectionList(tSignal: String):
	print("Signal: [" + tSignal + "]")
	for sig in get_signal_connection_list(tSignal):
		print("-> " + str(sig.target.name)  + str(sig.target) + " - func:" + str(sig.method) )

# Deprecated: Global Event Connect Function
func connect_signal(tSignal: String, target: Object, method: String):
	#warning-ignore:return_value_discarded
	connect(tSignal, target, method)
