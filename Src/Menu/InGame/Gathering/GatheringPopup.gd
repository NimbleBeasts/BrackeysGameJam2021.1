extends Control

signal day_cost_update(day_cost)

var points : int = 0

func _ready():
	Events.connect(Events.EXPEDITION_CANCELLED, self, "free_myself")
	Events.connect(Events.EXPEDITION_CONFIRMED, self, "create_expedition")
	
# warning-ignore:return_value_discarded
	$Remove.connect("pressed", self, "remove_pressed")
	$Remove.setText("Remove")

func create_expedition() -> void :
	var new_expedition : ExpeditionsRoll = ExpeditionsRoll.new()
	new_expedition.start()

func free_myself() -> void :
	queue_free()

func remove_pressed() -> void :
	Events.emit_signal(Events.GATHER_POINT_REMOVED)


func _on_GatheringDisplay_day_cost_update(day_cost):
	emit_signal("day_cost_update", day_cost)
