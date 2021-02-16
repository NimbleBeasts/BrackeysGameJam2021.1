extends Button
class_name GatheringSpot

var location_in_grid : Vector2 = Vector2(-1,-1) setget set_location, get_location

func _init(location : Vector2 = Vector2(-1,-1)) :
	location_in_grid = location
	
	#Make sure values of the location are not incorrect.
	assert(location_in_grid.x >= 0 && location_in_grid.y >= 0)

#If the player presses me, add one point to the path.
func _pressed() -> void :
	#You are suppose to set the location in the grid for this button.
	assert(location_in_grid != Vector2(-1,-1))
	
	Events.emit_signal(Events.GATHER_POINT_ADDED, location_in_grid)
	
	#Let the player know where they clicked.
	print("You have clicked [%s] on the Expedition" % [str(location_in_grid)] )

func get_location() -> Vector2 :
	return location_in_grid

func set_location(new_location : Vector2) -> void :
	location_in_grid = new_location
