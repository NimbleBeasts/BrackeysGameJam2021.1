tool
extends TextureButton

export (String) var buttonText = "Text" setget setText

func _ready():
	setText(buttonText)

func setText(text):
	$Label.set_text(text)
