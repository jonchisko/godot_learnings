extends CharacterBody2D

@onready var damage_interval_timer = $DamageIntervalTimer

const MAX_SPEED = 150
const ACCELERATION_SMOOTHING = 25

var number_colliding_bodies = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_vector = self.get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	move_and_slide()
	

func get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)

func check_deal_damage():
	if self.number_colliding_bodies == 0 or not damage_interval_timer.is_stopped():
		return
	$HealthComponent.damage(1)
	damage_interval_timer.start()
	print("Health: " + str($HealthComponent.current_healthad))
	
	
func _on_collision_area_2d_body_entered(body):
	self.number_colliding_bodies += 1
	self.check_deal_damage()


func _on_collision_area_2d_body_exited(body):
	self.number_colliding_bodies -= 1


func _on_damage_interval_timer_timeout():
	self.check_deal_damage()
