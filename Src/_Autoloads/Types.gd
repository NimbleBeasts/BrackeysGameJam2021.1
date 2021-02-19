extends Node

enum Direction { Top, Right, Down, Left }
enum GameStates {Menu, Game, Settings} 

enum WindowType {Expedition = 0, Event = 1, Char = 2}

enum EventTypes {Expedition, Gameplay, TurnRandom}

enum CharEventType {Expedition, Sacrifice}

enum UnitTypes {
	Swordsman,
	Chieftan,
	Philosopher,
	Farmer,
	Oracle,
	Traveller,
	Merchant,
	Hussard,
	Priest
}

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
