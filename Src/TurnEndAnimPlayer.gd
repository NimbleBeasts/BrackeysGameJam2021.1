extends AnimationPlayer

func _ready():
	Events.connect(Events.TURN_ENDED, self, "_turn_ended")
	$Sprite.frame = 0

func _turn_ended():
	play("fadeIn")
	$Label.set_text(TranslationServer.translate("FADE_DAY") + " " + str(0))
	

func _on_TurnEndAnimPlayer_animation_finished(anim_name):
	match anim_name:
		"fadeIn":
			play("turn")
		"turn":
			play("fadeOut")
		"fadeOut":
			Events.emit_signal(Events.TURN_STARTED)
