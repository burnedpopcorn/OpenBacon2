if (state == states.mach2 || state == states.mach3 || state == states.wallclimb)
{
    //audio_stop_sound(machsnd);
	var prevmachsnd = machsnd;

    var s = 1;
    
    if (state == states.mach2 && sprite_index == spr_player_mach1 && grounded)
        s = 1;
    else if ((state == states.mach2 && sprite_index != spr_player_mach1) || state == states.wallclimb)
        s = 2;
    else if (state == states.mach3 && sprite_index != spr_player_mach4)
        s = 3;
    else if (sprite_index == spr_player_mach4)
        s = 4;
    
	machsnd = asset_get_index("sfx_mach" + string(s));
	
	if (machsnd != prevmachsnd)
	{
		audio_stop_sound(prevmachsnd);
		scr_soundeffect_3d(machsnd, x, y, 0, true);
	}
}
else
{
    audio_stop_sound(machsnd);
	machsnd = sfx_mach1;
}

scr_collide_destructibles();
