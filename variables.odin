package main

import rl "vendor:raylib"
import "third parties/odin-tiled-main/tiled"

EntityTypes :: enum {
	et_default,
	et_wall,
	et_background,
	et_liquid,
	et_player,
	et_penguin_soldier,
	et_penguin_prince,
	et_slime,
	et_eye_monster,
	et_ooze,
	et_coyote_nick,
	et_marmoset,
	et_hedgehog,
	et_fairy,
	et_lil_pengu,
	et_mayor_snoresly,
	et_pengu_puller,
	et_lever,
	et_gate,
	et_door,
	et_fire,
	et_hook,
	et_ladder,
}

PlayerStates :: enum {
	NEUTRAL,
	MOVE,
	TALKING,
}

GameState :: enum {
	menu,
	level_one,
}

//Hawaii sort this shit out
game: Game
entities: EntityArray
World: LevelArray
menu: Menu
jukey: Jukebox
menu_buttons: ButtonList
offset: Vector2i
level_one: Map
tiles: rl.Texture
state := GameState.menu
scale: f32
player: Entity
