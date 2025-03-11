function scr_player_jump()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    image_speed = 0.35;
    
    if (!jumpstop)
    {
        if (!key_jump && vsp < 0)
        {
            vsp /= 20;
            jumpstop = true;
        }
    }
    
    if (move != 0)
    {
        xscale = move;
        movespeed = approach(movespeed, 7, 0.5);
    }
    else
        movespeed = 0;
    
    if (grounded)
    {
        create_particle(spr_land, x, y, 1);
        
        if (move != 0)
            sprite_index = spr_player_land2;
        else
            sprite_index = spr_player_land;
        
        image_index = 0;
        state = states.normal;
    }
    
    if (key_down2 && !grounded)
    {
        vsp = -5;
        sprite_index = spr_player_bodyslamstart;
        image_index = 0;
        state = states.freefall;
    }
    
    if (sprite_index == spr_player_jump && animation_end())
        sprite_index = spr_player_fall;
    
    do_taunt();
    do_grab();
}
