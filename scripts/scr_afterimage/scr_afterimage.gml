enum afterimage
{
	greennorange,
	white
}

function create_afterimage(spr, img_frame, _x, _y, _xscale, _alpha = 1)
{
    var aft = 
    {
        sprite_index: spr,
        image_index: img_frame,
        x: _x,
        y: _y,
        image_xscale: _xscale,
        image_blend: choose(4771936, 13660176), // green, orange
        alarm: [15, 5, -2],
        type: afterimage.greennorange,
        alpha: _alpha,
        image_alpha: 1
    };
    ds_list_add(obj_afterimagecontroller.afterimages, aft);
    return aft;
}

function create_bounce_afterimage(spr, img_frame, _x, _y, _xscale)
{
    var aft = 
    {
        sprite_index: spr,
        image_index: img_frame,
        x: _x,
        y: _y,
        image_xscale: _xscale,
        image_blend: c_white,
        alarm: [15, 5, -2],
        type: afterimage.white,
        alpha: 1,
        image_alpha: 1
    };
    ds_list_add(obj_afterimagecontroller.afterimages, aft);
    return aft;
}
