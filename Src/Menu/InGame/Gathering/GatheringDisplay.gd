extends VBoxContainer

signal day_cost_update(day_cost)

var rg : ResourcesGetter = Types.resources_getter

const TEXT = "Cost per unit:\nFood: %s\nWater: %s\n\nDay cost: %s\n\nRewards:\nfaith: %s\nfood: %s\nwater: %s"

func _update_point(_no_use_arg = null) -> void :
	var val : Dictionary = rg.project_cost(1)
	var rew : Dictionary = rg.project_reward()
	
	emit_signal("day_cost_update", val["day_cost"])
	$Label2.text = TEXT % [val["food"],val["water"],val["day_cost"], rew["faith"], rew["food"], rew["water"]]


func _ready():
	Events.connect(Events.GATHER_POINT_ADDED, self, "_update_point")	
	Events.connect(Events.GATHER_POINT_REMOVED, self, "_update_point")
