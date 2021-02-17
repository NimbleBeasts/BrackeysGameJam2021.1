extends Node
class_name ResourcesGetter

#These take into account how many units there are.
var projected_food_cost : int = 0 setget ,get_projected_food_cost
var projected_water_cost : int = 0 setget ,get_projected_water_cost

func _init():
	Events.connect(Events.GATHER_POINT_CALCULATED, self, "project_cost")

func get_projected_food_cost() -> int :
	return projected_food_cost

func get_projected_water_cost() -> int :
	return projected_water_cost

func project_cost(food : int, water : int) -> void :
	projected_food_cost = food * Types.unit_getter.get_slotted_units()
	projected_water_cost = water * Types.unit_getter.get_slotted_units()
	Events.emit_signal(Events.GATHER_POINT_PROJECTED, self, projected_food_cost, projected_water_cost)
