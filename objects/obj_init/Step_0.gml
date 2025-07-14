scr_getinput();

if (key_jump2)
{
    with (instance_create_depth(x, y, 0, obj_fadeout))
        targetRoom = hub_hallway;
}

if (keyboard_check_pressed(vk_f6))
    show_debug_overlay(true);