tool
extends Control

signal check_toggle(node, checked)
signal check_active(node)

export (String) var optionText = "Text"

# Disable checkbox
var disabled = false setget setDisabled
# Is the option checked
var checked = false
# Is the option active - e.g. display char
var active = false

func _ready():
	$Label.set_text(optionText)
	setDisabled(disabled)


func setDisabled(val = true):
	disabled = val
	if disabled:
		$CheckBoxSprite.frame = 4
	else:
		$CheckBoxSprite.frame = 0


func setActive(val = true):
	active = val
	if active:
		$Background.frame = 2
		emit_signal("check_active", self)
	else:
		if checked:
			$Background.frame = 1
		else:
			$Background.frame = 0


func setChecked(val = true):
	checked = val
	emit_signal("check_toggle", self, checked)
	if checked:
		setActive()


func _on_MouseDetector_mouse_entered():
	$Background.frame = 2


func _on_MouseDetector_mouse_exited():
	if active:
		$Background.frame = 2
	elif checked:
		$Background.frame = 1
	else:
		$Background.frame = 0


func _on_MouseDetector_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			setActive()


func _on_CheckBox_mouse_entered():
	$CheckBoxSprite.frame = 2
	_on_MouseDetector_mouse_entered()


func _on_CheckBox_mouse_exited():
	if checked:
		$CheckBoxSprite.frame = 1
	elif disabled:
		$CheckBoxSprite.frame = 4
	else:
		$CheckBoxSprite.frame = 0
	_on_MouseDetector_mouse_exited()


func _on_CheckBox_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			setChecked(!checked)

