extends HBoxContainer



func _ready():
	Events.connect(Events.NEW_LOCATION_REACHED, self, "new_location")

func new_location(location : Array) -> void :
	#Erase all the spots that are children currently.
	for child in get_children() :
		child.queue_free()
	
	#Location is a 2D array.
	for x in location :
		var vcontainer : VBoxContainer = VBoxContainer.new()
		vcontainer.set("custom_constants/separation", 0)
		call_deferred("add_child", vcontainer)
		for y in x :
			var button : Button = Button.new()
			vcontainer.call_deferred("add_child", button)
			
