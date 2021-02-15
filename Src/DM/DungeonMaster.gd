extends Node


onready var puh = $PlayerUnitHandler

#Start the turn at the beginning of the game.
var ready_already_done : bool = false
func _ready():
	if not ready_already_done :
		ready_already_done = true
		Events.emit_signal(Events.TURN_STARTED)

func get_unit_count() -> int :
	return puh.get_unit_count()

func get_units_present() -> int :
	return puh.get_units_present()
