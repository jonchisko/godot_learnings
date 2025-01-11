extends Node

const SAVE_FILE_PATH = "user://game.save"

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}

func _ready() -> void:
	GameEvents.experience_vial_collected.connect(self._on_experience_collected)
	self.load_save_file()
	

func load_save_file():
	if not FileAccess.file_exists(self.SAVE_FILE_PATH):
		return
		
	var file = FileAccess.open(self.SAVE_FILE_PATH, FileAccess.READ)
	self.save_data = file.get_var()


func save():
	var file = FileAccess.open(self.SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(self.save_data)


func add_meta_upgrade(upgrade: MetaUpgrade):
	if not self.save_data["meta_upgrades"].has(upgrade.id):
		self.save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}
	
	self.save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	print(self.save_data)
	self.save()


func get_upgrade_count(upgrade_id: String):
	if self.save_data["meta_upgrades"].has(upgrade_id):
		return self.save_data["meta_upgrades"][upgrade_id]["quantity"]
	return 0


func _on_experience_collected(number: float):
	self.save_data["meta_upgrade_currency"] += number
