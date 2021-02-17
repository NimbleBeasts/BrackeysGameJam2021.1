extends VBoxContainer

signal list_active(node)

var activeOption = null

func _ready():
	signalSetup()


#signal check_toggle(node, checked)
#signal check_active(node)
func signalSetup():
	for option in self.get_children():
		option.connect("check_toggle", self, "_toggleOption")
		option.connect("check_active", self, "_activeOption")


func _toggleOption(node, checked):
	pass
	
func _activeOption(node):
	if activeOption:
		activeOption.setActive(false)
	activeOption = node
	emit_signal("list_active")
