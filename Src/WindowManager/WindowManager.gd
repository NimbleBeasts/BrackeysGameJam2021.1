extends Control

var activeWindow = null

func registerWindow(node):
	node.connect("focus_window", self, "_focus_window")
	
func _focus_window(node):
	move_child(node, get_child_count() - 1)
	
	if activeWindow:
		activeWindow.setActive(false)
	
	activeWindow = node
	activeWindow.setActive(true)
