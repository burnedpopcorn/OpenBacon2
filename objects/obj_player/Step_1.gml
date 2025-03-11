fmod_listener_setPosition(0, x, y, 0);

if (state == states.mach2 || state == states.mach3 || state == states.wallclimb)
{
    fmod_event_setPause(machsnd, false);
    
    if (!event_isplaying(machsnd))
        fmod_event_play(machsnd);
    
    var s = 0;
    
    if (state == states.mach2 && sprite_index == spr_player_mach1 && grounded)
        s = 0;
    else if ((state == states.mach2 && sprite_index != spr_player_mach1) || state == states.wallclimb)
        s = 1;
    else if (state == states.mach3 && sprite_index != spr_player_mach4)
        s = 2;
    else if (sprite_index == spr_player_mach4)
        s = 3;
    
    fmod_event_set3DPosition(machsnd, x, y, 0);
    fmod_event_setParameter(machsnd, "state", s, true);
}
else
    fmod_event_stop(machsnd, true);

scr_collide_destructibles();
