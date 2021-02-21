extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var count : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect(Events.TURN_ANIMATED, self, "inc")

func inc() -> void :
	count += 1
	text = "Turn: " + str(count)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
