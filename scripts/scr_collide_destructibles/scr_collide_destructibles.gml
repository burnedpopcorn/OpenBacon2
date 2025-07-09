function scr_collide_destructibles()
{
    with (obj_destrucitbles)
    {
        with (obj_player)
        {
            if (state == states.grab || state == states.finishingblow || state == states.mach2 || state == states.mach3)
			{
                if (place_meeting(x + hsp, y, other))
                    instance_destroy(other);
			}
            else if (state == states.wallkick || state == states.wallclimb || state == states.punch || state == states.tumble || state == states.Sjump || state == states.freefall)
			{
                if (place_meeting(x + hsp, y + vsp, other))
                    instance_destroy(other);
			}
        }
    }
}
