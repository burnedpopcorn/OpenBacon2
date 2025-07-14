if (other.key_up2 && other.state == states.normal && other.grounded)
{
    with (other)
    {
        global.level = other.level;
        global.leveltorestart = other.targetRoom;
        targetRoom = other.targetRoom;
        hubgotoroom = room;
        hubgotox = x;
        hubgotoy = y;
        targetDoor = "A";
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = states.enterdoor;
        ds_list_clear(global.saveroom);
        sprite_index = spr_player_entergate;
        image_index = 0;
        audio_stop_all();
        obj_music.lock = true;
    }
}

if (other.sprite_index == spr_player_entergate && other.state == states.enterdoor && other.image_index == (other.image_number - 1) && !instance_exists(obj_fadeout))
    instance_create_depth(x, y, 0, obj_fadeout);
