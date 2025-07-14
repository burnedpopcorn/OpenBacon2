function scr_player_mach2()
{
    scr_getinput();
    hsp = movespeed * xscale;
    move = key_right + key_left;
    
    if (animation_end())
    {
        switch (sprite_index)
        {
            case spr_player_mach1:
                sprite_index = spr_player_mach2;
                image_index = 0;
                break;
            
            case spr_player_secondjump:
                sprite_index = spr_player_secondjumpfall;
                image_index = 0;
                break;
        }
    }
    
    image_speed = abs(movespeed) / 15;
    
    if (grounded)
        movespeed = approach(movespeed, 12, 0.1);
    
    if (!instance_exists(obj_dashcloud) && grounded)
        instance_create_depth(x, y, 5, obj_dashcloud);
    
    slope_momentum();
    
    if (!jumpstop)
    {
        if (!key_jump && vsp < 0)
        {
            vsp /= 20;
            jumpstop = true;
        }
    }
    
    if ((sprite_index == spr_player_secondjump || sprite_index == spr_player_secondjumpfall || sprite_index == spr_player_longjump) && grounded)
        sprite_index = spr_player_mach2;
    
    if (key_jump2 && grounded)
    {
        scr_soundeffect_3d(jump, x, y);
        sprite_index = spr_player_secondjump;
        jumpstop = false;
        image_index = 0;
        vsp = -11;
    }
    
    if (!grounded && sprite_index != spr_player_secondjump && sprite_index != spr_player_secondjumpfall && sprite_index != spr_player_longjump)
    {
        sprite_index = spr_player_secondjump;
        jumpstop = true;
        image_index = 0;
    }
    
    if (movespeed >= 12 && sprite_index != spr_player_longjump)
    {
        flash = true;
        sprite_index = spr_player_mach3;
        image_index = 0;
        image_speed = 0.4;
        machhitanim = true;
        state = states.mach3;
    }
    
    if (!key_attack && grounded)
    {
        scr_soundeffect_3d(mach_end, x, y);
        sprite_index = spr_player_machslidestart;
        image_index = 0;
        image_speed = 0.35;
        state = states.machslide;
    }
    
    if (key_down)
    {
        sprite_index = spr_player_machroll;
        image_index = 0;
        image_speed = 0.35;
        state = states.tumble;
    }
    
    do_taunt();
    do_grab();
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x, y + 1, obj_slope) && !place_meeting(x + sign(hsp), y, obj_destrucitbles) && grounded)
    {
        sprite_index = spr_player_wallsplat;
        image_index = 0;
        movespeed = 0;
        state = states.wallsplat;
    }
    
    if (move != 0 && move != xscale && grounded)
    {
        scr_soundeffect_3d(mach_turn, x, y);
        sprite_index = spr_player_machslideboost;
        image_index = 0;
        image_speed = 0.35;
        state = states.machslide;
    }
    
    afterimagetimer = approach(afterimagetimer, 0, 1);
    
    if (afterimagetimer == 0)
    {
        create_afterimage(sprite_index, image_index, x, y, xscale, abs(movespeed) / 14);
        afterimagetimer = 6;
    }
    
    if ((place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destrucitbles) && !grounded) || (place_meeting(x + sign(hsp), y, obj_solid) && place_meeting(x, y + 1, obj_slope) && grounded))
    {
        wallspeed = movespeed;
        state = states.wallclimb;
        sprite_index = spr_player_climbwall;
    }
}
