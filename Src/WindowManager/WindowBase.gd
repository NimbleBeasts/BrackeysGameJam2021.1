extends Control
class_name WindowBase

signal focus_window

const inactiveColor = Color("60717e")
const activeColor = Color("658ba7")

var windowActive = false
var dragPosition = null

func _ready():
	$Label.set_text(name)
	get_parent().registerWindow(self)

func setActive(value):
	windowActive = value
	if value:
		$DummyBg.color = activeColor
	else:
		$DummyBg.color = inactiveColor

func focusWindow():
	emit_signal("focus_window", self)

func _on_WindowBase_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			focusWindow()

func _on_Titlebar_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			dragPosition = get_global_mouse_position() - rect_global_position
			focusWindow()
		else:
			dragPosition = null
	if event is InputEventMouseMotion:
		if dragPosition:
			rect_global_position = get_global_mouse_position() - dragPosition
