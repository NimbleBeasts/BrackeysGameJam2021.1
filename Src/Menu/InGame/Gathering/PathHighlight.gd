extends Control


#I don't know how much data I need to highlight the path yet.

var points : Array = []

func _draw():
	#For each spot in points, draw a line to it.
	#Also draw a circle at each spot.
	var i : int = 0
	while i < points.size() :
		var spot : GatheringSpot = points[i]
		
		draw_circle(spot.get_world_position(), 3, Color(0,1,0))
		
		if i + 1 < points.size() :
			draw_line(spot.get_world_position(), points[i+1].get_world_position(), Color(0,1,0), 2, true)
		
		i += 1

func _ready():
	Events.connect(Events.GATHER_POINT_ADDED, self, "add_point")
	update()

func add_point(spot : GatheringSpot) -> void :
	points.append(spot)
	update()
