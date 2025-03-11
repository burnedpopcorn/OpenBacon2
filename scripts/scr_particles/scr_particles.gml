function create_particle(spr, _x, _y, _xscale, _depth = 0)
{
    var par = 
    {
        sprite_index: spr,
        image_index: 0,
        x: _x,
        y: _y,
        image_xscale: _xscale,
        depth: _depth
    };
    ds_list_add(obj_particlecontroller.particles, par);
    return par;
}

function create_collect(spr, _x, _y)
{
    _x -= camera_get_view_x(view_camera[0]);
    _y -= camera_get_view_y(view_camera[0]);
    var par = 
    {
        sprite_index: spr,
        x: _x,
        y: _y,
        hsp: 0,
        vsp: 0
    };
    ds_list_add(obj_camera.collectables, par);
    return par;
}
