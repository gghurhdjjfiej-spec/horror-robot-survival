extends CanvasLayer

var player: Node3D

func _ready():
	player = get_tree().root.get_node("Main/Player")

func _process(delta):
	$PanelContainer/MarginContainer/HealthLabel.text = "Health: %d/%d" % [player.health, player.max_health]
	$PanelContainer/MarginContainer/AmmoLabel.text = "Ammo: %d" % player.shotgun_ammo
	$InventoryPanel/VBoxContainer/FoodLabel.text = "Food: %d" % player.food
	$InventoryPanel/VBoxContainer/WaterLabel.text = "Water: %d" % player.water
	$InventoryPanel/VBoxContainer/CodesLabel.text = "Codes: %d/6" % len(player.diary_entries)
