tool
extends TextureButton

export (String) var buttonText = "Text"


func _pressed() -> void :
	Events.emit_signal(Events.EXPEDITION_CONFIRMED)

func _ready():
	$Label.set_text(buttonText)
