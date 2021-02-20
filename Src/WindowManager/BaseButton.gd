tool
extends TextureButton

export (String) var buttonText = "Text" setget setText

func setText(text):
	$Label.set_text(text)
