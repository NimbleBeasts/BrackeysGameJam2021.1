extends Control


func reset():
	pass

func _ready():
	pass # Replace with function body.

func setup(id):
	$TitleLabel.set_text("Event " + str(id))
