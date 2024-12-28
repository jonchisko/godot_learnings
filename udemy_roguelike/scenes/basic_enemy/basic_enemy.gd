extends CharacterBody2D


const MAX_SPEED = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = self.get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		var vector = player_node.global_position - self.global_position
		var length = vector.length_squared()
		if length < 1:
			return Vector2.ZERO
		return vector.normalized()
	return Vector2.ZERO
	
