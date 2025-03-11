function scr_enemy_move()
{
    hsp = movespeed * xscale;
    movespeed = 1;
    
    if (place_meeting(x + sign(hsp), y, obj_solid) || place_meeting(x + sign(hsp), y, obj_hallway) || ((!place_meeting(x + (xscale * 2), y + 2, obj_solid) && !place_meeting(x + (xscale * 2), y + 2, obj_platform) && !place_meeting(x + (xscale * 2), y + 2, obj_slope)) && grounded))
        xscale *= -1;
    
    if (distance_to_object(obj_player) < 400 && obj_player.state == states.mach3)
    {
        vsp = -5;
        
        if (obj_player.x != x)
            xscale = sign(obj_player.x - x);
        
        sprite_index = spr_scared;
        scaredtimer = 120;
        state = baddiestates.scared;
    }
}
