extends Node
class_name ResourcesHandler


#How much a unit costs per turn in food and water.
export(int) var unit_faith_gained = 5
export(int) var unit_food_cost = 10
export(int) var unit_water_cost = 10

#The dungeon master has everything I need.
onready var dm : Node = get_parent()

var energy : int = 1000 setget set_energy
var faith : int = 1000 setget set_faith
var food : int = 1000 setget set_food
var water : int = 1000 setget set_water

func _init():
	Types.resources_getter.resources_handler = self

#Let others know about resources being initialized.
func _ready():
	call_deferred("_ready_deferred")

func _ready_deferred() -> void :
	set_water(water)
	set_food(food)
	set_energy(energy)
	set_faith(faith)

#Calculate how much food is used based on unit amount.
func turn_end_test() -> bool :
	#Subtract from water and food based on number of units.
	var units : int = dm.get_unit_count()
	set_food(food - (units * unit_food_cost))
	set_water(water - (units * unit_water_cost))
	
	#Add to faith based on resting and available units.
	var present = dm.get_units_present()
	set_faith(faith - ((unit_faith_gained * present) * 0.5))
	
	#Check that no resource is below 0.
	if food <= 0 || water <= 0 :
		return false
	
	#Let dungeon master know I am finished processing turn end.
	return true

func use_faith(faith_amount : int) -> void :
	set_faith(faith - faith_amount)

func use_food(food_amout : int) -> void :
	set_food(food - food_amout)

func use_water(water_amount : int) -> void :
	set_water(water - water_amount)

func set_energy(energy_value : int) -> void :
	energy = energy_value
	Events.emit_signal(Events.ENERGY_CHANGED, energy)

func set_faith(faith_value : int) -> void :
	faith = faith_value
	Events.emit_signal(Events.FAITH_CHANGED, faith)

func set_food(food_value : int) -> void :
	if food_value <= 0 :
		get_tree().quit()
	food = food_value
	Events.emit_signal(Events.FOOD_CHANGED, food)

func set_water(water_value : int) -> void :
	if water_value <=  0 :
		get_tree().quit()
	water = water_value
	Events.emit_signal(Events.WATER_CHANGED, water)
