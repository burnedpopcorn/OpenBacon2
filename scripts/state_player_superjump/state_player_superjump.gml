function scr_player_Sjumpprep()
{
    scr_getinput();
    move = key_right + key_left;
    
    if (sprite_index == spr_player_superjumpprep)
    {
        hsp = movespeed * xscale;
        
        if (animation_end())
            sprite_index = spr_player_superjumppreplight;
        
        movespeed = approach(movespeed, 0, 1);
    }
    else if (sprite_index == spr_player_superjumppreplight)
    {
        hsp = movespeed;
        
        if (move != 0)
            movespeed = 3 * move;
        else
            movespeed = 0;
        
        if (!key_up && grounded && !place_meeting(x, y - 32, obj_solid))
        {
            sprite_index = spr_player_superjump;
            image_index = 0;
            SjumpVsp = -12;
            vsp = SjumpVsp;
            state = states.Sjump;
            create_particle(spr_explosioneffect, x, y, xscale);
        }
    }
}

function scr_player_Sjump()
{
    scr_getinput();
    move = key_right + key_left;
    
    if (sprite_index != spr_player_Sjumpcancelstart)
    {
        image_speed = 0.4;
        hsp = approach(hsp, movespeed, 0.7);
        vsp = SjumpVsp;
        SjumpVsp -= 0.1;
        
        if (key_slap2 || key_attack2)
        {
            sprite_index = spr_player_Sjumpcancelstart;
            image_index = 0;
        }
        
        if (move != 0)
            movespeed = 5 * move;
        else
            movespeed = 0;
        
        afterimagetimer = approach(afterimagetimer, 0, 1);
        
        if (afterimagetimer == 0)
        {
            create_afterimage(sprite_index, image_index, x, y, xscale, 1);
            afterimagetimer = 6;
        }
        
        if (place_meeting(x, y - 1, obj_solid))
        {
            sprite_index = spr_player_bodyslamland;
            image_index = 0;
            vsp = 0;
            hsp = 0;
            state = states.freefallland;
            movespeed = abs(movespeed);
        }
    }
    else
    {
        image_speed = 0.4;
        hsp = movespeed;
        movespeed = 0;
        vsp = 0;
        
        if (move != 0)
            xscale = move;
        
        if (animation_end())
        {
            create_particle(spr_crazyrunothereffect, x, y, xscale);
            sprite_index = spr_player_mach3;
            image_index = 0;
            image_speed = 0.4;
            vsp = -5;
            jumpstop = true;
            movespeed = 12;
            state = states.mach3;
        }
    }
}
