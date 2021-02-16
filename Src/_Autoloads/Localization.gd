extends Node

signal locale_changed(new_locale)

# selecting the fallback locale by default
var current_locale = ProjectSettings.get("locale/fallback") setget set_current_locale

func set_current_locale(locale:String) -> void:
	# only notifies if it actually changes because I'm quite paranoïd
	if locale != current_locale:
		emit_signal("locale_changed", locale)
		current_locale = locale
