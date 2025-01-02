extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10.0
var current_health: float

func _ready():
	self.current_health = self.max_health

func damage(damage_amount: float):
	self.current_health = max(self.current_health - damage_amount, 0)
	self._check_death.call_deferred()


func _check_death():
	if self.current_health == 0:
		self.died.emit()
		self.owner.queue_free()
