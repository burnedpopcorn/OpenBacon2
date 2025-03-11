function scr_player_wallsplat()
{
    scr_getinput();
    image_speed = 0.35;
    
    if (grounded)
        hsp = 0;
    
    move = key_right + key_left;
    movespeed = 0;
    
    if (sprite_index == spr_player_wallsplat)
        vsp = 0;
    
    if (animation_end())
    {
        switch (sprite_index)
        {
            case spr_player_wallsplat:
            case spr_player_mach3hitwall:
                sprite_index = spr_player_idle;
                image_index = 0;
                state = states.normal;
                break;
        }
    }
}
