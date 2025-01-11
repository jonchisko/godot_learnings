extends CanvasLayer

signal back_pressed

@onready var grid_container: GridContainer = %GridContainer

@export var upgrades: Array[MetaUpgrade] = []
var meta_upgrade_card_scene = preload("res://udemy_roguelike/scenes/ui/meta_upgrade_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade in self.upgrades:
		var meta_upgrade_card_instance = self.meta_upgrade_card_scene.instantiate()
		self.grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)


func _on_sound_button_pressed() -> void:
	self.back_pressed.emit()
