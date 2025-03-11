scr_getinput();

if (key_jump2)
    with (instance_create_depth(x, y, 0, obj_fadeout))
        targetRoom = hub_hallway;
