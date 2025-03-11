enum secretstates
{
	exist,
	disappear
}

image_speed = 0.35;
state = secretstates.exist;
leavetimer = 180;

if (obj_player.state == states.actor)
{
    obj_player.x = x;
    obj_player.y = y;
    obj_player.sprite_index = spr_player_fall;
}
