extends Node

signal experience_vial_collected(number: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damaged

func emit_experience_vial_collected(number: float):
	self.experience_vial_collected.emit(number)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	self.ability_upgrade_added.emit(upgrade, current_upgrades)


func emit_player_damaged():
	self.player_damaged.emit()
