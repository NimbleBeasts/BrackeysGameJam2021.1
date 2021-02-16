extends Button
class_name GatheringSpot

var location_in_grid : Vector2 = Vector2(-1,-1) setget set_location, get_location

#This will determine spot type and thus what texture we use.
var spot_type : int = -1 setget set_spot_type, get_spot_type

func _init(location : Vector2 = Vector2(-1,-1), new_spot_type : int = -1) :
	location_in_grid = location
	spot_type = new_spot_type
	#Temporary modulation to show what type we are.
	if spot_type == 0 : #LAKE
		modulate = Color(0, 0.1, 0.5)
	elif spot_type == 1 : #HUNTING
		modulate = Color(1,0,0)
	elif spot_type == 2 : #RUINS
		modulate = Color(0.4,0.4,0.4)
	elif spot_type == 3 : #BERRIES
		modulate = Color(0,1,0)
	elif spot_type == 4 : #Creek :
		modulate = Color( 0,0,1)
	
	
	#Make sure values of the location are correct.
	assert(location_in_grid.x >= 0 && location_in_grid.y >= 0)

#If the player presses me, add one point to the path.
func _pressed() -> void :
	#You are suppose to set the location in the grid for this button.
	assert(location_in_grid != Vector2(-1,-1))
	
	Events.emit_signal(Events.GATHER_POINT_ADDED, location_in_grid)
	
	#Let the player know where they clicked.
	print("You have clicked [%s] on the Expedition. Spot value of %s" % [str(location_in_grid), str(spot_type)] )

func get_location() -> Vector2 :
	return location_in_grid

func set_location(new_location : Vector2) -> void :
	location_in_grid = new_location

func get_spot_type() -> int :
	return spot_type

func set_spot_type(new_spot_type : int) -> void :
	spot_type = new_spot_type
