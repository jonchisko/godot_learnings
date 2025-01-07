extends CanvasLayer

@onready var end_screen_title = %EndScreenTitle
@onready var end_screen_description = %EndScreenDescription
@onready var panel_container = %PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.panel_container.pivot_offset = self.panel_container.size / 2
	var tween = self.create_tween()
	tween.tween_property(self.panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(self.panel_container, "scale", Vector2.ONE, .3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	get_tree().paused = true


func set_defeat():
	self.end_screen_title.text = "Defeat"
	self.end_screen_description.text = "You lost!"
	

func set_victory():
	self.end_screen_title.text = "Victory"
	self.end_screen_description.text = "You won!"


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://udemy_roguelike/scenes/main/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
