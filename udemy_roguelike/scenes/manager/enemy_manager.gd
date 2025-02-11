extends Node

const SPAWN_RADIUS = 150

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0
var enemy_table = WeightedTable.new()

func _ready():
	self.enemy_table.add_item(self.basic_enemy_scene, 10)
	self.base_spawn_time = timer.wait_time
	self.arena_time_manager.arena_difficulty_increased.connect(self._on_arena_difficulty_increased)


func get_spawn_position() -> Vector2:
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return Vector2.ZERO
	
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	for i in 4: # 0, 1, 2, 3	
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		var additional_check_offset = random_direction * 20
		
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + additional_check_offset, 1 << 0)
		var result = self.get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)

		if result.is_empty():
			break
		random_direction = random_direction.rotated(PI/2)
		
	return spawn_position
	

func _on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = 0.1/12 * arena_difficulty
	time_off = min(time_off, 0.7)
	self.timer.wait_time = self.base_spawn_time - time_off
	print("Arena difficulty time off: " + str(time_off))
	
	if arena_difficulty == 6:
		self.enemy_table.add_item(self.wizard_enemy_scene, 20)

func _on_timer_timeout():
	self.timer.start()
	
	var enemy_scene = self.enemy_table.pick_item()
	var enemy = enemy_scene.instantiate()
	var entities_layer = get_tree().get_first_node_in_group("enteties_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = self.get_spawn_position()
	
