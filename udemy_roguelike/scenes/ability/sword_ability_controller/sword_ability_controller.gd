extends Node

@export var sword_ability: PackedScene 


func _on_timer_timeout():
	print("Activate ability")
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var sword_instance = self.sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = player.global_position
