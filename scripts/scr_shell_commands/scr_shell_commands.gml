function meta_escape()
{
    return 
    {
        arguments: ["bool", "minutes", "seconds"],
        suggestions: [["true", "false"]],
        description: "enables escape sequence"
    };
}

function sh_escape(is_escaping)
{
    if (is_escaping[1] == "true")
        global.escape = true;
    else if (is_escaping[1] == "false")
        global.escape = false;
    else if (!is_bool(is_escaping[1]))
        global.escape = !global.escape;
    
    global.fill = [is_escaping[2], is_escaping[3], 60];
    
    if (global.escape)
    {
        instance_create_depth(x, y, -500, obj_flash);
        instance_create_depth(x, y, -300, obj_sigmasigma);
    }
}

function meta_set_combo()
{
    return 
    {
        arguments: ["value"],
        description: "sets your combo"
    };
}

function sh_set_combo(combo)
{
    var val = real(combo[1]);
    
    if (!is_string(val))
    {
        global.combo = val;
        global.combotime = 60;
    }
}

function meta_toggle_collisions()
{
    return 
    {
        arguments: ["bool"],
        suggestions: [["true", "false"]],
        description: "toggles collisions"
    };
}

function sh_toggle_collisions(vis_collisions)
{
    if (vis_collisions[1] == "true")
        global.showcollisions = true;
    else if (vis_collisions[1] == "false")
        global.showcollisions = false;
    else if (!is_bool(vis_collisions[1]))
        global.showcollisions = !global.showcollisions;
}

function meta_toggle_debug()
{
    return 
    {
        arguments: ["bool"],
        suggestions: [["true", "false"]],
        description: "toggles debugging mode"
    };
}

function sh_toggle_debug(debug_enabled)
{
    if (debug_enabled[1] == "true")
        global.debug = true;
    else if (debug_enabled[1] == "false")
        global.debug = false;
    else if (!is_bool(debug_enabled[1]))
        global.debug = !global.debug;
}
