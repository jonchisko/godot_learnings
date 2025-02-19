extends Node
class_name VialDropComponent

@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: HealthComponent
@export var vial_scene: PackedScene


func _ready():
	self.health_component.died.connect(_on_died)
	

func _on_died():
	var adjusted_drop_percent = self.drop_percent
	var experience_gain_upgrade_count = MetaProgression.get_upgrade_count("experience_gain")
	if experience_gain_upgrade_count > 0:
		adjusted_drop_percent += .1 * experience_gain_upgrade_count
	
	if randf() > adjusted_drop_percent:
		return
		
	if self.vial_scene == null:
		return
		
	if not self.owner is Node2D:
		return
		
	var vial = self.vial_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("enteties_layer")
	entities_layer.add_child(vial)
	vial.global_position = self.owner.global_position
	
