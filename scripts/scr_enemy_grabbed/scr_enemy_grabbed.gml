function scr_enemy_grabbed()
{
    sprite_index = spr_stun;
    hsp = 0;
    vsp = 0;
    
    if (obj_player.state == states.hauling)
    {
        x = obj_player.x;
        y = obj_player.y - 55;
    }
    else
    {
        x = obj_player.x + (51.2 * xscale);
        y = obj_player.y - 16;
    }
    
    xscale = obj_player.xscale;
}
