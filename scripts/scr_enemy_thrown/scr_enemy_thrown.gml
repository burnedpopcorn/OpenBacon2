function scr_enemy_thrown()
{
    hsp = hitHsp;
    vsp = hitVsp;
    
    if (place_meeting(x + sign(hsp), y, obj_solid) || place_meeting(x + sign(hsp), y, obj_slope))
        instance_destroy();
    
    if (place_meeting(x + sign(hsp), y, obj_baddie))
        with (instance_place(x + sign(hsp), y, obj_baddie))
            instance_destroy();
}
