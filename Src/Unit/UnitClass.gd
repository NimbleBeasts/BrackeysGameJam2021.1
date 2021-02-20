extends Node
class_name Unit


var uid =randi()
var type : int
var available : bool = true


func set_by_name(type_name : String) -> void :
	for entry in Data.units:
		if entry.type == type_name:
				type = Types.UnitTypes.keys().find(entry.type.capitalize())
				name = entry.names[randi() % entry.names.size()]
				available = true
		
	uid = str(self).sha256_text()

func set_by_chance() -> void :
	var rand = randi() % 100
	var accumulatedChance = 0
	
	for entry in Data.units:
		accumulatedChance += entry.chance
		if accumulatedChance > rand:
			type = Types.UnitTypes.keys().find(entry.type.capitalize())
			name = entry.names[randi() % entry.names.size()]
			available = true
			break

	uid = str(self).sha256_text()
