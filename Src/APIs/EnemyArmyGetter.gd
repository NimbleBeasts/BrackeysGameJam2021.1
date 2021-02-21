extends Node
class_name EnemyArmyGetter

var handler : EnemyArmyHandler


func get_days_left() -> int :
	return handler.get_days_left()
