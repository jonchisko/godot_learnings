extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(_on_area_entered)
	
	
func tween_collect(percent: float, start_position: Vector2):
	var player = self.get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	self.global_position = start_position.lerp(player.global_position, percent)
	var direction_from_start = player.global_position - start_position
	
	var target_rotation = direction_from_start.angle() + PI/2
	self.rotation = lerp_angle(self.rotation, target_rotation, 1 - exp(-get_process_delta_time()))
	
	
func collect():
	GameEvents.emit_experience_vial_collected(1)
	queue_free()
	
	
func disable_collision():
	self.collision_shape_2d.disabled = true
	
func _on_area_entered(other: Area2D) -> void:
	self.disable_collision.call_deferred()
	
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(self.tween_collect.bind(self.global_position), 0.0, 1.0, 0.7)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ZERO, .25).set_delay(0.45)
	tween.chain()
	tween.tween_callback(collect)
	
	$RandomStreamPlayer2DComponent.play_random()
