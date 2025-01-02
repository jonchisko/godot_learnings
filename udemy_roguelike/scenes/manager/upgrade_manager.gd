extends Node


@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	self.experience_manager.level_up.connect(self._on_leveled_up)
	
	
func _on_leveled_up(current_level: int):
	var chosen_upgrade = self.upgrade_pool.pick_random()
	if chosen_upgrade == null:
		return
	
	var upgrade_screen_instance = self.upgrade_screen_scene.instantiate()
	self.add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(self._on_upgrade_selected)


func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = self.current_upgrades.has(upgrade.id)
	if not has_upgrade:
		self.current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		self.current_upgrades[upgrade.id]["quantity"] += 1
	
	GameEvents.emit_ability_upgrade_added(upgrade, self.current_upgrades)
	
	print(self.current_upgrades)


func _on_upgrade_selected(upgrade: AbilityUpgrade):
	self.apply_upgrade(upgrade)
