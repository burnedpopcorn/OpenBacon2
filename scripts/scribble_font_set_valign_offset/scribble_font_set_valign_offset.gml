function scribble_font_set_valign_offset(argument0, argument1, argument2)
{
    __scribble_error("Please set SCRIBBLE_USE_FONT_ALIGNMENT_OFFSETS to <true> to use this feature");
    __scribble_get_font_data(argument0).__valign_offset_array[argument1] = argument2;
}
