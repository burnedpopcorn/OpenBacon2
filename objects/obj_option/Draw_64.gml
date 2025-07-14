draw_set_color(c_white);

for (var i = 0; i < array_length(backgrounds); i++)
{
    draw_sprite_tiled_ext(spr_optionsBG, backgrounds[i][0], BGX, BGY, 1, 1, c_white, backgrounds[i][1]);
    
    if (i != 0)
    {
        if (currentmenu == i)
            backgrounds[i][1] = approach(backgrounds[i][1], 1, 0.1);
        else
            backgrounds[i][1] = approach(backgrounds[i][1], 0, 0.1);
    }
}

var _sel = selected;
var m = menus[currentmenu];
var opt = m.options;
var _length = array_length(opt);

switch (m.anchor)
{
    case option.anchor_center:
        var xx = 960 / 2;
        var yy = (540 / 2) - ((m.ypad * _length) / 2);
        
        for (var i = 0; i < _length; i++)
        {
            var q = opt[i];
            var _col = (_sel == i) ? "[c_white]" : "[c_grey]";
            draw_text_scribble(xx, yy + (m.ypad * i), _col + "[spr_bigfont][fa_center]" + q.name);
        }
        
        break;
    
    case option.anchor_left:
        var xx = 960 / 5;
        var yy = (540 / 2) - ((m.ypad * _length) / 2);
        
        for (var i = 0; i < _length; i++)
        {
            var q = opt[i];
            
            switch (q.type)
            {
                case 0:
                    var _col = (_sel == i) ? "[c_white]" : "[c_grey]";
                    draw_text_scribble(xx, yy + (m.ypad * i), _col + "[spr_bigfont][fa_left]" + q.name);
                    break;
                
                case 1:
                    var _col = (_sel == i) ? "[c_white]" : "[c_grey]";
                    draw_text_scribble(xx, yy + (m.ypad * i), _col + "[spr_bigfont][fa_left]" + q.name);
                    draw_text_scribble(960 - xx, yy + (m.ypad * i), _col + "[spr_bigfont][fa_right]" + q.toggle[q.val]);
                    break;
                
                case 2:
                    var _col = (_sel == i) ? "[c_white]" : "[c_grey]";
                    draw_text_scribble(xx, yy + (m.ypad * i), _col + "[spr_bigfont][fa_left]" + q.name);
                    draw_text_scribble(960 - xx, yy + (m.ypad * i), _col + "[spr_bigfont][fa_right]" + string(round(q.val)));
                    break;
            }
        }
        
        break;
}
