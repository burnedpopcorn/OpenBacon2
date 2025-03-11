function pal_swap_draw_palette(spr, top_left_x, _x, _y)
{
    draw_sprite_part(spr, 0, floor(top_left_x), 0, 1, sprite_get_height(spr), _x, _y);
}

function pal_swap_get_color_count(sprite)
{
    return sprite_get_height(sprite);
}

function pal_swap_get_pal_count(sprite)
{
    return sprite_get_width(sprite);
}
