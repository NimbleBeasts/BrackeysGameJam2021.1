extends Node


var biome_array = []
var current_index = 0
var next_index = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("move_next", self, "move_next")
	create_map()
	Events.emit_signal("move_update_gfx", biome_array[current_index], biome_array[next_index])


func create_map():
	#Create Biome Map
	var last_biome = -1

	for i in range(32):
		var randVal = randi() % Types.BiomeType.size()
		
		while(last_biome == randVal):
			randVal = randi() % Types.BiomeType.size()

		last_biome = randVal
		
		biome_array.append(randVal)
	
	print(biome_array)

func move_next():
	print("moove")
	current_index = next_index
	next_index += 1
	if next_index >= biome_array.size():
		next_index = 0
	
	yield(get_tree().create_timer(2.0), "timeout") #ugliest thing on earth
	Events.emit_signal("move_update_gfx", biome_array[current_index], biome_array[next_index])
