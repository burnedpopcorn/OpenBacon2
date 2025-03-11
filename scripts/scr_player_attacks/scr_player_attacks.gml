function scr_player_punch()
{
    scr_getinput();
    image_speed = 0.35;
    hsp = approach(hsp, movespeed, 0.7);
    move = key_right + key_left;
    
    if (move != 0)
        movespeed = 6 * move;
    else
        movespeed = 0;
    
    if (animation_end())
        image_index = image_number - 1;
    
    if (grounded)
    {
        state = states.normal;
        sprite_index = spr_player_land;
        image_index = 0;
        movespeed = abs(movespeed);
    }
    
    if (vsp < 0)
    {
        afterimagetimer = approach(afterimagetimer, 0, 1);
        
        if (afterimagetimer == 0)
        {
            create_afterimage(sprite_index, image_index, x, y, xscale);
            afterimagetimer = 6;
        }
    }
}

function scr_player_wallkick()
{
    scr_getinput();
    image_speed = 0.4;
    move = key_right + key_left;
    hsp = approach(hsp, movespeed, 1.7);
    
    if (move != 0)
        movespeed = 12 * move;
    else
        movespeed = 0;
    
    if (place_meeting(x + sign(xscale), y, obj_solid) && sprite_index == spr_player_suplexgrabjump)
    {
        vsp = -16;
        sprite_index = spr_player_wallkickspin;
        image_index = 0;
        hsp = -8 * xscale;
    }
    
    if (sprite_index != spr_player_suplexgrabjump && key_slap2)
    {
        vsp = -5;
        sprite_index = spr_player_suplexgrabjump;
        
        if (move != 0)
            xscale = move;
        
        if (move != 0)
            hsp = 13 * move;
        else
            hsp = 13 * xscale;
    }
    
    if (sprite_index == spr_player_wallkickspin && key_jump2)
    {
        vsp = 20;
        sprite_index = spr_player_wallkickgroundpound;
    }
    
    if (sprite_index == spr_player_wallkickspin && key_down2 && vsp < 10)
        vsp = 15;
    
    if (grounded)
    {
        if (sprite_index == spr_player_suplexgrabjump && key_jump)
        {
            vsp = -8;
            sprite_index = spr_player_wallkickspin;
        }
        else if (sprite_index == spr_player_wallkickgroundpound && key_jump)
        {
            if (movespeed < 16)
                vsp = -16;
            else
                vsp = -movespeed;
            
            sprite_index = spr_player_wallkickspin;
        }
        else if (!key_attack)
        {
            state = states.normal;
            sprite_index = spr_player_land;
            image_index = 0;
            movespeed = abs(movespeed);
        }
        else
        {
            state = states.mach3;
            flash = true;
            sprite_index = spr_player_mach3hit;
            image_index = 0;
            
            if (move != 0)
                xscale = move;
            
            if (movespeed < 13)
                movespeed = 13;
        }
    }
    
    afterimagetimer = approach(afterimagetimer, 0, 1);
    
    if (afterimagetimer == 0)
    {
        create_bounce_afterimage(sprite_index, image_index, x, y, xscale);
        afterimagetimer = 4;
    }
    
    do_taunt();
}
