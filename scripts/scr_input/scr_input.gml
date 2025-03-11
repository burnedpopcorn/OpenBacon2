function scr_tufekinput()
{
    ini_open("options.ini");
    global.key_left = [ini_read_real("Keyboard", "Left", 37), ini_read_real("Controller", "Left", 32783)];
    global.key_up = [ini_read_real("Keyboard", "Up", 38), ini_read_real("Controller", "Up", 32781)];
    global.key_down = [ini_read_real("Keyboard", "Down", 40), ini_read_real("Controller", "Down", 32782)];
    global.key_right = [ini_read_real("Keyboard", "Right", 39), ini_read_real("Controller", "Right", 32784)];
    global.key_jump = [ini_read_real("Keyboard", "Jump", 90), ini_read_real("Controller", "Jump", 32769)];
    global.key_attack = [ini_read_real("Keyboard", "Attack", 16), ini_read_real("Controller", "Attack", 32771)];
    global.key_slap = [ini_read_real("Keyboard", "Slap", 88), ini_read_real("Controller", "Slap", 32772)];
    global.key_taunt = [ini_read_real("Keyboard", "Boomerang", 67), ini_read_real("Controller", "Boomerang", 32770)];
    global.key_start = [ini_read_real("Keyboard", "Start", 27), ini_read_real("Controller", "Start", 32778)];
    ini_close();
}

function scr_setbind(array, saved_key, saved_val, using_keyboard = false)
{
    var _key = (using_keyboard == false) ? "Keyboard" : "Controller";
    ini_open("options.ini");
    ini_write_real(_key, saved_key, saved_val);
    array[using_keyboard] = ini_read_real(_key, saved_key, saved_val);
    ini_close();
}

function scr_getinput()
{
    if (obj_shell.isOpen != true)
    {
        var _input = obj_inputcontroller.player_input[0];
        ini_open("options.ini");
        key_left = -(keyboard_check(global.key_left[0]) || gamepad_button_check(_input, global.key_left[1]) || gamepad_axis_value(_input, gp_axislh) < 0);
        key_left2 = -(keyboard_check_pressed(global.key_left[0]) || gamepad_button_check_pressed(_input, global.key_left[1]) || gamepad_axis_value(_input, gp_axislh) < 0);
        key_right = keyboard_check(global.key_right[0]) || gamepad_button_check(_input, global.key_right[1] || gamepad_axis_value(_input, gp_axislh) > 0);
        key_right2 = keyboard_check_pressed(global.key_right[0]) || gamepad_button_check_pressed(_input, global.key_right[1] || gamepad_axis_value(_input, gp_axislh) > 0);
        key_down = keyboard_check(global.key_down[0]) || gamepad_button_check(_input, global.key_down[1] || gamepad_axis_value(_input, gp_axislv) > 0.5);
        key_down2 = keyboard_check_pressed(global.key_down[0]) || gamepad_button_check_pressed(_input, global.key_down[1] || gamepad_axis_value(_input, gp_axislv) > 0.5);
        key_up = keyboard_check(global.key_up[0]) || gamepad_button_check(_input, global.key_up[1] || gamepad_axis_value(_input, gp_axislv) < 0.5);
        key_up2 = keyboard_check_pressed(global.key_up[0]) || gamepad_button_check_pressed(_input, global.key_up[1] || gamepad_axis_value(_input, gp_axislv) < 0.5);
        key_jump = keyboard_check(global.key_jump[0]) || gamepad_button_check(_input, global.key_jump[1]);
        key_jump2 = keyboard_check_pressed(global.key_jump[0]) || gamepad_button_check_pressed(_input, global.key_jump[1]);
        key_slap = keyboard_check(global.key_slap[0]) || gamepad_button_check(_input, global.key_slap[1]);
        key_slap2 = keyboard_check_pressed(global.key_slap[0]) || gamepad_button_check_pressed(_input, global.key_slap[1]);
        key_attack = keyboard_check(global.key_attack[0]) || gamepad_button_check(_input, global.key_attack[1]);
        key_attack2 = keyboard_check_pressed(global.key_attack[0]) || gamepad_button_check_pressed(_input, global.key_attack[1]);
        key_taunt = keyboard_check(global.key_taunt[0]) || gamepad_button_check(_input, global.key_taunt[1]);
        key_taunt2 = keyboard_check_pressed(global.key_taunt[0]) || gamepad_button_check_pressed(_input, global.key_taunt[1]);
        key_start = keyboard_check(global.key_start[0]) || gamepad_button_check(_input, global.key_start[1]);
        key_start2 = keyboard_check_pressed(global.key_start[0]) || gamepad_button_check_pressed(_input, global.key_start[1]);
        ini_close();
    }
}

function gamepad_check_any(device)
{
    for (var i = 32769; i < 32788; i++)
    {
        if (gamepad_button_check(device, i))
            return 1;
    }
}

function scr_getkeys(key)
{
    var _char = ord(key);
    
    switch (key)
    {
        case 37:
            _char = "LEFT";
            break;
        
        case 39:
            _char = "RIGHT";
            break;
        
        case 38:
            _char = "UP";
            break;
        
        case 40:
            _char = "DOWN";
            break;
        
        case 16:
            _char = "SHIFT";
            break;
        
        case 32:
            _char = "SPACE";
            break;
        
        case 17:
            _char = "CONTROL";
            break;
        
        case 27:
            _char = "ESCAPE";
            break;
    }
    
    return _char;
}

function scr_numtokey(key)
{
    var _realkey = 0;
    var actualkey = chr(key);
    
    switch (key)
    {
        case 38:
        case 37:
        case 27:
        case 16:
        case 32:
        case 39:
        case 40:
            _realkey = scr_getkeys(key);
            break;
        
        case 163:
            _realkey = "¢";
            break;
        
        case 222:
            _realkey = "'";
            break;
        
        case 186:
            _realkey = ":";
            break;
        
        case 190:
            _realkey = ".";
            break;
        
        case 188:
            _realkey = ",";
            break;
    }
    
    if (_realkey == 0)
        actualkey = chr(key);
    else
        actualkey = _realkey;
    
    return actualkey;
}
