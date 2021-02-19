extends Control

var points : int = 0

func _ready():
	Events.connect(Events.EXPEDITION_STARTED, self, "popup")
	Events.connect(Events.EXPEDITION_CANCELLED, self, "inverse_popup")
	Events.connect(Events.GATHER_POINT_ADDED, self, "add_point")
	
	#warning-ignore:return_value_discarded
	$PointHandling/Confirm.connect("pressed", self, "create_expedition")

func create_expedition() -> void :
	var new_expedition : ExpeditionsRoll = ExpeditionsRoll.new()
	new_expedition.start()

func inverse_popup() -> void :
	self.hide()

func popup() -> void :
	self.show()
