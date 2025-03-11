function scr_player_tumble()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    
    if (sprite_index == spr_player_machroll)
        image_speed = abs(movespeed) / 15;
    else
        image_speed = 0.4;
    
    if (sprite_index == spr_player_dive && grounded)
        sprite_index = spr_player_machroll;
    
    if (sprite_index == spr_player_dive)
    {
        if (key_jump2 && !grounded)
        {
            vsp = -5;
            sprite_index = spr_player_bodyslamstart;
            image_index = 0;
            state = states.freefall;
        }
    }
    
    if (sprite_index == spr_player_crouchslip)
    {
        crouchsliptimer = approach(crouchsliptimer, 0, 1);
        
        if (!key_down && grounded && !place_meeting(x, y - 32, obj_solid) && crouchsliptimer <= 0)
        {
            sprite_index = spr_player_mach1;
            image_index = 0;
            state = states.mach2;
        }
    }
    
    if (!grounded && (sprite_index == spr_player_machroll || sprite_index == spr_player_crouchslip))
    {
        vsp = 10;
        sprite_index = spr_player_dive;
    }
    
    if (!key_down && grounded && !place_meeting(x, y - 32, obj_solid) && sprite_index != spr_player_crouchslip)
    {
        sprite_index = spr_player_mach1;
        image_index = 0;
        state = states.mach2;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destrucitbles))
    {
        sprite_index = spr_player_wallsplat;
        image_index = 0;
        movespeed = 0;
        state = states.wallsplat;
    }
}
