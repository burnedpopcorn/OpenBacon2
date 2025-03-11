function scr_player_freefall()
{
    scr_getinput();
    hsp = approach(hsp, movespeed, 0.25);
    move = key_right + key_left;
    
    if (move != 0)
        movespeed = 7 * move;
    else
        movespeed = 0;
    
    if (movespeed < 0)
        xscale = -1;
    else if (movespeed > 0)
        xscale = 1;
    
    if (sprite_index == spr_player_bodyslamstart && animation_end())
        sprite_index = spr_player_bodyslamfall;
    
    image_speed = 0.35;
    
    if (vsp > 2)
    {
        vsp += 0.2;
        
        if (vsp > 17)
        {
            afterimagetimer = approach(afterimagetimer, 0, 1);
            
            if (afterimagetimer == 0)
            {
                create_afterimage(sprite_index, image_index, x, y, xscale, 1);
                afterimagetimer = 6;
            }
        }
    }
    
    if (grounded && vsp > 0 && (!place_meeting(x, y + 1, obj_destrucitbles) || (!place_meeting(x, y + 1, obj_metalblock) && vsp > 15)))
    {
        sprite_index = spr_player_bodyslamland;
        image_index = 0;
        vsp = 0;
        hsp = 0;
        state = states.freefallland;
        movespeed = abs(movespeed);
    }
}

function scr_player_freefallland()
{
    vsp = 0;
    hsp = 0;
    movespeed = 0;
    image_speed = 0.35;
    
    if (animation_end())
        state = states.normal;
}
