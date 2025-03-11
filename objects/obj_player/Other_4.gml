var _door = asset_get_index("obj_door" + targetDoor);

if (instance_exists(_door))
{
    var pad = hallway ? (192 * hallwaydirection) : 16;
    x = _door.x + pad;
    y = _door.y - 14;
}

if (place_meeting(x, y, obj_exitgate) || place_meeting(x, y, obj_levelgate))
{
    if (global.level != "none")
        obj_music.lock = true;
    
    state = states.walkfront;
    c = c_black;
    image_index = 0;
    sprite_index = spr_player_walkfront;
}

if (instance_exists(obj_pizzaface))
{
    with (obj_pizzaface)
    {
        x = obj_player.x;
        y = obj_player.y;
        image_alpha = 0;
    }
}

roomstartx = x;
roomstarty = y;
hallway = false;
