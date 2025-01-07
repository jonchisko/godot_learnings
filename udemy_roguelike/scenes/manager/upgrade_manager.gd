extends Node


@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}
var upgrade_pool: WeightedTable = WeightedTable.new()

var upgrade_axe = preload("res://udemy_roguelike/resources/upgrades/axe.tres")
var upgrade_axe_damage = preload("res://udemy_roguelike/resources/upgrades/axe_damage.tres")
var upgrade_sword_rate = preload("res://udemy_roguelike/resources/upgrades/sword_rate.tres")
var upgrade_sword_damage = preload("res://udemy_roguelike/resources/upgrades/sword_damage.tres")
var player_speed = preload("res://udemy_roguelike/resources/upgrades/player_speed.tres")

func _ready():
	self.upgrade_pool.add_item(self.upgrade_axe, 10)
	self.upgrade_pool.add_item(self.upgrade_sword_rate, 10)
	self.upgrade_pool.add_item(self.upgrade_sword_damage, 10)
	self.upgrade_pool.add_item(self.player_speed, 5)
	
	self.experience_manager.level_up.connect(self._on_leveled_up)
	

func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = self.current_upgrades.has(upgrade.id)
	if not has_upgrade:
		self.current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		self.current_upgrades[upgrade.id]["quantity"] += 1
	
	if upgrade.max_quantity > 0:
		var current_quantity = self.current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			self.upgrade_pool.remove_item(upgrade)
	
	self.update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, self.current_upgrades)
	
	print(self.current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	if chosen_upgrade.id == self.upgrade_axe.id:
		self.upgrade_pool.add_item(self.upgrade_axe_damage, 10)


func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	for i in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		
		var chosen_upgrade = self.upgrade_pool.pick_item(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)
	
	return chosen_upgrades


func _on_upgrade_selected(upgrade: AbilityUpgrade):
	self.apply_upgrade(upgrade)


func _on_leveled_up(current_level: int):
	var upgrade_screen_instance = self.upgrade_screen_scene.instantiate()
	self.add_child(upgrade_screen_instance)
	
	var chosen_upgrades = self.pick_upgrades()
	
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(self._on_upgrade_selected)
