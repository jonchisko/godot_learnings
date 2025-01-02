extends PanelContainer

signal selected

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel


func set_ability_upgrade(upgrade: AbilityUpgrade):
	self.name_label.text = upgrade.name
	self.description_label = upgrade.description 


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
