package main

import "core:fmt"
import rl "vendor:raylib"
import "core:strings"


make_levels :: proc()
{
    World = make_level_array(10)

    World.data[0].entities = make_world(level_one, tiles)
    World.count+=1
}

make_world :: proc(t_map: Map, texture: rl.Texture) -> EntityArray
{
	tile_width: i32 = 16
    tile_height: i32 = 16

    ents: EntityArray = make_entity_array(1000)

    for layer in t_map.layers {
        for y in 0..<layer.height {
            for x in 0..<layer.width {
                gid := layer.data[y * layer.width + x]
                if gid == 0 {
                    continue
                }

                tile_x := i32(gid - 1) % (texture.width / tile_width)
                tile_y := i32(gid - 1) / (texture.width / tile_height)

                src_rect := rl.Rectangle{
                    x = f32(tile_x * tile_width),
                    y = f32(tile_y * tile_height),
                    width = f32(tile_width),
                    height = f32(tile_height),
                }

                dst_rect := rl.Rectangle{
                    x = f32(x * tile_width) + cast(f32)offset.x,
                    y = f32(y * tile_height) + cast(f32)offset.y,
                    width = f32(tile_width),
                    height = f32(tile_height),
                }

                ents.data[ents.count].img_src = src_rect
                ents.data[ents.count].img_dest = dst_rect

                ents.count+=1
            }
        }
    }

    return ents
}

draw_world :: proc()
{

}

main_menu :: proc()
{
	draw_frame_animation(menu.frames, &menu.animation, v2(0, 0))
	for i: i32 = 0; i < menu_buttons.count; i+=1
	{
		color: rl.Color

		if (check_button(i, menu_buttons))
		{
			color = rl.YELLOW

			if (rl.IsMouseButtonPressed(rl.MouseButton.LEFT))
			{
				state = GameState.level_one
			}
		} else
		{
			color = rl.RAYWHITE
		}

		rl.DrawText(strings.unsafe_string_to_cstring(menu_buttons.data[i].text),
			menu_buttons.data[i].rec.x+offset.x, menu_buttons.data[i].rec.y+offset.y, menu_buttons.data[i].size, color)
	}
}

draw_map :: proc(t_map: Map, texture: rl.Texture2D) {
    lvl: Level

    switch state
    {
    case GameState.menu:
        lvl = World.data[0]
    case GameState.level_one:
        lvl = World.data[0]   
    }

    for i : i32 = 0; i < lvl.entities.count; i+=1
    {
    	 rl.DrawTexturePro(texture, lvl.entities.data[i].img_src, lvl.entities.data[i].img_dest, rl.Vector2{0, 0}, 0, rl.WHITE)
    }

    /*for layer in t_map.layers {
        for y in 0..<layer.height {
            for x in 0..<layer.width {
                gid := layer.data[y * layer.width + x]
                if gid == 0 {
                    continue
                }
                tile_x := i32(gid - 1) % (texture.width / tile_width)
                tile_y := i32(gid - 1) / (texture.width / tile_height)

                src_rect := rl.Rectangle{
                    x = f32(tile_x * tile_width),
                    y = f32(tile_y * tile_height),
                    width = f32(tile_width),
                    height = f32(tile_height),
                }

                dst_rect := rl.Rectangle{
                    x = f32(x * tile_width) + cast(f32)offset.x,
                    y = f32(y * tile_height) + cast(f32)offset.y,
                    width = f32(tile_width),
                    height = f32(tile_height),
                }

                rl.DrawTexturePro(texture, src_rect, dst_rect, rl.Vector2{0, 0}, 0, rl.WHITE)
            }
        }
    }*/
}