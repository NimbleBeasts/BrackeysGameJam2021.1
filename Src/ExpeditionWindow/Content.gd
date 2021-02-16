extends Control

func reset():
	pass

func _on_BaseButtonPink_button_up():
	print("button")
	Events.emit_signal(Events.WINDOW_CLOSE, Types.WindowType.Expedition)
