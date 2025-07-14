if (place_meeting(x, y, obj_player))
{
    with (obj_player)
    {
        baddieID = other.id;
        
        if (instakillmove && baddieID.state != baddiestates.hit)
        {
            baddieID.hitX = baddieID.x;
            baddieID.hitY = baddieID.y;
            
            if (state == states.mach3)
                machhitanim = true;
            
            hitX = x;
            hitY = y;
            baddieID.freezeframe = true;
            baddieID.hitstuntimer = 5;
            freezeframe = true;
            hitstuntimer = 5;
            hitstun = true;
            obj_camera.shake = 10;
            scr_soundeffect_3d(punch, x, y);
            baddieID.state = baddiestates.hit;
            
            if (key_jump)
                vsp = -10;
        }
        
        if (state == states.grab)
        {
            sprite_index = spr_player_haulingstart;
            image_index = 0;
            state = states.hauling;
            baddieID = -4;
            grabbedID = other.id;
            grabbedID.state = baddiestates.grabbed;
        }
        
        if (state == states.mach2 || (state == states.tumble && baddieID.stunbuffer <= 0))
        {
            with (baddieID)
            {
                vsp = -5;
                xscale = -obj_player.xscale;
                sprite_index = spr_stun;
                scaredtimer = 120;
                stunbuffer = 15;
                state = baddiestates.stunned;
                movespeed = abs(12 + (other.movespeed / 2)) * other.xscale;
            }
        }
    }
}
