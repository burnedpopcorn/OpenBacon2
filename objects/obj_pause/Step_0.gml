scr_getinput();
var accel = active ? 0.05 : 0.2;
border1pos[0] = lerp(border1pos[0], active ? 0 : -160, accel);
border2pos[0] = lerp(border2pos[0], active ? 576 : 704, accel);
border1pos[1] = lerp(border1pos[1], active ? 224 : 384, accel);
border2pos[1] = lerp(border2pos[1], active ? 224 : 384, accel);
gradientpos = lerp(gradientpos, active ? 0 : 540, accel);

if (key_start2 && !active)
{
    audio_pause_all();
    active = true;
    screensprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
    var surface = surface_create(960, 540);
    
    if (surface_exists(surface))
    {
        surface_set_target(surface);
        
        with (obj_camera)
        {
            if (visible)
                event_perform(ev_draw, ev_gui);
        }
        
        with (obj_fadeout)
        {
            if (visible)
                event_perform(ev_draw, ev_gui);
        }
        
        with (obj_combotitle)
        {
            if (visible)
                event_perform(ev_draw, ev_gui);
        }
        
        with (obj_tv)
        {
            if (visible)
                event_perform(ev_draw, ev_gui);
        }
        
        with (obj_sigmasigma)
        {
            if (visible)
                event_perform(ev_draw, ev_gui);
        }
        
        surface_reset_target();
        guisprite = sprite_create_from_surface(surface, 0, 0, 960, 540, false, false, 0, 0);
        surface_free(surface);
    }
    
    instance_deactivate_all(true);
    instance_activate_object(obj_inputcontroller);
    instance_activate_object(obj_shell);
    audio_pause_all();
    
	if (!audio_is_playing(pausemu))
		scr_music(pausemu);
		
	//audio_pause_sound(pausemu);
}

if (active == 1 && !instance_exists(obj_option))
{
    if (key_down2)
    {
        if (selected < (ds_list_size(options) - 1))
            selected++;
        else
            selected = 0;
    }
    
    if (key_up2)
    {
        if (selected > 0)
            selected--;
        else
            selected = ds_list_size(options) - 1;
    }
    
    if (key_jump2)
    {
        if (!ds_list_empty(options))
        {
            for (var i = 0; i < ds_list_size(options); i++)
            {
                var q = ds_list_find_value(options, i);
                
                if (is_struct(q))
                {
                    if (selected == i)
                        q.func();
                }
            }
        }
    }
}
