extends Node

const SPAWN_RADIUS = 370

@export var basic_enemy_scene: PackedScene

@onready var timer = $Timer


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate()
	var entities_layer = get_tree().get_first_node_in_group("enteties_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position