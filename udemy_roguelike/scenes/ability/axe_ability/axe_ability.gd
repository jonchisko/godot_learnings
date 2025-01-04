extends Node2D


const MAX_RADIUS = 100

@onready var hit_box_component = $HitBoxComponent


var base_rotation = Vector2.RIGHT


# Called when the node enters the scene tree for the first time.
func _ready():
	self.base_rotation = self.base_rotation.rotated(randf_range(0, TAU))
	
	var tween = create_tween()
	tween.tween_method(self.tween_method, 0.0, 2.0, 3)
	tween.tween_callback(self.queue_free)


func tween_method(rotations: float):
	var current_radius = (rotations / 2) * self.MAX_RADIUS
	var current_direction = self.base_rotation.rotated(rotations * TAU)
	
	var root_position = Vector2.ZERO
	var player = self.get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	root_position = player.global_position
	
	self.global_position = root_position + current_direction * current_radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
