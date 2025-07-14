function scr_player_mach3()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    
    if (animation_end())
    {
        switch (sprite_index)
        {
            case spr_player_mach3jump:
                sprite_index = spr_player_mach3;
                image_index = 0;
                break;
            
            case spr_player_mach3hit:
                sprite_index = spr_player_mach3;
                image_index = 0;
                break;
        }
    }
    
    if (move == xscale)
    {
        if (movespeed < 16)
            movespeed += 0.025;
        else if (movespeed < 23)
            movespeed += 0.1;
    }
    else
        movespeed = approach(movespeed, 12, 0.1);
    
    if (!instance_exists(obj_dashcloud) && grounded)
        with (instance_create_depth(x, y, 5, obj_dashcloud))
            sprite_index = spr_superdashcloud;
    
    if (!instance_exists(obj_dashcloud2) && grounded & mach4)
        with (instance_create_depth(x, y, 5, obj_dashcloud2))
            sprite_index = spr_crazyrunothereffect;
    
    slope_momentum();
    
    if (movespeed > 16)
        mach4 = true;
    else
        mach4 = false;
    
    if (mach4 && sprite_index != spr_player_mach4)
    {
        flash = true;
        sprite_index = spr_player_mach4;
    }
    
    if (!jumpstop)
    {
        if (!key_jump && vsp < 0)
        {
            vsp /= 20;
            jumpstop = true;
        }
    }
    
    if (machhitanim && sprite_index != spr_player_mach3hit)
    {
        sprite_index = spr_player_mach3hit;
        image_index = 0;
        machhitanim = false;
    }
    
    if (!key_attack && grounded)
    {
        scr_soundeffect_3d(mach_end, x, y);
        sprite_index = spr_player_machslidestart;
        image_index = 0;
        image_speed = 0.35;
        state = states.machslide;
    }
    
    if (move != 0 && move != xscale && grounded)
    {
        movespeed = 12;
        scr_soundeffect_3d(mach_turn, x, y);
        sprite_index = spr_player_machslideboost3;
        image_index = 0;
        image_speed = 0.35;
        state = states.machslide;
    }
    
    image_speed = 0.35;
    
    if (key_jump2 && grounded)
    {
        scr_soundeffect_3d(jump, x, y);
        sprite_index = spr_player_mach3jump;
        jumpstop = false;
        image_index = 0;
        vsp = -11;
    }
    
    if (key_down)
    {
        sprite_index = spr_player_machroll;
        image_index = 0;
        image_speed = 0.35;
        state = states.tumble;
    }
    
    if (key_jump2 && !grounded)
    {
        vsp = 20;
        sprite_index = spr_player_wallkickgroundpound;
        state = states.wallkick;
    }
    
    do_taunt();
    do_grab();
    
    if (key_up && grounded && !place_meeting(x, y - 32, obj_solid))
    {
        sprite_index = spr_player_superjumpprep;
        image_index = 0;
        state = states.Sjumpprep;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destrucitbles) && !place_meeting(x, y + 1, obj_slope) && grounded)
    {
        vsp = -5;
        hsp = -5 * xscale;
        obj_camera.shake = 15;
        sprite_index = spr_player_mach3hitwall;
        image_index = 0;
        movespeed = 0;
        state = states.wallsplat;
    }
    
    afterimagetimer = approach(afterimagetimer, 0, 1);
    
    if (afterimagetimer == 0)
    {
        create_afterimage(sprite_index, image_index, x, y, xscale, abs(movespeed) / 14);
        afterimagetimer = 6;
    }
    
    if ((place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destrucitbles && !place_meeting(x + sign(hsp), y, obj_metalblock)) && !grounded) || (place_meeting(x + sign(hsp), y, obj_solid) && place_meeting(x, y + 1, obj_slope) && grounded))
    {
        wallspeed = movespeed;
        state = states.wallclimb;
        sprite_index = spr_player_climbwall;
    }
}
