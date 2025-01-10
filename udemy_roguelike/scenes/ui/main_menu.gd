extends CanvasLayer

var options_scene = preload("res://udemy_roguelike/scenes/ui/options_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PlayButton.pressed.connect(self._on_play_pressed)
	%OptionsButton.pressed.connect(self._on_options_pressed)
	%QuitButton.pressed.connect(self._on_quit_pressed)


func _on_play_pressed():
	self.get_tree().change_scene_to_file("res://udemy_roguelike/scenes/main/main.tscn")
	

func _on_options_pressed():
	var options_instance = self.options_scene.instantiate()
	self.add_child(options_instance)
	options_instance.back_pressed.connect(self._on_options_closed.bind(options_instance))
	

func _on_quit_pressed():
	self.get_tree().quit()


func _on_options_closed(options_instance: Node):
	options_instance.queue_free()
