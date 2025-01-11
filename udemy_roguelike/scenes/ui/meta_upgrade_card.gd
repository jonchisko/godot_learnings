extends PanelContainer

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel
@onready var count_label: Label = %CountLabel

var upgrade: MetaUpgrade



func pick_card():
	$AnimationPlayer.play("click")


func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent = currency / self.upgrade.experience_cost
	percent = minf(percent, 1)
	self.progress_bar.value = percent
	self.progress_label.text = str(currency) + "/" + str(self.upgrade.experience_cost)
	
	var quantity = 0
	if MetaProgression.save_data["meta_upgrades"].has(self.upgrade.id):
		quantity = MetaProgression.save_data["meta_upgrades"][self.upgrade.id]["quantity"]
	
	self.count_label.text = "x%d" % quantity
	
	var is_maxed = quantity >= self.upgrade.max_quantity
	if is_maxed:
		self.purchase_button.text = "Maxed"
	self.purchase_button.disabled = percent < 1.0 or is_maxed

func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	self.name_label.text = upgrade.title
	self.description_label.text = upgrade.description
	update_progress()


func _on_purchase_button_pressed() -> void:
	if self.upgrade == null:
		return
	MetaProgression.add_meta_upgrade(self.upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= self.upgrade.experience_cost
	MetaProgression.save()
	self.get_tree().call_group("meta_upgrade_card", "update_progress")
	self.pick_card()
