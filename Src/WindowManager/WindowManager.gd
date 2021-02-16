extends Control

var activeWindow = null

func _ready():
	# Connect the childs
	$ExpeditionWindow.connect("focus_window", self, "_focus_window")
	
	# Window Management
	Events.connect(Events.WINDOW_SHOW, self, "showWindow")


func showWindow(type): #Types.WindowType
	match type:
		Types.WindowType.Expedition:
			$ExpeditionWindow.show()
			_focus_window($ExpeditionWindow)
		_:
			print("WindowManager.gd: Unknown window")



func _focus_window(node):
	move_child(node, get_child_count() - 1)
	
	if activeWindow:
		activeWindow.setActive(false)
	
	activeWindow = node
	activeWindow.setActive(true)
