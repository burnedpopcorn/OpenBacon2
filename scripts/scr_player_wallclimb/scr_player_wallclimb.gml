function scr_player_wallclimb()
{
    scr_getinput();
    hsp = 0;
    vsp = -wallspeed;
    move = key_right + key_left;
    
    if (move == xscale)
        wallspeed = approach(wallspeed, 24, 0.1);
    
    if (!key_attack)
    {
        state = states.jump;
        movespeed = 0;
        vsp = 0;
        sprite_index = spr_player_fall;
    }
    
    if (!place_meeting(x + (32 * xscale), y, obj_solid))
    {
        if (wallspeed >= 12)
        {
            state = states.mach3;
            movespeed = wallspeed;
            sprite_index = spr_player_mach3;
            vsp = 0;
        }
        else
        {
            state = states.mach2;
            movespeed = wallspeed;
            sprite_index = spr_player_mach2;
            vsp = 0;
        }
    }
    
    if (key_jump2)
    {
        jumpstop = false;
        vsp = -11;
        xscale *= -1;
        movespeed = 10;
        sprite_index = spr_player_secondjump;
        image_index = 0;
        state = states.mach2;
    }
    
    if (place_meeting(x, y - 1, obj_solid) && !place_meeting(x, y - 1, obj_destrucitbles))
    {
        sprite_index = spr_player_bodyslamland;
        image_index = 0;
        vsp = 0;
        hsp = 0;
        state = states.freefallland;
        movespeed = abs(movespeed);
    }
}
