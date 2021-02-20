extends VBoxContainer

signal list_active(node)

const checkOptionScene = preload("res://Src/Ui/Select/CheckOption.tscn")

export(int) var optionsPerPage = 8

var optionsChecked = []

var optionCount = 0
var activeOption = null
var activePage = 0


# Display page 
func displayPage(page = 0):
	activePage = page
	var start = optionsPerPage * page
	for i in range(0, self.get_child_count()):
		if i >= start and i < start + optionsPerPage:
			get_child(i).show()
		else:
			get_child(i).hide()


# Add option return id
func addOption(text, externId, disabled = false) -> int:
	var option = checkOptionScene.instance()
	option.optionText = text
	option.externId = externId
	option.connect("check_toggle", self, "_toggleOption")
	option.connect("check_active", self, "_activeOption")
	option.setDisabled(disabled)
	self.add_child(option)
	optionCount = self.get_child_count() #- 1 # Control Field
	return (optionCount - 1)


# Clear all options
func clear():
	for option in self.get_children():
		option.disconnect("check_toggle", self, "_toggleOption")
		option.disconnect("check_active", self, "_activeOption")
		self.remove_child(option)
		option.queue_free()

func getChecked():
	var list = []
	for entry in optionsChecked:
		list.append(entry.externId)
	return list

func _toggleOption(node, checked):
	if checked:
		optionsChecked.append(node)
	else:
		optionsChecked.remove(optionsChecked.find(node))

	
func _activeOption(node):
	if activeOption:
		activeOption.setActive(false)
	activeOption = node
	emit_signal("list_active", activeOption)
