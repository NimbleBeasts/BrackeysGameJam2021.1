extends Label

var ug : UnitGetter = Types.unit_getter


func _ready():
	Events.connect(Events.UNITS_AVAILABLE_CHANGED, self, "unit_changed")
	
	call_deferred("start_set_units")

func start_set_units() -> void :
	text = str(ug.get_available_units_count())

func unit_changed(units : Array) -> void :
	text = str(units.size())
