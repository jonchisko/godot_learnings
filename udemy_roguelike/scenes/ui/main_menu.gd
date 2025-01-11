extends CanvasLayer

var options_scene = preload("res://udemy_roguelike/scenes/ui/options_menu.tscn")
var meta_scene = preload("res://udemy_roguelike/scenes/ui/meta_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PlayButton.pressed.connect(self._on_play_pressed)
	%OptionsButton.pressed.connect(self._on_options_pressed)
	%QuitButton.pressed.connect(self._on_quit_pressed)


func _on_play_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	
	self.get_tree().change_scene_to_file("res://udemy_roguelike/scenes/main/main.tscn")
	

func _on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	$MarginContainer.visible = false
	
	var options_instance = self.options_scene.instantiate()
	self.add_child(options_instance)
	options_instance.back_pressed.connect(self._on_submenu_closed.bind(options_instance))
	

func _on_quit_pressed():
	self.get_tree().quit()


func _on_submenu_closed(submenu_instance: Node):
	$MarginContainer.visible = true
	submenu_instance.queue_free()


func _on_meta_button_pressed() -> void:
	
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	$MarginContainer.visible = false
	
	var meta_instance = self.meta_scene.instantiate()
	self.add_child(meta_instance)
	meta_instance.back_pressed.connect(self._on_submenu_closed.bind(meta_instance))
