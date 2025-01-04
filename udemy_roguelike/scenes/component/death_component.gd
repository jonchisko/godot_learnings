extends Node2D

@export var health_component: Node
@export var sprite: Sprite2D

func _ready():
	self.health_component.died.connect(self._on_died)
	$GPUParticles2D.texture = self.sprite.texture

	
func _on_died():
	if self.owner == null or not self.owner is Node2D:
		return
	
	var spawn_position = self.owner.global_position
	var enteties = self.get_tree().get_first_node_in_group("enteties_layer")
	self.get_parent().remove_child(self)
	enteties.add_child(self)
	
	self.global_position = spawn_position
	$AnimationPlayer.play("default")
