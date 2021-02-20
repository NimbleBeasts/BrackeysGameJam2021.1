extends Node2D

func _ready():
	# Event Hooks
	Events.connect_signal("play_sound", self, "_playSound")
	Events.connect_signal("switch_music", self, "_switchMusic")
	
	# Init Start Music
	_switchMusic(Global.userConfig.music) 

###############################################################################
# Callbacks
###############################################################################

# Event Hook: Play or stop music
func _switchMusic(val: bool):
	if val:
		$Music.play()
	else:
		$Music.stop()

# Event Hook: Play a sound
func _playSound(sound: String, _volume : float = 1.0, _pos : Vector2 = Vector2(0, 0)):
	if Global.userConfig.sound:
		match sound:
			"menu_click":
				$MenuClick_Neutral.play()
			"menu_click_positive":
				$MenuClick_Positive.play()
			"menu_click_negative":
				$MenuClick_Negative.play()
			"achievement":
				$Achievement.play()
			"daypassing":
				$DayPassing.play()
			"faith_gain":
				$FaithGain.play()
			"faith_lost":
				$FaithLost.play()
			"food_gain":
				$FoodGain.play()
			"food_lost":
				$FoodLost.play()
			"water_gain":
				$WaterGain.play()
			"water_lost":
				$WaterLost.play()
			_:
				print("error: sound not found - name: " + str(sound))

# Music Loop?
func _on_Music_finished():
	$Music.play()
