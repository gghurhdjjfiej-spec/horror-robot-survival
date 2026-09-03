extends CharacterBody3D

const SPEED = 5.0
const DETECTION_RANGE = 40.0
const ATTACK_RANGE = 10.0
const GRAVITY = 9.8

var player: Node3D
var health = 150
var max_health = 150
var is_attacking = false
var phase = 1
var poison_gas_cooldown = 4.0
var last_gas_time = 0.0

var gravity = 9.8
var velocity = Vector3.ZERO

func _ready():
	player = get_tree().root.get_node("Main/Player")

func _physics_process(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Update phase
	if health < max_health * 0.5:
		phase = 2
	
	if distance_to_player < DETECTION_RANGE:
		var direction = (player.global_position - global_position).normalized()
		
		if distance_to_player > ATTACK_RANGE:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			attack_patterns()
		
		# Poison gas attack
		if last_gas_time > poison_gas_cooldown:
			release_poison_gas()
			last_gas_time = 0.0
		else:
			last_gas_time += delta
	else:
		velocity.x = 0
		velocity.z = 0
	
	velocity.y -= gravity * delta
	move_and_slide()

func attack_patterns():
	if not is_attacking:
		is_attacking = true
		
		if phase == 1:
			player.take_damage(25)
		else:
			player.take_damage(35)
		
		await get_tree().create_timer(1.5).timeout
		is_attacking = false

func release_poison_gas():
	print("Monster releases poison gas!")
	player.take_damage(10)

func take_damage(amount):
	health -= amount
	if health <= 0:
		death()

func death():
	print("Boss Monster defeated!")
	GameManager.boss_monster_defeated = True
	GameManager.show_victory()
	queue_free()
