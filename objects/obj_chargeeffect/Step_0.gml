if (playerid == obj_player)
{
    if (playerid.state != states.mach3)
        instance_destroy();
    
    x = playerid.x + (20 * image_xscale);
    y = playerid.y;
    image_xscale = playerid.xscale;
    image_angle = playerid.angle;
}
