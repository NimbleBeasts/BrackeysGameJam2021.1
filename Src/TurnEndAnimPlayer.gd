extends AnimationPlayer

func _ready():
	Events.connect(Events.TURN_ENDED, self, "_turn_ended")
	Events.connect("game_lost", self, "_game_over")
	$Sprite.frame = 0
	#$Sub.hide()
	#$ClickBlock.hide()

func _turn_ended():
	$ClickBlock.show()
	get_parent().gameState.turn += 1
	Events.emit_signal("play_sound", "daypassing")
	play("fadeIn")
	$Label.set_text(TranslationServer.translate("FADE_DAY") + " " + str(get_parent().gameState.turn))

func _game_over(reason=""):
	$ClickBlock.show()
	$Sub.show()
	$Label.set_text(TranslationServer.translate("GAME_OVER"))
	match reason:
		Types.GameOverType.Faith:
			$Sub.set_text(TranslationServer.translate("GAME_OVER_FAITH"))
		Types.GameOverType.Water:
			$Sub.set_text(TranslationServer.translate("GAME_OVER_WATER"))
		Types.GameOverType.Food:
			$Sub.set_text(TranslationServer.translate("GAME_OVER_FOOD"))
		_:
			$Sub.set_text(TranslationServer.translate("GAME_OVER_UNITS"))
	
	play("fadeIn")

func _on_TurnEndAnimPlayer_animation_finished(anim_name):
	match anim_name:
		"fadeIn":
			if $Sub.visible:
				play("gameover")
			else:
				play("turn")
		"turn":
			play("fadeOut")
			Events.emit_signal(Events.TURN_ANIMATED)
			Events.emit_signal(Events.TURN_STARTED)
		"fadeOut":
			pass
