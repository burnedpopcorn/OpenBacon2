switch (part)
{
    case 0:
        alpha = approach(alpha, 1, 0.25);
        
        if (alpha == 1)
        {
            part++;
            
            with (obj_player)
            {
                x = roomstartx;
                y = roomstarty;
                sprite_index = spr_player_idle;
                state = states.actor;
                movespeed = 0;
            }
        }
        
        break;
    
    case 1:
        timer = approach(timer, 0, 1);
        
        if (timer == 0)
        {
            part++;
            
            with (obj_player)
            {
                state = states.normal;
                movespeed = 0;
            }
        }
        
        break;
    
    case 2:
        alpha = approach(alpha, 0, 0.25);
        
        if (alpha == 0)
            instance_destroy();
        
        break;
}
