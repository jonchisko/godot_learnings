extends PanelContainer

signal selected

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel

var disabled = false

func play_in(delay: float = 0):
	self.modulate = Color.TRANSPARENT
	await self.get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")


func play_discard():
	$AnimationPlayer.play("discard")


func pick_card():
	disabled = true
	$AnimationPlayer.play("click")
	
	for other_card in self.get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_discard()
	
	await $AnimationPlayer.animation_finished
	selected.emit()	


func set_ability_upgrade(upgrade: AbilityUpgrade):
	self.name_label.text = upgrade.name
	self.description_label.text = upgrade.description 


func _on_gui_input(event: InputEvent):
	if disabled:
		return
	
	if event.is_action_pressed("left_click"):
		self.pick_card()


func _on_mouse_entered():
	if disabled:
		return
	$AnimationHover.play("hover")
