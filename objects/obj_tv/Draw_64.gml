if (surface_exists(surf) && surface_exists(clip))
{
    surface_set_target(surf);
    pal_swap_set(pal_combometer, combopalindex, false);
    draw_sprite(spr_combometer_masks, 1, 139, 69);
    shader_reset();
    draw_sprite(spr_combometer_milk, milkindex, 22, 22 + milkpos);
    surface_reset_target();
    surface_set_target(clip);
    draw_clear(c_white);
    gpu_set_blendmode(bm_subtract);
    draw_sprite(spr_combometer_masks, 0, 139, 69);
    surface_reset_target();
    surface_set_target(surf);
    draw_surface(clip, 0, 0);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    draw_surface(surf, comboX - 139, comboY - 69);
}
else
{
    surf = surface_create(278, 139);
    clip = surface_create(278, 139);
}

var xx = (comboX - 31) + 16;
var yy = comboY + 33;

for (var i = 0; i < string_length(string(global.combo)); i++)
{
    draw_text_scribble(xx, yy, "[spr_combofnt]" + string_char_at(string(global.combo), i + 1));
    xx += 18;
    yy -= 2;
}

pal_swap_set(pal_combometer, combopalindex, false);
draw_sprite(spr_combometer, milkindex, comboX, comboY);
shader_reset();
xx = 823 + wave(-2, 2, 4, 0);
yy = 75 + wave(-2, 2, 8, 0);
draw_sprite(sprite_index, image_index, xx, yy);
draw_sprite_ext(spr_tv_drawings, drawingindex, xx, yy, 1, 1, 0, c_white, drawingalpha);
draw_sprite(spr_tv_hand, 0, (xx - 55) + irandom_range(-5, 5), switchhandY + irandom_range(-3, 3));
var second = string(global.fill[1]);

if (global.fill[1] < 10)
    second = "0" + string(global.fill[1]);

if (global.escape)
    draw_text_scribble(960 / 2, 150, "[fa_center][c_white][spr_creditsfont]" + string(global.fill[0]) + ":" + second);
