if (active)
{
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_rectangle(0, 0, 960, 540, false);
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_sprite(screensprite, 0, 0, 0);
    draw_sprite(guisprite, 0, 0, 0);
    draw_sprite(spr_pause_gradient, 0, 0, gradientpos);
    draw_set_color(c_white);
    draw_set_alpha(1);
    update_snooze();
    
    if (active == 1)
    {
        if (!ds_list_empty(options))
        {
            var xx = 960 / 2;
            var yy = (540 / 2) - (48 * (ds_list_size(options) - 2));
            
            for (var i = 0; i < ds_list_size(options); i++)
            {
                var q = ds_list_find_value(options, i);
                
                if (is_struct(q))
                {
                    var _col = (selected == i) ? "[c_white]" : "[c_grey]";
                    draw_text_scribble(xx, yy, _col + "[spr_bigfont][fa_center]" + q.option);
                    yy += 48;
                }
            }
        }
    }
}

draw_sprite(spr_pause_border, 0, border1pos[0] + wave(-2, 2, 4, 0), border1pos[1] + wave(-2, 2, 8, 0));
draw_sprite(spr_pause_border, 1, border2pos[0] + wave(-2, 2, 4, 60), border2pos[1] + wave(-2, 2, 8, 60));
