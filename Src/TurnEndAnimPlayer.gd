extends AnimationPlayer

func _ready():
	Events.connect(Events.TURN_ENDED, self, "_turn_ended")
	$Sprite.frame = 0

func _turn_ended():
	get_parent().gameState.turn += 1
	Events.emit_signal("play_sound", "daypassing")
	play("fadeIn")
	$Label.set_text(TranslationServer.translate("FADE_DAY") + " " + str(get_parent().gameState.turn))
	

func _on_TurnEndAnimPlayer_animation_finished(anim_name):
	match anim_name:
		"fadeIn":
			play("turn")
		"turn":
			play("fadeOut")
			Events.emit_signal(Events.TURN_ANIMATED)
			Events.emit_signal(Events.TURN_STARTED)
		"fadeOut":
			pass
