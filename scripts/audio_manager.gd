extends Node

var audio_cache = {}

func _ready():
	print("Audio Manager initialized")

func play_sound(sound_name: String):
	var audio_player = AudioStreamPlayer3D.new()
	audio_player.bus = "Effects"
	add_child(audio_player)
	print("Playing sound: ", sound_name)
	await get_tree().create_timer(2.0).timeout
	audio_player.queue_free()

func play_music(music_name: String):
	print("Playing music: ", music_name)
