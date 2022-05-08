extends Node

var current_volume = 1
var current_song = ""
var music_player
var sound_player

func _ready():
	music_player = AudioStreamPlayer2D.new()
	add_child(music_player)

func set_music(song_name, extension="wav"):
	if(current_song != song_name):
		current_song = song_name
		music_player.stream = load("res://Audio/Songs/%s.%s" % [song_name, extension])
		music_player.play()

func stop_music():
	music_player.stop()
	
func set_music_volume(fraction):
	current_volume = fraction
	music_player.volume_db =	linear2db(fraction)
