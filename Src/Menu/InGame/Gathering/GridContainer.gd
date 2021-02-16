extends HBoxContainer



func _ready():
	Events.connect(Events.NEW_LOCATION_REACHED, self, "new_location")

func new_location(location : Array) -> void :
	#Erase all the spots that are children currently.
	for child in get_children() :
		child.queue_free()
	
	#Location is a 2D array.
	var x_int : int = 0
	for x in location :
		var vcontainer : VBoxContainer = VBoxContainer.new()
		vcontainer.set("custom_constants/separation", 0)
		call_deferred("add_child", vcontainer)
		var y_int : int = 0
		for y in x :
			var spot : GatheringSpot = GatheringSpot.new(Vector2(x_int, y_int))
			vcontainer.call_deferred("add_child", spot)
			y_int += 1
		x_int += 1
