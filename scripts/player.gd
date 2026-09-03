extends CharacterBody3D

const SPEED = 5.0
const MOUSE_SENSITIVITY = 0.003
const SPRINT_SPEED = 8.0
const CROUCH_SPEED = 2.5

var camera: Camera3D
var current_weapon = "shotgun"
var is_sprinting = false
var is_crouching = false
var health = 100
var max_health = 100

# Inventory
var shotgun_ammo = 60
var flamethrower_ammo = 0
var has_flamethrower = false
var flashlight_on = true
var food = 0
var water = 0
var diary_entries = []

var gravity = 9.8

func _ready():
	camera = $Camera3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Sprint
	if Input.is_action_pressed("ui_sprint"):
		is_sprinting = true
		velocity.x = direction.x * SPRINT_SPEED
		velocity.z = direction.z * SPRINT_SPEED
	else:
		is_sprinting = false
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	
	velocity.y -= gravity * delta
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func take_damage(amount):
	health -= amount
	if health <= 0:
		death()

func heal(amount):
	health = min(health + amount, max_health)

func death():
	print("Player died!")
	get_tree().reload_current_scene()

func add_diary_entry(code: String):
	diary_entries.append(code)
	print("Code added to diary: ", code)
