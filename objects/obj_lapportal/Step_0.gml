if (cutscene == true)
{
    switch (part)
    {
        case 0:
            obj_player.x = lerp(obj_player.x, x + 70.4, 0.1);
            obj_player.y = lerp(obj_player.y, y, 0.1);
            global.combotime = 60;
            
            with (obj_player)
            {
                if (animation_end())
                {
                    ds_list_clear(global.escaperoom);
                    image_speed = 0;
                    other.part++;
                    targetDoor = "S";
                    hallway = false;
                    targetRoom = other.targetRoom;
                    instance_create_depth(x, y, 0, obj_fadeout);
                }
            }
            
            break;
    }
}
