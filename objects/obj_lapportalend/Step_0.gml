if (cutscene == true)
{
    switch (part)
    {
        case 0:
            if (obj_player.sprite_index != spr_player_fall)
            {
                obj_player.sprite_index = spr_player_fall;
                obj_player.image_index = 0;
                obj_player.image_alpha = 0;
            }
            else
            {
                global.combotime = 60;
                global.lap = true;
                obj_player.image_alpha = approach(obj_player.image_alpha, 1, 0.04);
                
                if (obj_player.image_alpha == 1)
                {
                    with (obj_player)
                    {
                        instance_destroy(other);
                        state = states.jump;
                        vsp = 0;
                        movespeed = 0;
                        hsp = 0;
                    }
                }
            }
            
            break;
    }
}
