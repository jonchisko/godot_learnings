extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent

var floating_text_scene = preload("res://udemy_roguelike/scenes/ui/floating_text.tscn")

func _ready():
	area_entered.connect(_on_area_entered)
	
	
func _on_area_entered(other: Area2D):
	if not other is HitBoxComponent:
		return
	
	if health_component == null:
		return
		
	var hit_box_component = other as HitBoxComponent
	health_component.damage(hit_box_component.damage)
	
	var floating_text = self.floating_text_scene.instantiate() as Node2D
	self.get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	
	floating_text.global_position = self.global_position + Vector2.UP * 12
	
	var format_string = "%0.1f"
	if round(hit_box_component.damage) == hit_box_component.damage:
		format_string = "%0.0f"
	floating_text.start(format_string % hit_box_component.damage)
