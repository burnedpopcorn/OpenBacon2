if (!ds_list_empty(afterimages))
{
    for (var i = 0; i < ds_list_size(afterimages); i++)
    {
        var q = ds_list_find_value(afterimages, i);
        
        with (q)
        {
            pal_swap_set(pal_player, 1, false);
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, image_blend, image_alpha * alpha);
            shader_reset();
        }
    }
}
