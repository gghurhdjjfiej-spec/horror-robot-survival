extends CharacterBody3D

const SPEED = 3.0
const DETECTION_RANGE = 50.0
const ATTACK_RANGE = 20.0
const GRAVITY = 9.8

var player: Node3D
var health = 200
var max_health = 200
var is_attacking = false
var phase = 1  # 3 phases
var spawn_cooldown = 3.0
var last_spawn_time = 0.0

var gravity = 9.8
var velocity = Vector3.ZERO

func _ready():
	player = get_tree().root.get_node("Main/Player")

func _physics_process(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Update phase based on health
	if health < max_health * 0.66:
		phase = 2
	if health < max_health * 0.33:
		phase = 3
	
	if distance_to_player < DETECTION_RANGE:
		var direction = (player.global_position - global_position).normalized()
		
		if distance_to_player > ATTACK_RANGE:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			attack_patterns()
		
		# Spawn minions in phase 2 and 3
		if phase >= 2 and last_spawn_time > spawn_cooldown:
			spawn_minion()
			last_spawn_time = 0.0
		else:
			last_spawn_time += delta
	else:
		velocity.x = 0
		velocity.z = 0
	
	velocity.y -= gravity * delta
	move_and_slide()

func attack_patterns():
	if not is_attacking:
		is_attacking = true
		
		if phase == 1:
			player.take_damage(20)
		elif phase == 2:
			player.take_damage(30)
		else:
			player.take_damage(40)
		
		await get_tree().create_timer(2.0).timeout
		is_attacking = false

func spawn_minion():
	var minion = preload("res://scenes/ai_robot.tscn").instantiate()
	minion.global_position = global_position + Vector3(randf_range(-5, 5), 0, randf_range(-5, 5))
	get_parent().add_child(minion)

func take_damage(amount):
	health -= amount
	if health <= 0:
		death()

func death():
	print("Boss AI defeated!")
	GameManager.boss_ai_defeated = true
	queue_free()
