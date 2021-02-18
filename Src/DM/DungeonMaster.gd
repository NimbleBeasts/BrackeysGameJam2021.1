extends Node


onready var puh = $PlayerUnitHandler
onready var res = $Resources

onready var turn_ended_processing = [res]

#Generate a new location
func _enter_new_location() -> void :
	var new_location = $Expedition/ExpeditionGenerator.generate_expedition()
	Events.emit_signal(Events.NEW_LOCATION_REACHED, new_location)

func _game_lost() -> void :
	get_tree().quit()

var ready_already_done : bool = false
func _ready():
	if ready_already_done :
		return
	ready_already_done = true
	
	#Let everything know the game has begun.
	#I might need to call_deferred this.
	#Emit this before connection so that game 2 and beyond logic
	#is not performed.
	Events.emit_signal(Events.TURN_STARTED)
	
	Events.connect(Events.TURN_ENDED, self, "_turn_ended")
	Events.connect(Events.GAME_LOST, self, "_game_lost")
	
	#Generate a grid map at start of game.
	_enter_new_location()
	
	#Listen for when the location is left so we can generate a new one.
	Events.connect(Events.LEFT_LOCATION, self, "_enter_new_location")

func _turn_ended() -> void :
	#Go through nodes that need to finish processing
	#and see if they complete succesfully. If not succesful, game ends.
	for node in turn_ended_processing :
		if not node.turn_end_test() :
			Events.emit_signal(Events.GAME_LOST)
	 
	#All tests succeeded. Start next turn.
	Events.emit_signal(Events.TURN_STARTED)

func get_unit_count() -> int :
	return puh.get_unit_count()

func get_units_present() -> int :
	return puh.get_available_units()
