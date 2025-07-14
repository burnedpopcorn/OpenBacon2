function scr_player_crouch()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    
    if (animation_end())
    {
        switch (sprite_index)
        {
            case spr_player_crouchjump:
                sprite_index = spr_player_crouchfall;
                image_index = 0;
                break;
        }
    }
    
    if (!jumpstop)
    {
        if (!key_jump && vsp < 0)
        {
            vsp /= 20;
            jumpstop = true;
        }
    }
    
    steppy = approach(steppy, 0, 0.35);
    
    if (move != 0)
    {
        if (sprite_index != spr_player_crouchjump && sprite_index != spr_player_crouchfall)
            sprite_index = spr_player_crouchwalk;
        
        image_speed = 0.35;
        
        if ((floor(image_index) == 4 || floor(image_index) == 12) && steppy <= 0)
        {
            steppy = 2;
            create_particle(spr_cloudeffect, x, y + 42, 1);
        }
        
        xscale = move;
        movespeed = approach(movespeed, 5, 0.5);
    }
    else
    {
        if (sprite_index != spr_player_crouchjump && sprite_index != spr_player_crouchfall)
            sprite_index = spr_player_crouch;
        
        image_speed = 0.35;
        movespeed = 0;
    }
    
    if (!key_down && grounded && !place_meeting(x, y - 32, obj_solid))
        state = states.normal;
    
    if (grounded && (sprite_index == spr_player_crouchjump || sprite_index == spr_player_crouchfall))
    {
        sprite_index = spr_player_crouch;
        create_particle(spr_land, x, y, 1);
    }
    
    if (!grounded && sprite_index != spr_player_crouchjump)
        sprite_index = spr_player_crouchfall;
    
    if (key_jump2 && grounded)
    {
        create_particle(spr_highjump, x, y, 1);
        scr_soundeffect_3d(jump, x, y);
        sprite_index = spr_player_crouchjump;
        jumpstop = false;
        image_index = 0;
        vsp = -8;
    }
}
