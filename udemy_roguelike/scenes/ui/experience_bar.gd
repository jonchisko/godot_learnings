extends CanvasLayer

@export var experience_manager: Node
@onready var progress_bar = %ProgressBar

func _ready():
	progress_bar.value = 0
	self.experience_manager.experience_updated.connect(self._on_experience_updated)


func _on_experience_updated(current_experience: float, target_experience: float):
	progress_bar.value = current_experience / target_experience
