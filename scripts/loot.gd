extends Area3D

var item_type = "food"  # food, water, ammo, code
var item_amount = 10
var server_code = ""

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	if area.name == "PlayerCollider":
		var player = get_tree().root.get_node("Main/Player")
		
		match item_type:
			"food":
				player.food += item_amount
			"water":
				player.water += item_amount
			"ammo_shotgun":
				player.shotgun_ammo += item_amount
			"ammo_flamethrower":
				player.flamethrower_ammo += item_amount
			"flamethrower":
				player.has_flamethrower = true
				print("Flamethrower acquired!")
			"code":
				player.add_diary_entry(server_code)
		
		print("Collected: ", item_type, " x", item_amount)
		queue_free()
