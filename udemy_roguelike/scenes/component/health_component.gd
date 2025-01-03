extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10.0
var current_health: float

func _ready():
	self.current_health = self.max_health

func damage(damage_amount: float):
	self.current_health = max(self.current_health - damage_amount, 0)
	self.health_changed.emit()
	self._check_death.call_deferred()


func get_health_percent():
	if self.max_health <= 0:
		return 0
	return min(self.current_health / self.max_health, 1)


func _check_death():
	if self.current_health == 0:
		self.died.emit()
		self.owner.queue_free()
