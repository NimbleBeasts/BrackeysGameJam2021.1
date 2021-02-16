extends Node

enum SPOTS {
	LAKES = 0,
	HUNTING = 1,
	RUINS = 2,
	BERRIES = 3,
	CREEKS = 4,
	NORMAL = 5
}

var grid : Array = []

export var expedition_grid_size : Vector2 = Vector2(16,16)

func generate_expedition() -> Array :
	#Start the grid anew.
	grid.clear()
	
	#Create a randomized expedition.
	for _x in range(expedition_grid_size.x) :
		var y_array : Array = []
		for _y in range(expedition_grid_size.y) :
			#Generate a spot on the grid.
			var spot : int = randi() % 26
			if spot >= SPOTS.NORMAL : #Lean towards placing normals.
				spot = SPOTS.NORMAL
			
			y_array.append(spot)
		grid.append(y_array)
	
	return grid
