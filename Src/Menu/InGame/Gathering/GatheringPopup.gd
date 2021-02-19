extends Control

var points : int = 0

func _ready():
	Events.connect(Events.EXPEDITION_CANCELLED, self, "free_myself")
	Events.connect(Events.GATHER_POINT_ADDED, self, "add_point")
	Events.connect(Events.EXPEDITION_CONFIRMED, self, "create_expedition")

func create_expedition() -> void :
	var new_expedition : ExpeditionsRoll = ExpeditionsRoll.new()
	new_expedition.start()

func free_myself() -> void :
	queue_free()

