extends Node

var boss_ai_defeated = false
var boss_monster_defeated = false
var game_over = false
var victory = false

func _ready():
	print("Game Manager initialized")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func show_victory():
	victory = true
	print("\n=== VICTORY ===")
	print("You freed all the slaves!")
	print("Game will restart in 5 seconds...")
	await get_tree().create_timer(5.0).timeout
	get_tree().reload_current_scene()
