function scr_player_enterdoor()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
    
    if (animation_end())
        image_index = image_number - 1;
}

function scr_player_walkfront()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
    c = approach(c, 255, 10);
    image_blend = make_colour_hsv(0, 0, c);
    
    if (animation_end())
    {
        if (sprite_index == spr_player_walkfront)
        {
            if (place_meeting(x, y, obj_exitgate))
            {
                sprite_index = spr_player_timesup;
                image_index = 0;
                
                with (obj_exitgate)
                {
                    ds_list_add(global.saveroom, id);
                    image_index = 0;
                    obj_camera.shake = 15;
                }
                
                scr_soundeffect_3d(gateslam, x, y);
            }
            else
            {
                state = states.normal;
                sprite_index = spr_player_idle;
                image_index = 0;
            }
        }
        else
        {
            obj_music.lock = false;
            
            with (obj_music)
                event_user(0);
            
            state = states.normal;
            sprite_index = spr_player_idle;
            image_index = 0;
        }
    }
}
