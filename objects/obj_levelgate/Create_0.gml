image_speed = 0;
depth = 30;
gateinfo = ds_list_create();

function create_gate_layer(spr, spr_index, _x, _y, _hspeed, _vspeed, is_parallax = false)
{
    var q = 
    {
        sprite_index: spr,
        image_index: spr_index,
        bgx: _x,
        bgy: _y,
        hsp: _hspeed,
        vsp: _vspeed,
        parallax: is_parallax
    };
    ds_list_add(gateinfo, q);
    return q;
}

create_gate_layer(spr_gate_entranceBG, 0, 0, 0, 0.25, 0);
create_gate_layer(spr_gate_entranceBG, 1, 0, 0, 0.35, 0);
create_gate_layer(spr_gate_entranceBG, 2, 0, 0, 0.45, 0);
bgalpha = 1;
visibleradius = 250;
leveltext = "Crashout City";
level = "crashout";
targetRoom = crashout_1;
textalpha = 0;
drawing = 0;
