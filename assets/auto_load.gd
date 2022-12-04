extends Node


const colors = [
	Color("#a08a79"), Color("#8b4442"), Color("#35212a"), Color("#9a6b52"),
	Color("#f9e4af"), Color("#809e4f"), Color("#3b404a"), Color("#7aa1a4"),
]

enum mode{
	NORMAL,
	ZEN,
	BOTTLEMINO,
}

var game_mode = mode.NORMAL

var bottle_quantity: int = 9
var bottle_capacity: int = 9
var bottle_initial_level: int = 8

var board_columns: int = 3
