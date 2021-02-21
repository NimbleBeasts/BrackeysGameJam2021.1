extends Control

var gg : GridGetter = Types.grid_getter

#I don't know how much data I need to highlight the path yet.

var points : Array = []

func _draw():
	#For each spot in points, draw a line to it.
	#Also draw a circle at each spot.
	var i : int = 0
	while i < points.size() :
		var spot : GatheringSpot = points[i]
		
		if i != 0 :
			draw_circle(spot.get_world_position(), 3, Color(0,1,0))
		
		if i + 1 < points.size() :
			draw_line(spot.get_world_position(), points[i+1].get_world_position(), Color(0,1,0), 2, true)
		
		i += 1

func _ready():
	if not Events.is_connected(Events.GATHER_POINT_ADDED, self, "add_point") :
		Events.connect(Events.GATHER_HOME_CREATED, self, "add_point")
		Events.connect(Events.GATHER_POINT_ADDED, self, "add_point")
		Events.connect(Events.EXPEDITION_AFTER_CONFIRMED, self, "clear")
		Events.connect(Events.EXPEDITION_PLANNED, self, "hide")
		Events.connect(Events.EXPEDITION_BACKED, self, "show")
		Events.connect(Events.GATHER_POINT_REMOVED, self, "remove_point")
		Events.connect(Events.EXPEDITION_CANCELLED, self, "clear")
		
		update()

func add_point(spot : GatheringSpot) -> void :
	points.append(spot)
	update()

func clear() -> void :
	show()
	var spot = points[0]
	points.clear()
	points.append(spot)
	update()

func remove_point() -> void :
	#Do nothing if we are at the first point.
	if points.size() <= 1 :
		return
	
	points.pop_back()
	update()
