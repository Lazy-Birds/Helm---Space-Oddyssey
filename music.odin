package main

import "core:fmt"
import rl "vendor:raylib"

load_music :: proc(song: i32)
{
	rl.PlayMusicStream(jukey.songs[song].music)
}

play_music :: proc(song: i32)
{
	rl.UpdateMusicStream(jukey.songs[song].music)

}