extends Node
class_name GridGetter


var expedition_generator : ExpeditionGenerator setget set_expedition_generator

func get_grid() -> Array :
	return expedition_generator.get_grid()

func set_expedition_generator(new_generator : ExpeditionGenerator) -> void :
	expedition_generator = new_generator
