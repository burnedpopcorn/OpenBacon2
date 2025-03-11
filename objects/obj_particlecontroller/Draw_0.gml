if (!ds_list_empty(particles))
    for (var i = 0; i < ds_list_size(particles); i++)
    {
        var q = ds_list_find_value(particles, i);
        
        with (q)
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, 1);
    }
