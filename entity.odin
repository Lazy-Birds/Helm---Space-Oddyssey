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
	resize(&frame, 1)

	frame[0].img = rl.LoadImage("sources/nick.png")
	frame[0].count = 4
	/*frame[1].img = rl.LoadImage("nick.png")
	frame[1].count = 4*/

	ent: Entity
	ent.size = v2(13, 35)
	ent.position = v2(240, 240)
	ent.alive = true
	ent.sprite_index = 0
	ent.sprite_count = 2
	player.animation.frame = 0
	player.animation.index = 0

	ent.frames.data = frame
	ent.frames.capacity = 1
	ent.frames.count = 1

	return ent
}

player_actions :: proc()
{
	if rl.IsKeyDown(rl.KeyboardKey.W) | rl.IsKeyDown(rl.KeyboardKey.A) | 
		rl.IsKeyDown(rl.KeyboardKey.S) | rl.IsKeyDown(rl.KeyboardKey.D)
	{
		player.state = PlayerStates.MOVE
	} else
	{
		player.state = PlayerStates.NEUTRAL
	}

	switch player.state
	{
		case PlayerStates.NEUTRAL:
			draw_frame_animation(player.frames, &player.animation, player.position)
		case PlayerStates.MOVE:
			switch {
			case rl.IsKeyDown(rl.KeyboardKey.W):
				player.velocity.y = -2
			case rl.IsKeyDown(rl.KeyboardKey.S):
				player.velocity.y = 2
			case rl.IsKeyDown(rl.KeyboardKey.A):
				player.velocity.x = -2
			case rl.IsKeyDown(rl.KeyboardKey.D):
				player.velocity.x = 2
			}

			player_move()

			draw_frame_animation(player.frames, &player.animation, player.position)
		case PlayerStates.TALKING:
			draw_frame_animation(player.frames, &player.animation, player.position)
	}
}

player_move :: proc()
{
	for i: f32 = 0; i < abs_f32(player.velocity.y); i+=1
	{
		player.position.y = player.position.y+sign_f32(player.velocity.y)
	}

	for i: f32 = 0; i < abs_f32(player.velocity.x); i+=1
	{
		player.position.x = player.position.x+sign_f32(player.velocity.x)
	}

	player.velocity = v2(0, 0)
}