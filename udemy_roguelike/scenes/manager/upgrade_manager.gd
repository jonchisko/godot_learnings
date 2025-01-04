extends Node


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
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
			self.upgrade_pool = self.upgrade_pool.filter(func (upgrade_element):
				return upgrade_element.id != upgrade.id
			)
	
	
	GameEvents.emit_ability_upgrade_added(upgrade, self.current_upgrades)
	
	print(self.current_upgrades)


func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	var filtered_upgrades = self.upgrade_pool.duplicate()
	for i in 2:
		if filtered_upgrades.is_empty():
			break
		
		var chosen_upgrade = filtered_upgrades.pick_random()
		chosen_upgrades.append(chosen_upgrade)
		filtered_upgrades = filtered_upgrades.filter(func (upgrade):
			return upgrade.id != chosen_upgrade.id
		)
	
	return chosen_upgrades


func _on_upgrade_selected(upgrade: AbilityUpgrade):
	self.apply_upgrade(upgrade)


func _on_leveled_up(current_level: int):
	var upgrade_screen_instance = self.upgrade_screen_scene.instantiate()
	self.add_child(upgrade_screen_instance)
	
	var chosen_upgrades = self.pick_upgrades()
	
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(self._on_upgrade_selected)
