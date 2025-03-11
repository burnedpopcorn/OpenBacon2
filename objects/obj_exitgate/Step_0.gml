if (place_meeting(x, y, obj_player) && global.escape)
{
    with (obj_player)
    {
        if (key_up2)
        {
            vsp = 0;
            state = states.enterdoor;
            sprite_index = spr_player_lookdoor;
            image_index = 0;
            instance_create_depth(0, 0, 1, obj_rankfadein);
        }
    }
}
