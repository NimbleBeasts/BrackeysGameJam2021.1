extends Control
class_name WindowBase

signal focus_window

export(Types.WindowType) var windowType = Types.WindowType.Expedition

const ninePatchTextures = [
	preload("res://Assets/Ui/Window9Patch_3x.png"),
	preload("res://Assets/Ui/Window9Patch_inactive_3x.png"),
	]

var windowActive = false
var dragPosition = null
onready var content = $Content

func _ready():
	$TitleBar/Label.set_text(name)
	#get_parent().registerWindow(self) 

func reset():
	content.reset()

func setActive(value = true):
	windowActive = value
	if value:
		$Bg.texture = ninePatchTextures[0]
	else:
		$Bg.texture = ninePatchTextures[1]

func focusWindow():
	emit_signal("focus_window", self)

func _on_WindowBase_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			focusWindow()

func _on_Titlebar_gui_input(event):
	#TODO: check if window is within the viewport rect + safety margin
	if event is InputEventMouseButton:
		if event.pressed:
			dragPosition = get_global_mouse_position() - rect_global_position
			focusWindow()
		else:
			dragPosition = null
	if event is InputEventMouseMotion:
		if dragPosition:
			rect_global_position = get_global_mouse_position() - dragPosition
