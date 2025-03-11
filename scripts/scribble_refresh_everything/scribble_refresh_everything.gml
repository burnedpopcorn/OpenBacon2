function scribble_refresh_everything()
{
    with (__scribble_get_cache_state())
    {
        var _i = 0;
        
        repeat (array_length(__ecache_array))
        {
            __ecache_array[_i].refresh();
            _i++;
        }
    }
}
