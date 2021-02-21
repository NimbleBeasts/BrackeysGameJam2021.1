extends Node
class_name ResourcesHandler


#How much a unit costs per turn in food and water.
export(int) var unit_faith_gained = -1
export(int) var unit_food_cost = 5
export(int) var unit_water_cost = 5

#The dungeon master has everything I need.
onready var dm : Node = get_parent()

var energy : int = 500 setget set_energy
var faith : int = 500 setget set_faith
var food : int = 500 setget set_food
var water : int = 500 setget set_water

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

func get_faith() -> int :
	return faith

func get_food() -> int :
	return food

func get_water() -> int :
	return water

func gift_faith(faith_amount : int, reason = "") -> void :
	if faith_amount < 0: 
		use_faith(-1*faith_amount, reason)
		return
	set_faith(faith + faith_amount)
	var payload = {"text":tr("YOUGAINEDRES")+" "+str(faith_amount)+" "+tr("OFFAITH"), "meaning":"positive"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

func gift_food(food_amount : int, reason = "") -> void :
	if food_amount < 0: 
		use_food(-1*food_amount, reason)
		return
	set_food(food + food_amount)
	var payload = {"text":tr("YOUGAINEDRES")+" "+str(food_amount)+" "+tr("OFFOOD"), "meaning":"positive"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

func gift_water(water_amount : int, reason = "") -> void :
	if water_amount < 0: 
		use_water(-1*water_amount, reason)
		return
	set_water(water + water_amount)
	var payload = {"text":tr("YOUGAINEDRES")+" "+str(water_amount)+" "+tr("OFWATER"), "meaning":"positive"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

#Calculate how much food is used based on unit amount.
func turn_end_test() -> bool :
	#Subtract from water and food based on number of units.
	var units : int = dm.get_unit_count()
	use_food((units * unit_food_cost))
	use_water((units * unit_water_cost))
	
	#Add to faith based on resting and available units.
	var present : int = dm.get_units_present()
	use_faith(((unit_faith_gained * present) * 0.5))
	
	#Check that no resource is below 0.
	if food <= 0 || water <= 0 :
		return false
	
	#Let dungeon master know I am finished processing turn end.
	return true

func use_faith (faith_amount : int, reason = "") -> void :
	set_faith(faith - faith_amount)
	var payload = {"text":tr("YOULOSTRES")+" "+str(faith_amount)+" "+tr("OFFAITH"), "meaning":"negative"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

func use_food(food_amout : int, reason = "") -> void :
	set_food(food - food_amout)
	var payload = {"text":tr("YOULOSTRES")+" "+str(food_amout)+" "+tr("OFFOOD"), "meaning":"negative"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

func use_water(water_amount : int, reason = "") -> void :
	set_water(water - water_amount)
	var payload = {"text":tr("YOULOSTRES")+" "+str(water_amount)+" "+tr("OFWATER"), "meaning":"negative"}
	Events.emit_signal("window_show", Types.WindowType.ResFb, payload)

func set_energy(energy_value : int, reason = "") -> void :
	energy = energy_value
	Events.emit_signal(Events.ENERGY_CHANGED, energy)

func set_faith(faith_value : int, reason = "") -> void :
	faith = faith_value
	if faith_value <= 0:
		Events.emit_signal(Events.GAME_LOST, Types.GameOverType.Faith)
	Events.emit_signal(Events.FAITH_CHANGED, faith)

func set_food(food_value : int, reason = "") -> void :
	food = food_value
	if food_value <= 0 :
		Events.emit_signal(Events.GAME_LOST, Types.GameOverType.Food)
	Events.emit_signal(Events.FOOD_CHANGED, food)

func set_water(water_value : int, reason = "") -> void :
	water = water_value
	if water_value <=  0 :
		Events.emit_signal(Events.GAME_LOST, Types.GameOverType.Water)
	Events.emit_signal(Events.WATER_CHANGED, water)
