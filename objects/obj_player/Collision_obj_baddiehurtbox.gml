var obj = other;

with (obj)
{
    if (baddieID.state == baddiestates.move && other.state != states.hurt)
    {
        with (other)
        {
            vsp = -10;
            movespeed = 0;
            state = states.hurt;
            hsp = 10 * -xscale;
            global.collect -= 50;
            global.combotime /= 2;
            
            if (instance_exists(grabbedID))
            {
                with (grabbedID)
                {
                    vsp = -5;
                    xscale = -obj_player.xscale;
                    sprite_index = spr_stun;
                    scaredtimer = 120;
                    stunbuffer = 15;
                    state = baddiestates.stunned;
                    movespeed = abs(6 + (other.movespeed / 2)) * other.xscale;
                }
            }
        }
    }
}
