extends TextureButton
class_name GatheringSpot

const PATH : String = "res://Assets/ExpeditionWindow/"
var biome : String = "Standard"

var location_in_grid : Vector2 = Vector2(-1,-1) setget set_location, get_location

#This will determine spot type and thus what texture we use.
var spot_type : int = -1 setget set_spot_type, get_spot_type
var type_name : String = ""

var last_spot : GatheringSpot = null

func _init(location : Vector2 = Vector2(-1,-1), new_spot_type : int = -1) :
	expand = true
	rect_min_size = Vector2( 36,36)
	
	location_in_grid = location
	spot_type = new_spot_type
	#Temporary modulation to show what type we are.
	if spot_type == Types.ExpeditionSpots.LAKES : #LAKE
		texture_normal = load(PATH+biome+"LakeNormal-export.png")
		type_name = "lakes"
	elif spot_type == Types.ExpeditionSpots.HUNTING : #HUNTING
		texture_normal = load(PATH+biome+"HuntNormal-export.png")
		type_name = "hunting"
	elif spot_type == Types.ExpeditionSpots.RUINS : #RUINS
		texture_normal = load(PATH+biome+"RuinsNormal-export.png")
		type_name = "ruins"
	elif spot_type == Types.ExpeditionSpots.BERRIES : #BERRIES
		texture_normal = load(PATH+biome+"BerriesNormal-export.png")
		type_name = "berries"
	elif spot_type == Types.ExpeditionSpots.CREEKS : #Creek :
		texture_normal = load(PATH+biome+"CreekNormal-export.png")
		type_name = "creeks"
	elif spot_type == Types.ExpeditionSpots.HOME_BASE :
		texture_normal = load(PATH+biome+"HomeNormal-export.png")
		disabled = true
	else :
		texture_normal = load(PATH+biome+"RegNormal-export.png")
		disabled = true
	
	
	if new_spot_type == Types.ExpeditionSpots.HOME_BASE :
		Events.emit_signal(Events.GATHER_HOME_CREATED, self)
	
	#Prevent bug from letting us spam one spot.
	Events.connect(Events.GATHER_POINT_ADDED, self, "spot_added")
	Events.connect(Events.GATHER_POINT_REMOVED, self, "spot_added")
	Events.connect(Events.EXPEDITION_CONFIRMED, self, "spot_added")
	
	#Make sure values of the location are correct.
	assert(location_in_grid.x >= 0 && location_in_grid.y >= 0)

#If the player presses me, add one point to the path.
func _pressed() -> void :
	if last_spot == self :
		return
	
	#You are suppose to set the location in the grid for this button.
	assert(location_in_grid != Vector2(-1,-1))
	
	Events.emit_signal(Events.GATHER_POINT_ADDED, self)
	
	#Let the player know where they clicked.
	print("You have clicked [%s] on the Expedition. Spot value of %s" % [str(location_in_grid), str(spot_type)] )

func get_location() -> Vector2 :
	return location_in_grid

func get_reward() -> Dictionary :
	var faith : int = 0
	var food : int = 0
	var water : int = 0
	var val : Dictionary
	if not type_name == "" :
		val = Data.tiles[type_name]
		faith = val["faith"]
		food = val["food"]
		water = val["water"]
	
	var rewards : Dictionary = {
		"faith" : faith,
		"food" : food,
		"water" : water
	}
	return rewards

#Return where the center of the button is in world space.
func get_world_position() -> Vector2 :
	return rect_global_position + (rect_size * 0.5)

func set_location(new_location : Vector2) -> void :
	location_in_grid = new_location

func get_spot_type() -> int :
	return spot_type

func set_spot_type(new_spot_type : int) -> void :
	spot_type = new_spot_type

func spot_added(new_spot : GatheringSpot = null) -> void :
	last_spot = new_spot
