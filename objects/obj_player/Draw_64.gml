var variables = [x, y, "Hub Room: " + room_get_name(hubgotoroom), statename, global.combodropped, "exe"];
var xx = 64;
var yy = (540 / 2) - (30 * array_length(variables));

if (global.debug)
{
    for (var i = 0; i < array_length(variables); i++)
    {
        draw_text_scribble(xx, yy, "[fa_left][spr_creditsfont][c_white]" + string(variables[i]));
        yy += 30;
    }
}
