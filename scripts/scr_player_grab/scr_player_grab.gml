function scr_player_grab()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    image_speed = 0.35;
    
    if (movespeed < 10)
        movespeed = approach(movespeed, 10, 0.25);
    
    if (animation_end() && sprite_index == spr_player_suplexgrabjumpstart)
        sprite_index = spr_player_suplexgrabjump;
    
    if (!grounded && sprite_index == spr_player_suplexdash)
        sprite_index = spr_player_suplexgrabjumpstart;
    
    if ((animation_end() && sprite_index == spr_player_suplexdash) || ((sprite_index == spr_player_suplexgrabjump || sprite_index == spr_player_suplexgrabjumpstart) && grounded))
    {
        if (key_attack)
        {
            sprite_index = spr_player_mach2;
            image_index = 0;
            state = states.mach2;
        }
        else
        {
            sprite_index = spr_player_idle;
            image_index = 0;
            state = states.normal;
        }
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destrucitbles) && grounded)
    {
        sprite_index = spr_player_wallsplat;
        image_index = 0;
        movespeed = 0;
        state = states.wallsplat;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destrucitbles) && !grounded)
    {
        wallspeed = movespeed;
        state = states.wallclimb;
        sprite_index = spr_player_climbwall;
    }
    
    if (move != 0 && move != xscale)
    {
        movespeed = 2;
        state = states.jump;
        sprite_index = spr_player_fall;
    }
    
    if (!jumpstop)
    {
        if (!key_jump && vsp < 0)
        {
            vsp /= 20;
            jumpstop = true;
        }
    }
    
    if (key_down2 && grounded)
    {
        crouchsliptimer = 25;
        flash = true;
        movespeed = 12;
        state = states.tumble;
        sprite_index = spr_player_crouchslip;
    }
    
    if (key_jump2 && grounded)
    {
        jumpstop = false;
        vsp = -11;
        sprite_index = spr_player_longjump;
        image_index = 0;
        state = states.mach2;
    }
}
