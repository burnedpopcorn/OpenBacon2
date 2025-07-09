function scr_tufekinput()
{
    ini_open("options.ini");
    global.key_left = [ini_read_real("Keyboard", "Left", vk_left), ini_read_real("Controller", "Left", gp_padl)];
    global.key_up = [ini_read_real("Keyboard", "Up", vk_up), ini_read_real("Controller", "Up", gp_padu)];
    global.key_down = [ini_read_real("Keyboard", "Down", vk_down), ini_read_real("Controller", "Down", gp_padd)];
    global.key_right = [ini_read_real("Keyboard", "Right", vk_right), ini_read_real("Controller", "Right", gp_padr)];
    global.key_jump = [ini_read_real("Keyboard", "Jump", ord("Z")), ini_read_real("Controller", "Jump", gp_face1)];
    global.key_attack = [ini_read_real("Keyboard", "Attack", vk_shift), ini_read_real("Controller", "Attack", gp_face3)];
    global.key_slap = [ini_read_real("Keyboard", "Slap", ord("X")), ini_read_real("Controller", "Slap", gp_face4)];
    global.key_taunt = [ini_read_real("Keyboard", "Boomerang", ord("C")), ini_read_real("Controller", "Boomerang", gp_face2)];
    global.key_start = [ini_read_real("Keyboard", "Start", vk_escape), ini_read_real("Controller", "Start", gp_start)];
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
    for (var i = gp_face1; i < gp_axisrv; i++)
    {
        if (gamepad_button_check(device, i))
            return true;
    }
}

function scr_getkeys(key)
{
    var _char = ord(key);
    
    switch (key)
    {
        case vk_left:
            _char = "LEFT";
            break;
        
        case vk_right:
            _char = "RIGHT";
            break;
        
        case vk_up:
            _char = "UP";
            break;
        
        case vk_down:
            _char = "DOWN";
            break;
        
        case vk_shift:
            _char = "SHIFT";
            break;
        
        case vk_space:
            _char = "SPACE";
            break;
        
        case vk_control:
            _char = "CONTROL";
            break;
        
        case vk_escape:
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
        case vk_up:
        case vk_left:
        case vk_escape:
        case vk_shift:
        case vk_space:
        case vk_right:
        case vk_down:
            _realkey = scr_getkeys(key);
            break;
        
		// uhhhh
		// these idk, but i don't think they're used anyways
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
