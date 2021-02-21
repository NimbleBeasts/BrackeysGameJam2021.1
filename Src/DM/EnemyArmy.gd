extends Node
class_name EnemyArmyHandler

var counter : int = 10

func _init():
	Types.enemy_army_getter.handler = self

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Events.connect(Events.TURN_ANIMATED, self, "countdown")
	Events.connect(Events.LEFT_LOCATION, self, "reset")

func countdown() -> void :
	counter -= 1
	Events.emit_signal(Events.ENEMY_ARMY_DAYS_CHANGED, counter)
	
	if counter <= 0 :
		Events.emit_signal(Events.GAME_LOST, Types.GameOverType.Units) #Game is over

func get_days_left() -> int :
	return counter

func reset() -> void :
	Events.emit_signal(Events.ENEMY_ARMY_DAYS_CHANGED, counter)
	counter = 11
