with (obj_player)
{
    if (state == states.mach3 || (state == states.freefall && vsp > 10))
    {
        var mach = y;
        
        if (state == states.freefall)
            mach = y + vsp;
        
        if (place_meeting(x + hsp, mach, other))
            instance_destroy(other);
    }
}
