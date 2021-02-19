extends Node
class_name ResourcesGetter

var expedition_calc : ExpeditionCalculator
var resources_handler : ResourcesHandler

func use_faith(faith_amount : int) -> void :
	resources_handler.use_faith(faith_amount)

func use_food(food_amount : int) -> void :
	resources_handler.use_food(food_amount)

func use_water(water_amount : int) -> void :
	resources_handler.use_water(water_amount)

func project_cost(unit_count : int) -> Dictionary :
	return expedition_calc.project_cost(unit_count)
