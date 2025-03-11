gameframe_update();

if (gameframe_mouse_in_window())
{
    if (mouse_in_window == false)
    {
        mouse_in_window = true;
        gameframe_visible_time = 180;
        mouseX = window_mouse_get_x();
        mouseY = window_mouse_get_y();
    }
    
    if (window_mouse_get_x() != mouseX || window_mouse_get_y() != mouseY)
        mouse_in_window = false;
}
else if (mouse_in_window == true)
    mouse_in_window = false;

if (gameframe_visible_time > 0)
{
    gameframe_visible_time--;
    global.gameframe_alpha = approach(global.gameframe_alpha, 1, 0.1);
}
else
    global.gameframe_alpha = approach(global.gameframe_alpha, 0, 0.1);

__display_set_gui_size_hook(displayWidth, displayHeight);
view_set_wport(view_camera[view_current], displayWidth);
view_set_hport(view_camera[view_current], displayHeight);
camera_set_view_size(view_camera[view_current], displayWidth, displayHeight);

if (keyboard_check_pressed(vk_f6))
    show_debug_overlay(true);
