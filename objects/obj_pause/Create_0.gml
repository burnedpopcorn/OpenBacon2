scr_tufekinput();
active = false;
selected = 0;
screensprite = -4;
guisprite = -4;
border1pos = [-160, 384];
border2pos = [704, 384];
gradientpos = 540;
options = ds_list_create();
snoozes = ds_list_create();
pausemu = mu_pause;

function create_option(_option, _func)
{
    var _opt = 
    {
        option: _option,
        func: _func
    };
    ds_list_add(options, _opt);
    show_debug_message(_opt);
    return _opt;
}

function create_snooze()
{
    var _sn = 
    {
        image_index: irandom_range(0, sprite_get_number(spr_pause_zs)),
        x: random_range(200, 760),
        y: 570,
        image_alpha: 1
    };
    ds_list_add(snoozes, _sn);
    show_debug_message(_sn);
    return _sn;
}

function update_snooze()
{
    if (!ds_list_empty(snoozes))
    {
        for (var i = 0; i < ds_list_size(snoozes); i++)
        {
            var q = ds_list_find_value(snoozes, i);
            
            if (is_struct(q))
            {
                q.y -= 1;
                q.image_index += 1/30;
                
                if (q.y < 270)
                    q.image_alpha -= 0.01;
                
                if (q.image_alpha <= 0)
                {
                    ds_list_delete(snoozes, i);
                    i--;
                }
                
                draw_sprite_ext(spr_pause_zs, q.image_index, q.x, q.y, 1, 1, 0, c_white, q.image_alpha);
            }
        }
    }
}

create_option("RESUME", function()
{
    instance_activate_all();
    audio_resume_all();
    audio_stop_sound(pausemu);
    active = 0;
});
create_option("OPTIONS", function()
{
    instance_create_depth(0, 0, depth - 1, obj_option);
});
create_option("RESTART", function()
{
    if (global.leveltorestart != -4)
    {
        instance_activate_all();
        player_reset();
        
        if (instance_exists(obj_pizzaface))
            instance_destroy(obj_pizzaface);
        
        obj_player.movespeed = 0;
        obj_player.hsp = 0;
        obj_player.vsp = 0;
        room = global.leveltorestart;
        active = 0;
        
        with (obj_music)
        {
            audio_stop_all();
            currentmusic = -4;
            global.music = -4;
        }
    }
});
create_option("EXIT LEVEL", function()
{
    if (global.level != "none")
    {
        instance_activate_all();
        player_reset();
        
        if (instance_exists(obj_pizzaface))
            instance_destroy(obj_pizzaface);
        
        global.leveltorestart = -4;
        obj_player.movespeed = 0;
        obj_player.hsp = 0;
        obj_player.vsp = 0;
        room = obj_player.hubgotoroom;
        obj_player.x = obj_player.hubgotox;
        obj_player.y = obj_player.hubgotoy + 14;
        obj_player.targetDoor = "HUB";
        global.level = "none";
        obj_music.lock = false;
        obj_camera.lock = false;
        
        with (obj_music)
        {
            audio_stop_all();
            currentmusic = -4;
            global.music = -4;
        }
        
        active = 0;
    }
});
alarm[0] = 60;
