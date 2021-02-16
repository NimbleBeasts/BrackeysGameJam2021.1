extends Control

var activeWindow = null

func _ready():
	# Connect the childs
	$ExpeditionWindow.connect("focus_window", self, "_focus_window")
	
	# Window Management
	Events.connect(Events.WINDOW_SHOW, self, "showWindow")
	Events.connect(Events.WINDOW_CLOSE, self, "closeWindow")

func showWindow(type): #Types.WindowType
	match type:
		Types.WindowType.Expedition:
			print("show")
			$ExpeditionWindow.show()
			_focus_window($ExpeditionWindow)
		_:
			print("WindowManager.gd: Unknown window")

func closeWindow(type): #Types.WindowType
	match type:
		Types.WindowType.Expedition:
			print("hide")
			$ExpeditionWindow.reset()
			$ExpeditionWindow.hide()
		_:
			print("WindowManager.gd: Unknown window")
			
		#TODO: focus next visible window


func _focus_window(node):
	move_child(node, get_child_count() - 1)
	
	if activeWindow:
		activeWindow.setActive(false)
	
	activeWindow = node
	activeWindow.setActive(true)
