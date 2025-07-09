function animation_end()
{
    return floor(image_index) == (image_number - 1);
}

function background_sprite(normal_bg, escape_bg)
{
    var layers = layer_get_all();
    
    for (var i = 0; i < array_length(layers); i++)
    {
        var lay = layers[i];
        var layer_name = layer_get_name(lay);
        var ID = layer_get_id(layer_name);
        var BGID = layer_background_get_id(ID);
        var BGSPR = layer_background_get_sprite(BGID);
        
        if (BGSPR == normal_bg && global.escape)
            layer_background_sprite(BGID, escape_bg);
        else if (BGSPR == escape_bg && !global.escape)
            layer_background_sprite(BGID, normal_bg);
    }
}

function tile_delete(_x, _y)
{
    var layers = layer_get_all();
    
    for (var i = 0; i < array_length(layers); i++)
    {
        var lay = layers[i];
        var layer_name = layer_get_name(lay);
        
        if (layer_name != "Tiles_bg")
        {
            var ID = layer_get_id(layer_name);
            var tilemapID = layer_tilemap_get_id(ID);
            var tiledata = tilemap_get_at_pixel(tilemapID, _x, _y);
            tile_set_empty(tiledata);
            tilemap_set_at_pixel(tilemapID, 0, _x, _y);
        }
    }
}

function in_camera(_bbox_left = bbox_left, _bbox_right = bbox_right, _bbox_bottom = bbox_bottom, _bbox_top = bbox_top)
{
    var camx = camera_get_view_x(view_camera[0]);
    var camy = camera_get_view_y(view_camera[0]);
    var camw = camera_get_view_width(view_camera[0]);
    var camh = camera_get_view_height(view_camera[0]);
    return _bbox_left < (camx + camw) && _bbox_right > camx && _bbox_top < (camy + camh) && _bbox_bottom > camy;
}

function string_extract(_string, _substring, repeat_amount)
{
    var length = string_length(_substring) - 1;
    
    repeat (repeat_amount)
        _string = string_delete(_string, 1, string_pos(_substring, _string) + length);
    
    _string = string_delete(_string, string_pos(_substring, _string), string_length(_string));
    return _string;
}

function quick_save(section, key, val)
{
    ini_open("options.ini");
    ini_write_real(section, key, val);
    ini_close();
}

function slope_rotation()
{
    var _angle = 0;
    
    if (place_meeting_slope(x, y + 1))
    {
        var _obj = instance_place(x, y + 1, obj_slope);
        
        if (abs(_obj.image_yscale) < abs(_obj.image_xscale))
            _angle = 10 * _obj.image_xscale;
        else
            _angle = 45 * sign(_obj.image_xscale);
    }
    
    angle = lerp(angle, _angle, 0.5);
}

function slope_momentum()
{
    if (place_meeting_slope(x, y + 1))
    {
        var _obj = instance_place(x, y + 1, obj_slope);
        
        if (sign(_obj.image_xscale) != xscale)
            movespeed += 0.2;
        else
            movespeed -= 0.1;
        
        movespeed = clamp(movespeed, 6, 24);
    }
}