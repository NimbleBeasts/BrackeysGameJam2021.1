extends Label

var ag : EnemyArmyGetter = Types.enemy_army_getter
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(ag.get_days_left())
	
	Events.connect(Events.ENEMY_ARMY_DAYS_CHANGED, self, "count_update")

func count_update(count : int) -> void :
	text = str(count)
