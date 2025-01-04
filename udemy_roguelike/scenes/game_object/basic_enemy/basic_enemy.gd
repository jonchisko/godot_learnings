extends CharacterBody2D

const MAX_SPEED = 50

@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = self.get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		self.visuals.scale = Vector2(-move_sign, 1)


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		var vector = player_node.global_position - self.global_position
		var length = vector.length_squared()
		if length < 1:
			return Vector2.ZERO
		return vector.normalized()
	return Vector2.ZERO
