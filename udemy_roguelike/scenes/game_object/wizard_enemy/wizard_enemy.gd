extends CharacterBody2D


@onready var velocity_component = $VelocityComponent
@onready var visuals = $Visuals


var is_moving = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.is_moving:
		self.velocity_component.accelerate_to_player()
	else:
		self.velocity_component.decelerate()
		
	self.velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		self.visuals.scale = Vector2(move_sign, 1)


func set_is_moving(moving: bool):
	self.is_moving = moving
