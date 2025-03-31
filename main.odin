package main

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"
import "third parties/odin-tiled-main/tiled"


main :: proc()
{
	
	game.name = "Dungeon Delver"
	game.width = 640
	game.height = 480

	entities = make_entity_array(1000)

	rl.InitWindow(game.width, game.height, strings.unsafe_string_to_cstring(game.name))
	rl.SetTargetFPS(60)
	//Load Menu
	load_menu()
	//We can start to populate GPU ram with Textures
	load_frame_textures(menu.frames)
	//Load Sounds
	rl.InitAudioDevice()
	load_jukebox()
	load_music(1)
	//Load Menu Stuff
	load_menu_buttons()
	level_one = parse_tilemap("sources/test_level_two.tmj")
	tiles = rl.LoadTexture("sources/cable.png")
	make_world(level_one, tiles)

	for (!rl.WindowShouldClose())
	{
		rl.BeginDrawing()
			rl.ClearBackground(rl.BLACK)
			
			play_music(1)

			if (state == GameState.menu)
			{
				main_menu()
			} else
			{
				draw_map(level_one, tiles)
			}
			

		rl.EndDrawing()
	}
	//Close Things
	rl.CloseWindow()
	rl.CloseAudioDevice()
}