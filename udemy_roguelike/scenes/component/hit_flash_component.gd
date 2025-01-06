extends Node

@export var health_component: Node
@export var sprite: Sprite2D
@export var hit_flash_material: ShaderMaterial

var hit_flash_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	self.health_component.health_changed.connect(self._on_health_changed)
	self.sprite.material = self.hit_flash_material


func _on_health_changed():
	if self.hit_flash_tween != null and self.hit_flash_tween.is_valid():
		self.hit_flash_tween.kill()
		
	(self.sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	self.hit_flash_tween = self.create_tween()
	self.hit_flash_tween.tween_property(self.sprite.material, "shader_parameter/lerp_percent", 0.0, .3)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
