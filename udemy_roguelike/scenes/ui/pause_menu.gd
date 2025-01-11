extends CanvasLayer

@onready var panel_container: PanelContainer = %PanelContainer
var options_menu_scene = preload("res://udemy_roguelike/scenes/ui/options_menu.tscn")

var is_closing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.panel_container.pivot_offset = self.panel_container.size/2
	
	self.get_tree().paused = true
	$AnimationPlayer.play("default")
	var tween = self.create_tween()
	tween.tween_property(self.panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(self.panel_container, "scale", Vector2.ONE, .3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	

func close():
	if is_closing:
		return
	
	is_closing = true
	$AnimationPlayer.play_backwards("default")
	var tween = self.create_tween()
	tween.tween_property(self.panel_container, "scale", Vector2.ONE, 0)
	tween.tween_property(self.panel_container, "scale", Vector2.ZERO, .3)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
		
	await tween.finished
	self.get_tree().paused = false
	self.queue_free()


func _on_resume_button_pressed() -> void:
	self.close()


func _on_options_button_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	
	var options_menu_instance = self.options_menu_scene.instantiate()
	self.add_child(options_menu_instance)
	options_menu_instance.back_pressed.connect(self._on_options_back_pressed.bind(options_menu_instance))


func _on_options_back_pressed(options_menu: Node):
	options_menu.queue_free()


func _on_quit_button_pressed() -> void:
	self.get_tree().paused = false
	self.get_tree().change_scene_to_file("res://udemy_roguelike/scenes/ui/main_menu.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.close()
		self.get_tree().root.set_input_as_handled()
