extends Node

@export var end_screen_scene: PackedScene

func _ready():
	%player.health_component.died.connect(self._on_player_died)


func _on_player_died():
	var end_screen_instance = self.end_screen_scene.instantiate()
	self.add_child(end_screen_instance)
	end_screen_instance.set_defeat()
