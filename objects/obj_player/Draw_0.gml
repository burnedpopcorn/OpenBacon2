pal_swap_set(pal_player, 1, false);
draw_sprite_ext(sprite_index, image_index, x, y, xscale, 1, angle, image_blend, image_alpha);
shader_reset();

if (flash)
{
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale, 1, angle, image_blend, 1);
    gpu_set_fog(false, c_white, 0, 0);
}
