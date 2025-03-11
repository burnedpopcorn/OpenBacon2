function scribble_color_set(argument0, argument1)
{
    static _colourDict = __scribble_config_colours();
    
    if (argument1 == undefined)
    {
        if (variable_struct_exists(_colourDict, argument0))
        {
            variable_struct_remove(_colourDict, argument0);
            scribble_refresh_everything();
        }
    }
    else if (!is_numeric(argument1))
    {
        __scribble_error("Colour values should be 24-bit BGR values");
    }
    else if (variable_struct_get(_colourDict, argument0) != argument1)
    {
        variable_struct_set(_colourDict, argument0, argument1);
        scribble_refresh_everything();
    }
}
