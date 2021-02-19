extends Node
class_name ExpeditionGenerator


var grid : Array = []

export var expedition_grid_size : Vector2 = Vector2(10,10)

func _ready():
	Types.grid_getter.set_expedition_generator(self)

func generate_expedition() -> Array :
	#Start the grid anew.
	grid.clear()
	
	#Create a randomized expedition.
	for _x in range(expedition_grid_size.x) :
		var y_array : Array = []
		for _y in range(expedition_grid_size.y) :
			#Generate a spot on the grid.
			var spot : int = randi() % 26
			if spot >= Types.ExpeditionSpots.NORMAL : #Lean towards placing normals.
				spot = Types.ExpeditionSpots.NORMAL
			
			y_array.append(spot)
		grid.append(y_array)
	
	return grid

func get_grid() -> Array :
	return grid
