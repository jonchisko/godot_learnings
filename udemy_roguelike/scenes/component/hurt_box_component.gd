extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent


func _ready():
	area_entered.connect(_on_area_entered)
	
	
func _on_area_entered(other: Area2D):
	if not other is HitBoxComponent:
		return
	
	if health_component == null:
		return
		
	var hit_box_component = other as HitBoxComponent
	health_component.damage(hit_box_component.damage)
