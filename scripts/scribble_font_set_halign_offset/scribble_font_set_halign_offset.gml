function scribble_font_set_halign_offset(argument0, argument1, argument2)
{
    if (argument1 == "pin_left")
        argument1 = 3;
    
    if (argument1 == "pin_centre")
        argument1 = 4;
    
    if (argument1 == "pin_center")
        argument1 = 4;
    
    if (argument1 == "pin_right")
        argument1 = 5;
    
    if (argument1 == "fa_justify")
        argument1 = 6;
    
    __scribble_error("Please set SCRIBBLE_USE_FONT_ALIGNMENT_OFFSETS to <true> to use this feature");
    __scribble_get_font_data(argument0).__halign_offset_array[argument1] = argument2;
}
