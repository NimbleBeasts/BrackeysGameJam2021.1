extends Node2D

const music = [
	preload("res://Assets/Audio/music/enemy_approaching_final.ogg"),
	preload("res://Assets/Audio/music/hud2_final.ogg"),
	preload("res://Assets/Audio/music/hud3_final.ogg"),
	preload("res://Assets/Audio/music/hud4_final_.ogg"),
]

const titleMusic = preload("res://Assets/Audio/music/title_final.ogg")
const gameOverMusic = preload("res://Assets/Audio/music/game_over_final.ogg")


func _ready():
	# Event Hooks
	Events.connect_signal("play_sound", self, "_playSound")
	Events.connect_signal("switch_music", self, "_switchMusic")
	
	Events.connect_signal("turn_started", self, "nextTrack")
	Events.connect_signal("music_play_title_song", self, "titleSong")
	Events.connect("game_lost", self, "gameOverMusic")
	
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

func nextTrack():
	$Music/AnimationPlayer.play("switchTrack")

func switchTrackCallback():
	$Music.stream = music[randi() % music.size()]
	print($Music.stream)

func titleSong():
	$Music.stream = titleMusic

func gameOverMusic(_d):
	$Music.stream = gameOverMusic
