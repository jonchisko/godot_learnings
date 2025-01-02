extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience: float = 0
var current_level = 1
var target_experience = 5

func _ready():
	GameEvents.experience_vial_collected.connect(self._on_experience_vial_collected)

func _increment_experience(number: float):
	self.current_experience = min(self.current_experience + number, self.target_experience)
	self.experience_updated.emit(self.current_experience, self.target_experience)
	if self.current_experience == self.target_experience:
		self.current_level += 1
		self.level_up.emit(self.current_level)
		
		self.target_experience += self.TARGET_EXPERIENCE_GROWTH
		self.current_experience = 0
		self.experience_updated.emit(self.current_experience, self.target_experience)
		
	print(self.current_experience)

func _on_experience_vial_collected(number: float):
	self._increment_experience(number)
