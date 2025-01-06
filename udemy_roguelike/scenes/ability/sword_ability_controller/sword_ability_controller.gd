extends Node

const MAX_RANGE = 150

@export var sword_ability: PackedScene 
var base_wait_time
var base_damage = 5
var aditional_damage_percent = 1

func _ready():
	self.base_wait_time = $Timer.wait_time
	GameEvents.ability_upgrade_added.connect(self._on_ability_upgrade_added)


func _on_timer_timeout():
	print("Activate ability")
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return
	
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(self.MAX_RANGE, 2)
	)
	
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		a.global_position.distance_squared_to(player.global_position) < b.global_position.distance_squared_to(player.global_position)	
	)
	
	var sword_instance = self.sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hit_box_component.damage = self.base_damage * self.aditional_damage_percent
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position +=  Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = enemies[0].global_position - sword_instance.global_position 
	sword_instance.rotation = enemy_direction.angle()


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "sword_rate":
		var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
		$Timer.wait_time = self.base_wait_time * (1 - percent_reduction)
		$Timer.start()
		print("Sword timer attack: " + str($Timer.wait_time))
	elif upgrade.id == "sword_damage":
		self.aditional_damage_percent += current_upgrades["sword_damage"]["quantity"] * .15
