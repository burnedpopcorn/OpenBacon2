var txt = "[c_white][fa_center][fa_top][shake][spr_creditsfont]" + leveltext;
var xx = 960 / 2;
var yy = 540 - 50;
draw_set_color(c_white);
draw_set_alpha(textalpha);
draw_text_scribble(xx, yy - (string_height_scribble(txt) / 2), txt);
draw_set_alpha(1);
