if (place_meeting(x, y, obj_player) && dothing == false)
{
    dothing = true;
    sprite_index = spr_secretportal_closing;
    image_index = 0;
    state = secretstates.exist;
    ds_list_add(global.saveroom, id);
}

if (dothing)
{
    switch (state)
    {
        case secretstates.exist:
            with (obj_player)
            {
                x = other.x;
                y = other.y;
                state = states.actor;
            }
            
            if (animation_end())
            {
                image_speed = 0;
                
                with (obj_player)
                {
                    targetRoom = other.targetRoom;
                    targetDoor = "NAN";
                }
                
                instance_create_depth(0, 0, depth, obj_fadeout);
                state = secretstates.disappear;
            }
            
            break;
    }
}
