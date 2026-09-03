extends CharacterBody3D

const SPEED = 6.0
const DETECTION_RANGE = 25.0
const ATTACK_RANGE = 8.0
const GRAVITY = 9.8

var player: Node3D
var health = 40
var max_health = 40
var is_attacking = false
var attack_cooldown = 2.0
var last_attack_time = 0.0

var gravity = 9.8
var velocity = Vector3.ZERO

func _ready():
	player = get_tree().root.get_node("Main/Player")

func _physics_process(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player < DETECTION_RANGE:
		var direction = (player.global_position - global_position).normalized()
		
		if distance_to_player > ATTACK_RANGE:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			if get_physics_process_delta_time() + last_attack_time > attack_cooldown:
				attack_player()
				last_attack_time = 0.0
			else:
				last_attack_time += delta
	else:
		velocity.x = 0
		velocity.z = 0
	
	velocity.y -= gravity * delta
	move_and_slide()

func attack_player():
	player.take_damage(15)
	print("Monster attacks! Player HP: ", player.health)

func take_damage(amount):
	health -= amount
	if health <= 0:
		death()

func death():
	queue_free()
