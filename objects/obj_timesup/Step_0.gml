switch (part)
{
    case 0:
        with (obj_player)
        {
            x = 960 / 2;
            y = 540 / 2;
            sprite_index = spr_player_timesup;
            image_index = 0;
            hsp = 0;
            vsp = 0;
        }
        
        part++;
        parttimer = 180;
        break;
    
    case 1:
        parttimer--;
        
        with (obj_player)
        {
            image_speed = 0.35;
            
            if (animation_end())
                image_index = image_number - 1;
        }
        
        if (parttimer <= 0)
        {
            with (obj_player)
            {
                xscale = choose(-1, 1);
                other.fakevsp = irandom_range(-10, -8);
                hsp = 15 * xscale;
                sprite_index = spr_player_outofpizza1;
                image_index = 0;
            }
            
            part++;
        }
        
        break;
    
    case 2:
        with (obj_player)
        {
            image_speed = 0.35;
            hsp = 15 * xscale;
            vsp = other.fakevsp;
            other.fakevsp += 0.5;
            
            if (animation_end() && sprite_index == spr_player_outofpizza1)
                sprite_index = spr_player_outofpizza2;
            
            if (place_meeting(x + sign(hsp), y, obj_solid))
                xscale *= -1;
            
            if (grounded)
            {
                other.part++;
                sprite_index = spr_player_outofpizza3;
                image_index = 0;
                other.fakehsp = hsp;
            }
            
            other.parttimer = 180;
        }
        
        break;
    
    case 3:
        parttimer--;
        
        with (obj_player)
        {
            image_speed = 0.35;
            hsp = other.fakehsp;
            other.fakehsp = approach(other.fakehsp, 0, 1);
            
            if (animation_end() && sprite_index == spr_player_outofpizza3)
                sprite_index = spr_player_outofpizza4;
        }
        
        if (parttimer <= 0)
        {
            if (global.leveltorestart != -4)
            {
                audio_stop_all();
                instance_activate_all();
                player_reset();
                
                if (instance_exists(obj_pizzaface))
                    instance_destroy(obj_pizzaface);
                
                obj_player.movespeed = 0;
                obj_player.hsp = 0;
                obj_player.vsp = 0;
                room = global.leveltorestart;
            }
        }
        
        break;
}
