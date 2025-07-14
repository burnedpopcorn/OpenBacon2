scr_tufekinput();
menus = [];
currentmenu = 0;
selected = 0;
move = 0;
backgrounds = [[0, 1], [1, 0], [2, 0], [4, 0], [3, 0]];
BGX = wave(-32, 32, 5, 0);
BGY = 0;
slidersnd = sfx_collectbig;

enum option
{
	// menus
	main,
	audio,
	video,
	controls,
	game,
	
	// for display
	anchor_center,
	anchor_left
}

#region Menu Functions
function goto_menu(menu)
{
    for (var i = 0; i < array_length(menus); i++)
    {
        var m = menus[i];
        
        if (m.menuid == menu)
            currentmenu = i;
    }
    
    selected = 0;
}

function create_menu(menu, hplacement, _y, func)
{
    var _opt = 
    {
        menuid: menu,
        anchor: hplacement,
        ypad: _y,
        options: [],
        backfunc: func
    };
    return _opt;
}

function add_option_press(_option, _name, _func)
{
    var q = 
    {
        name: _name,
        func: _func,
        type: 0
    };
    array_push(_option.options, q);
    return q;
}

function add_option_ext(_option, _type, _name, _func, _val, _maxval, _toggle = ["OFF", "ON"])
{
    var q = 
    {
        name: _name,
        func: _func,
        val: _val,
        toggle: _toggle,
        type: _type,
        max: _maxval,
        moving: false
    };
    array_push(_option.options, q);
    return q;
}
#endregion

#region Main Menu
var category = create_menu(option.main, option.anchor_center, 48, function()
{
    instance_destroy();
});
add_option_press(category, "AUDIO", function()
{
    goto_menu(option.audio);
});
add_option_press(category, "VIDEO", function()
{
    goto_menu(option.video);
});
add_option_press(category, "CONTROLS", function()
{
    goto_menu(option.controls);
});
add_option_press(category, "GAME", function()
{
    goto_menu(option.game);
});
array_push(menus, category);
#endregion

#region Audio Submenu
var AUDIO = create_menu(option.audio, option.anchor_left, 48, function()
{
    goto_menu(option.main);
});
add_option_press(AUDIO, "BACK", function()
{
    goto_menu(option.main);
});
add_option_ext(AUDIO, 2, "MASTER", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.MasterVolume = q.val / 100;
    q.val = global.MasterVolume * 100;
    quick_save("General", "Master", global.MasterVolume);
	
	audio_master_gain(global.MasterVolume);
}, global.MasterVolume * 100, 100);
add_option_ext(AUDIO, 2, "MUSIC", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.MusicVolume = q.val / 100;
    q.val = global.MusicVolume * 100;
    quick_save("General", "Music", global.MusicVolume);
	
	audio_group_set_gain(audiogroup_mus, global.MusicVolume, 0);
}, global.MusicVolume * 100, 100);
add_option_ext(AUDIO, 2, "SFX", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.SfxVolume = q.val / 100;
    q.val = global.SfxVolume * 100;
    quick_save("General", "Sfx", global.SfxVolume);
	
	audio_group_set_gain(audiogroup_sfx, global.SfxVolume, 0);
}, global.SfxVolume * 100, 100);
array_push(menus, AUDIO);
#endregion
#region Video Submenu
var VIDEO = create_menu(option.video, option.anchor_left, 48, function()
{
    goto_menu(option.main);
});
add_option_press(VIDEO, "BACK", function()
{
    goto_menu(option.main);
});
add_option_ext(VIDEO, 1, "FULLSCREEN", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.Fullscreen = q.val;
    window_set_fullscreen(global.Fullscreen);
    q.val = global.Fullscreen;
    quick_save("General", "Fullscreen", global.Fullscreen);
}, global.Fullscreen, 1);
add_option_ext(VIDEO, 1, "VSYNC", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.Vsync = q.val;
    display_reset(0, global.Vsync);
    q.val = global.Vsync;
    quick_save("General", "Vsync", global.Vsync);
}, global.Vsync, 1);
array_push(menus, VIDEO);
#endregion
#region Controls Submenu (Unimplimented)
var CONTROLS = create_menu(option.controls, option.anchor_left, 48, function()
{
    goto_menu(option.main);
});
add_option_press(CONTROLS, "BACK", function()
{
    goto_menu(option.main);
});
array_push(menus, CONTROLS);
#endregion
#region Game Submenu (Unimplimented)
var GAME = create_menu(option.game, option.anchor_left, 48, function()
{
    goto_menu(option.main);
});
add_option_press(GAME, "BACK", function()
{
    goto_menu(option.main);
});
array_push(menus, GAME);
#endregion
