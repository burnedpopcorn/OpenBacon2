if (image_alpha == 1)
{
    var point = point_direction(x, y, obj_player.x, obj_player.y);
    x += lengthdir_x(movespeed, point);
    y += lengthdir_y(movespeed, point);
    
    if (place_meeting(x, y, obj_player))
        room = timesup_room;
}
else
{
    image_alpha = approach(image_alpha, 1, 0.01);
}

if (obj_player.state == states.actor)
    image_alpha = 0;
