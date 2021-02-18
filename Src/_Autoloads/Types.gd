extends Node

enum Direction { Top, Right, Down, Left }
enum GameStates {Menu, Game, Settings} 

enum WindowType {Expedition} #TODO: maybe outdated

enum EventTypes {GameplayEvent, TurnRandom}


enum ExpeditionSpots  {
	LAKES = 0,
	HUNTING = 1,
	RUINS = 2,
	BERRIES = 3,
	CREEKS = 4,
	NORMAL = 5
}

enum ResourceType {Water = 0, Food, Faith}

var unit_getter : UnitGetter = UnitGetter.new()
var resources_getter : ResourcesGetter = ResourcesGetter.new()
