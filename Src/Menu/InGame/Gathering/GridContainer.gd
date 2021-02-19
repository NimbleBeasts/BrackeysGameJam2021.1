extends HBoxContainer

var gg : GridGetter = Types.grid_getter


func _ready():
	var grid : Array = gg.get_grid()
	create_grid(grid)

func create_grid(location : Array) -> void :
	#Erase all the spots that are children currently.
	for child in get_children() :
		child.queue_free()
	
	#Location is a 2D array.
	var x_int : int = 0
	for x in location :
		var vcontainer : VBoxContainer = VBoxContainer.new()
		vcontainer.set("custom_constants/separation", 0)
		vcontainer.grow_horizontal = Control.GROW_DIRECTION_BOTH
		vcontainer.grow_vertical = Control.GROW_DIRECTION_BOTH
		vcontainer.alignment = BoxContainer.ALIGN_CENTER
		call_deferred("add_child", vcontainer)
		var y_int : int = 0
		for y in x :
			var spot : GatheringSpot = GatheringSpot.new(Vector2(x_int, y_int), y)
			vcontainer.call_deferred("add_child", spot)
			y_int += 1
		x_int += 1
