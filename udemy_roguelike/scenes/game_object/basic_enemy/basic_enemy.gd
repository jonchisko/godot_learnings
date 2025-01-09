extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.velocity_component.accelerate_to_player()
	self.velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		self.visuals.scale = Vector2(-move_sign, 1)


func _on_hurt_box_component_hit() -> void:
	$HitRandomAudioPlayerComponent.play_random()
