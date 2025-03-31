package main

import rl "vendor:raylib"
import fmt "core:fmt"
import "third parties/odin-tiled-main/tiled"

Dump :: proc(args: ..any) {
    for x in args {
        fmt.print(x)
        fmt.print(" ")
    }
    fmt.print("\n")
}

draw_rectangle :: proc(rec: Rectangle2, color: HColor)
{
	rl.DrawRectangleV(rec.position, rec.size, color.value);    
}

v2 :: proc(x: f32, y: f32) -> Vector2
{
	return Vector2{x, y}
}

v3 :: proc(x: f32, y: f32, z: f32) -> Vector3
{
	return Vector3{x, y, z}
}

v4 :: proc(x: f32, y: f32, z: f32, w: f32) -> Vector4
{
	return Vector4{x, y, z, w}
}

v2i :: proc(x, y: i32) -> Vector2i
{
	return Vector2i{x, y}
}

v3i :: proc(x, y, z: i32) -> Vector3i
{
	return Vector3i{x, y, z}
}

v4i :: proc(x, y, z, w: i32) -> Vector4i
{
	return Vector4i{x, y, z, w}
}

/*Vector2 game_to_screen_space_point(Vector2 pos) {
    f32 offset_x = dest_rect.x0;
    f32 offset_y = dest_rect.y0;

    return v2(pos.x*scale_x+offset_x, pos.y*scale_y+offset_y);
}

Rectangle2 game_to_screen_space_rect(Rectangle2 rec) {
    return r2(game_to_screen_space_point(rec.p0), game_to_screen_space_point(rec.p1));
}*/

load_menu :: proc()
{
	offset = v2i(80, 0)

	menu.name = "Main"
	menu.frames.data = {}
	
	resize(&menu.frames.data, 2)

	menu.frames.data[0].img = rl.LoadImage("sources/main_menu1.png")
	menu.frames.data[0].count = 64
	menu.frames.data[1].img = rl.LoadImage("sources/main_menu2.png")
	menu.frames.data[1].count = 64

	menu.frames.capacity = 2
	menu.frames.count = 2
}

load_prelim_textures :: proc()
{
	//menu.text = rl.LoadTextureFromImage(menu.img)
}

load_frame_textures :: proc(frames: FrameArray)
{
	frames := frames

	for i: i32 = 0; i < frames.count; i+=1
	{
		frames.data[i].text = rl.LoadTextureFromImage(frames.data[i].img)
	}
}

load_jukebox :: proc()
{
	jukey.songs = {}
	jukey.capacity = 2
	jukey.count = 2

	resize(&jukey.songs, 2)

	jukey.songs[0].music = rl.LoadMusicStream("music/sparkle.mp3")
	jukey.songs[0].music.looping = true
	jukey.songs[0].name = "Abbie Sparkle"

	jukey.songs[1].music = rl.LoadMusicStream("music/voyage.mp3")
	jukey.songs[1].music.looping = true
	jukey.songs[1].name = "Abbie Voyage"
}

load_menu_buttons :: proc()
{
	menu_buttons.data = {}
	menu_buttons.capacity = 3
	menu_buttons.count = 3

	resize(&menu_buttons.data, 3)

	menu_buttons.data[0].rec = v4i(36, 164, 155, 186)
	menu_buttons.data[0].text = "Play Game"
	menu_buttons.data[0].name = "play button"
	menu_buttons.data[0].size = 24

	menu_buttons.data[1].rec = v4i(36, 212, 155, 236)
	menu_buttons.data[1].text = "Online"
	menu_buttons.data[1].name = "multiplayer button"
	menu_buttons.data[1].size = 24

	menu_buttons.data[2].rec = v4i(36, 260, 155, 284)
	menu_buttons.data[2].text = "Exit"
	menu_buttons.data[2].name = "exit button"
	menu_buttons.data[2].size = 24
}

draw_frame_animation :: proc(frames: FrameArray, animation: ^Animation)
{
	animation:=animation

	rl.DrawTexture(frames.data[animation.frame].text, offset.x, offset.y, rl.RAYWHITE)

	animation.index+=1

	if (animation.index == frames.data[animation.frame].count)
	{
		animation.index = 0
		animation.frame += 1
	}

	if (animation.frame == frames.count)
	{
		animation.frame = 0
	}
}

check_button :: proc(button: i32, buttons: ButtonList) -> bool
{
	pos: Vector2i = v2i(rl.GetMouseX(), rl.GetMouseY())

	up: bool = pos.y > offset.y + buttons.data[button].rec.y
	down: bool = pos.y < offset.y + buttons.data[button].rec.w
	left: bool = pos.x > offset.x + buttons.data[button].rec.x
	right: bool = pos.x < offset.x + buttons.data[button].rec.z

	return (up & down & left & right)
}