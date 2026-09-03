extends CharacterBody3D

const SPEED = 4.0
const DETECTION_RANGE = 30.0
const ATTACK_RANGE = 15.0
const GRAVITY = 9.8

var player: Node3D
var health = 50
var max_health = 50
var is_attacking = false
var has_code = false
var server_code = ""

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
			attack_player()
		else:
			velocity.x = 0
			velocity.z = 0
	else:
		velocity.x = 0
		velocity.z = 0
	
	velocity.y -= gravity * delta
	move_and_slide()

func attack_player():
	if not is_attacking:
		is_attacking = true
		player.take_damage(10)
		await get_tree().create_timer(1.5).timeout
		is_attacking = false

func take_damage(amount):
	health -= amount
	if health <= 0:
		death()

func death():
	if has_code:
		var code_item = preload("res://scenes/server_code.tscn").instantiate()
		code_item.global_position = global_position
		code_item.code = server_code
		get_parent().add_child(code_item)
	
	queue_free()
