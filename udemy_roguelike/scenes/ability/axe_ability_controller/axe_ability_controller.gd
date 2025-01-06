extends Node

@onready var timer = $Timer

@export var axe_ability_scene: PackedScene

var base_damage = 10
var aditional_damage_percent = 1

func _ready():
	GameEvents.ability_upgrade_added.connect(self._on_ability_upgrade_added)


func _on_timer_timeout():
	var player = self.get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var foreground = self.get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground == null:
		return
		
	var axe_instance = axe_ability_scene.instantiate() as Node2D
	foreground.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	
	axe_instance.hit_box_component.damage = self.base_damage * self.aditional_damage_percent
	
	
func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "axe_damage":
		self.aditional_damage_percent += current_upgrades["axe_damage"]["quantity"] * .1
