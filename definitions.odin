package main

import rl "vendor:raylib"

Game :: struct {
	name: string,
	width, height: i32,
}

Vector2 :: [2]f32
Vector3 :: [3]f32
Vector4 :: [4]f32

Vector2i :: [2]i32
Vector3i :: [3]i32
Vector4i :: [4]i32

HColor :: struct {
	name: cstring,
	value: rl.Color,
}

Rectangle2 :: struct {
	position: Vector2,
	size: Vector2,
}

Frame :: struct {
	//Image
	img: rl.Image,
	//The texture
	text: rl.Texture,
	//Frame count
	count: i32,
}

FrameArray :: struct {
	//Frame array
	data: [dynamic]Frame,
	//i32s
	capacity, count: i32,
}

Animation :: struct {
	//frame and frame index
	frame, index: i32,
}

Menu :: struct {
	name: string,
	frames: FrameArray,
	animation: Animation,
}

Entity :: struct {
	//Strings
	name: string,
	//Integers
	sprite_index, position, sprite_count: i32,
	//Bools
	alive: bool,
	//Vector2's
	size: Vector2,
	//Recs
	img_src, img_dest: rl.Rectangle,
	//FrameArray
	frames: FrameArray,
}

EntityArray :: struct {
	data: [dynamic]Entity,
	capacity: i32,
	count: i32,
}

Level :: struct {
	//Images
	world_image: rl.Image,
	//Entity Array
	entities: EntityArray,
	//Strings
	name: string,
	//i32
	level_id: i32,
}

LevelArray :: struct {
	//Level Array
	data: [dynamic]Level,
	//i32s
	capacity, count: i32,
}

Button :: struct {
	//Vectors
	rec: Vector4i,
	//i32s
	size: i32,
	//Strings
	name, text: string,
}

ButtonList :: struct {
	//Button Array
	data: [dynamic]Button,
	//i32's
	capacity, count: i32,
}

Song :: struct {
	//Strings
	name: string,
	//Song
	music: rl.Music,
}

Jukebox :: struct {
	//Song Array
	songs: [dynamic]Song,
	//i32's
	capacity, count: i32,
}