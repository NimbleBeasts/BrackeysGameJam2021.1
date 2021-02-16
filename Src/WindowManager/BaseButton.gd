tool
extends TextureButton

export (String) var buttonText = "Text"


func _ready():
	$Label.set_text(buttonText)


