package main

import rl "vendor:raylib"

make_entity_array :: proc(capacity: i32) -> EntityArray
{
	arr: EntityArray
	arr.data = {}
	arr.capacity = capacity
	arr.count = 0

	resize(&arr.data, capacity)

	return arr
}

draw_entity :: proc(ent: Entity)
{

}

make_player :: proc() -> Entity
{
	frame: [dynamic]Frame
	resize(&frame, 2)

	frame[0].img = rl.LoadImage("goomby1.png")
	frame[0].count = 4
	frame[1].img = rl.LoadImage("goomby2.png")
	frame[1].count = 4

	ent: Entity
	ent.size = v2(28, 49)
	ent.position = 1
	ent.alive = true
	ent.sprite_index = 0
	ent.sprite_count = 2

	ent.frames.data = frame

	return ent
}