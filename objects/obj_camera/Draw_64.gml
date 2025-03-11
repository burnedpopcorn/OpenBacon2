if (!ds_list_empty(collectables))
{
    for (var i = 0; i < ds_list_size(collectables); i++)
    {
        var q = ds_list_find_value(collectables, i);
        
        with (q)
            draw_sprite_ext(sprite_index, 4, x, y, 1, 1, 0, c_white, 1);
    }
}

var hudxx = 144 + irandom_range(collectshake, -collectshake);
var hudyy = 79 + irandom_range(collectshake, -collectshake);
draw_sprite(spr_butterhud, 0, hudxx, hudyy + 32);
draw_text_scribble((hudxx - 4) + 32, hudyy - 7, "[c_white][fa_center][font_collecthud]" + string(global.collect));
