extends Node
class_name ResourcesGetter

var expedition_calc : ExpeditionCalculator
var resources_handler : ResourcesHandler

func get_faith() -> int :
	return resources_handler.get_faith()

func get_food() -> int :
	return resources_handler.get_food()
	
func get_water() -> int :
	return resources_handler.get_water()

func gift_faith(faith : int) -> void :
	resources_handler.gift_faith(faith)

func gift_food(food : int) -> void :
	resources_handler.gift_food(food)

func gift_water(water : int) -> void :
	resources_handler.gift_water(water)

func use_faith(faith_amount : int) -> void :
	resources_handler.use_faith(faith_amount)

func use_food(food_amount : int) -> void :
	resources_handler.use_food(food_amount)

func use_water(water_amount : int) -> void :
	resources_handler.use_water(water_amount)

func project_cost(unit_count : int) -> Dictionary :
	return expedition_calc.project_cost(unit_count)

func project_reward() -> Dictionary :
	return expedition_calc.project_reward()
