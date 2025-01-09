extends CharacterBody2D

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent


var number_colliding_bodies = 0
var base_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.base_speed = self.velocity_component.max_speed
	GameEvents.ability_upgrade_added.connect(self._on_ability_upgrade_added)
	self.update_health_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_vector = self.get_movement_vector()
	var direction = movement_vector.normalized()
	self.velocity_component.accelerate_in_direction(direction)
	self.velocity_component.move(self)
	
	if movement_vector.x != 0 or movement_vector.y != 0:
		self.animation_player.play("walk")
	else:
		self.animation_player.play("RESET")
	
	var move_sign = sign(movement_vector.x)
	if move_sign != 0:
		self.visuals.scale = Vector2(move_sign, 1)
	

func get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)

func check_deal_damage():
	if self.number_colliding_bodies == 0 or not damage_interval_timer.is_stopped():
		return
	self.health_component.damage(1)
	self.damage_interval_timer.start()
	print("Health: " + str(self.health_component.current_health))
	
	
func update_health_display():
	self.health_bar.value = self.health_component.get_health_percent()
	
	
func _on_collision_area_2d_body_entered(body):
	self.number_colliding_bodies += 1
	self.check_deal_damage()


func _on_collision_area_2d_body_exited(body):
	self.number_colliding_bodies -= 1


func _on_damage_interval_timer_timeout():
	self.check_deal_damage()


func _on_health_component_health_changed():
	self.update_health_display()
	$HitrandomStreamPlayer.play_random()
	GameEvents.emit_player_damaged()
	

func _on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if ability_upgrade is Ability:
		var ability_instance = (ability_upgrade as Ability).ability_controller_scene.instantiate()
		self.abilities.add_child(ability_instance)
	elif ability_upgrade.id == "player_speed":
		self.velocity_component.max_speed = self.base_speed + (self.base_speed * current_upgrades["player_speed"]["quantity"] * .1)
		
