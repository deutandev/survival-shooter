extends Node
class_name UpgradeManager


# UpgradeManager.gd
func apply_upgrade(upgrade: UpgradeData, target: Node):  # ✅ FIXED
	var stat_name = upgrade.stat_name
	var amount = upgrade.amount

	var current = target.get_stat(stat_name)
	if current == null:
		print("⚠️ Stat not found:", stat_name)
		return

	match upgrade.upgrade_type:
		UpgradeData.UpgradeType.ADD:
			target.set_stat(stat_name, current + amount)
		UpgradeData.UpgradeType.MULTIPLY:
			target.set_stat(stat_name, current * (1.0 + amount / 100.0))

	print("✅ Applied upgrade:", stat_name, "→", target.get_stat(stat_name))
