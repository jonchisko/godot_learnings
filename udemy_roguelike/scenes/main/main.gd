extends Node

@export var end_screen_scene: PackedScene
var pause_menu_scene = preload("res://udemy_roguelike/scenes/ui/pause_menu.tscn")


func _ready():
	%player.health_component.died.connect(self._on_player_died)


func _on_player_died():
	var end_screen_instance = self.end_screen_scene.instantiate()
	self.add_child(end_screen_instance)
	end_screen_instance.set_defeat()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.add_child(self.pause_menu_scene.instantiate())
		self.get_tree().root.set_input_as_handled()
