if (!ds_list_empty(particles))
    for (var i = 0; i < ds_list_size(particles); i++)
    {
        var q = ds_list_find_value(particles, i);
        
        with (q)
        {
            image_index += 0.35;
            
            if (floor(image_index) == (sprite_get_number(sprite_index) - 1))
            {
                with (other)
                {
                    q = undefined;
                    ds_list_delete(particles, i);
                    i--;
                }
            }
        }
    }
