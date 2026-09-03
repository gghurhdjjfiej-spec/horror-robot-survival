extends Node3D

var player: Node3D
var is_reloading = false
var fire_rate = 0.3
var last_shot_time = 0.0

func _ready():
	player = get_parent().get_parent()

func _process(delta):
	last_shot_time += delta
	
	if Input.is_action_pressed("ui_shoot") and last_shot_time > fire_rate:
		fire_weapon()
		last_shot_time = 0.0

func fire_weapon():
	if player.current_weapon == "shotgun":
		if player.shotgun_ammo >= 2:
			player.shotgun_ammo -= 2
			print("Shotgun fired! Ammo: ", player.shotgun_ammo)
			AudioManager.play_sound("shotgun_fire")
			shoot_raycast()
		elif player.current_weapon == "flamethrower":
		if player.has_flamethrower and player.flamethrower_ammo > 0:
			player.flamethrower_ammo -= 1
			print("Flamethrower fired! Ammo: ", player.flamethrower_ammo)
			AudioManager.play_sound("flamethrower_fire")
			shoot_raycast()

func shoot_raycast():
	var camera = player.camera
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(camera.global_position, camera.global_position + camera.global_transform.basis.z * -100)
	var result = space_state.intersect_ray(query)
	
	if result:
		var collider = result.collider
		if collider.is_in_group("enemy"):
			if player.current_weapon == "shotgun":
				collider.take_damage(30)
			elif player.current_weapon == "flamethrower":
				collider.take_damage(50)
			print("Hit! Enemy HP: ", collider.health)
