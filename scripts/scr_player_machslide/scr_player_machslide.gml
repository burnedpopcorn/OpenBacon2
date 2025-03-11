function scr_player_machslide()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    movespeed = approach(movespeed, 0, 0.4);
    
    if (!instance_exists(obj_dashcloud) && grounded)
        instance_create_depth(x, y, 5, obj_dashcloud);
    
    if (movespeed == 0 && grounded && animation_end())
    {
        switch (sprite_index)
        {
            case spr_player_machslideboost:
                sprite_index = spr_player_mach2;
                image_index = 0;
                movespeed = 6;
                xscale *= -1;
                state = states.mach2;
                break;
            
            case spr_player_machslideboost3:
                sprite_index = spr_player_mach3;
                image_index = 0;
                movespeed = 12;
                xscale *= -1;
                state = states.mach3;
                break;
            
            case spr_player_machslidestart:
            case spr_player_machslideend:
                sprite_index = spr_player_idle;
                image_index = 0;
                movespeed = 0;
                state = states.normal;
                break;
        }
    }
    
    if (animation_end())
        image_speed = 0;
}
