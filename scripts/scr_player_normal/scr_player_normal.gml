function scr_player_normal()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    
    if (animation_end())
    {
        switch (sprite_index)
        {
            case spr_player_land:
                idletimer = 300;
                sprite_index = spr_player_idle;
                image_index = 0;
                break;
            
            case spr_player_land2:
                idletimer = 300;
                sprite_index = spr_player_move;
                image_index = 0;
                break;
            
            case spr_player_looktocity:
                image_index = image_number - 2;
                break;
        }
    }
    
    steppy = approach(steppy, 0, 0.35);
    
    if (move != 0)
    {
        idletimer = 300;
        
        if (sprite_index != spr_player_land2)
            sprite_index = spr_player_move;
        
        image_speed = (sprite_index == spr_player_move) ? 0.35 : 0.45;
        
        if ((floor(image_index) == 3 || floor(image_index) == 8) && steppy <= 0 && sprite_index == spr_player_move)
        {
            steppy = 2;
            create_particle(spr_cloudeffect, x, y + 42, 1);
        }
        
        xscale = move;
        movespeed = approach(movespeed, 7, 0.5);
    }
    else
    {
        if (sprite_index != spr_player_land && sprite_index != spr_player_looktocity)
        {
            if (global.escape)
                sprite_index = spr_player_panic;
            else
                sprite_index = spr_player_idle;
        }
        
        image_speed = 0.35;
        movespeed = 0;
    }
    
    if (!grounded)
    {
        state = states.jump;
        sprite_index = spr_player_fall;
    }
    
    if (key_jump2 && grounded)
    {
        scr_soundeffect_3d(jump, x, y);
        create_particle(spr_highjump, x, y, 1);
        state = states.jump;
        sprite_index = spr_player_jump;
        jumpstop = false;
        image_index = 0;
        vsp = -11;
    }
    
    if (key_down && grounded)
    {
        sprite_index = spr_player_crouch;
        image_index = 0;
        state = states.crouch;
    }
    
    if (key_attack && grounded)
    {
        sprite_index = spr_player_mach1;
        image_index = 0;
        state = states.mach2;
        movespeed = 6;
    }
    
    if (key_taunt)
        sprite_index = spr_player_boogie;
    
    do_taunt();
    do_grab();
}
