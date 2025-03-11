if (lock == false)
{
    var camx = (cam_tar.x - (camera_get_view_width(view_camera[0]) / 2)) + xoffset + irandom_range(escapeshake, -escapeshake);
    var camy = (cam_tar.y - 50 - (camera_get_view_height(view_camera[0]) / 2)) + irandom_range(escapeshake, -escapeshake);
    camx = clamp(camx, 0, room_width - camera_get_view_width(view_camera[0]));
    camy = clamp(camy, 0, room_height - camera_get_view_height(view_camera[0]));
    camera_set_view_pos(view_camera[0], camx + irandom_range(shake, -shake), camy + irandom_range(shake, -shake));
}

if (room == rm_init || room == rank_room || room == hub_hallway)
    visible = false;
else
    visible = true;

audio_falloff_set_model(audio_falloff_linear_distance);
audio_listener_position(-cam_tar.x, cam_tar.y, 0);
shake = approach(shake, 0, 1);
var extend = ((cam_tar.xscale * cam_tar.movespeed) / 4) * 100;
var accel = 0.5;

if ((extend < 0 && xoffset > 0) || (extend > 0 && xoffset < 0))
    accel = 4;

if (cam_tar.state == states.mach2 || cam_tar.state == states.mach3 || (cam_tar.state == states.grab && cam_tar.movespeed > 12) || (cam_tar.state == states.tumble && cam_tar.movespeed > 12))
    xoffset = approach(xoffset, extend, accel);
else
    xoffset = approach(xoffset, 0, 6);

collectshake = approach(collectshake, 0, 1);

if (global.escape)
    escapeshake = 1;
else
    escapeshake = 0;

if (collect != global.collect)
    collect = global.collect;

if (!ds_list_empty(collectables))
{
    for (var i = 0; i < ds_list_size(collectables); i++)
    {
        var q = ds_list_find_value(collectables, i);
        
        with (q)
        {
            var targetxx = 144;
            var targetyy = 79;
            var point = point_direction(x, y, targetxx - 128, targetxx - 128);
            hsp = lengthdir_x(25, point);
            vsp = lengthdir_y(25, point);
            x += hsp;
            y += vsp;
            
            if (x <= targetxx && y <= targetyy)
            {
                with (other)
                {
                    collectshake = 10;
                    q = undefined;
                    ds_list_delete(collectables, i);
                    i--;
                }
            }
        }
    }
}
