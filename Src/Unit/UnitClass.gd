extends Node
class_name Unit


var uid =randi()
var type : String
var available : bool = true


func set_by_name(type_name : String) -> void :
	for entry in Data.units:
		if entry.type == type_name:
				type = type_name
				name = entry.names[randi() % entry.names.size()]
				available = true
		
	uid = str(self).sha256_text()

func set_by_chance() -> void :
	var entry : Dictionary = Data.units[(randi() % Data.units.size() - 2) + 1]
	
	type = entry.type
	name = entry.names[randi() % entry.names.size()]
	available = true
	
	uid = str(self).sha256_text()
