extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@onready var card_container = %CardContainer

@export var upgrade_card_scene: PackedScene


func _ready():
	get_tree().paused = true
	

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	var delay = 0
	for upgrade in upgrades:
		var card_instance = self.upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.play_in(delay)
		card_instance.selected.connect(self._on_upgrade_selected.bind(upgrade))
		delay += .2
		

func _on_upgrade_selected(upgrade: AbilityUpgrade):
	self.upgrade_selected.emit(upgrade)
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()
