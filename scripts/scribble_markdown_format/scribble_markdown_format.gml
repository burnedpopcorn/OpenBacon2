function scribble_markdown_format(argument0)
{
    static _func_delete_buffer = function(argument0, argument1, argument2, argument3 = buffer_tell(argument0) - 2)
    {
        static _buffer_b = __scribble_get_buffer_b();
        
        var _copy_pos = argument3 + argument2;
        var _copy_size = argument1 - _copy_pos;
        buffer_copy(argument0, _copy_pos, _copy_size, _buffer_b, 0);
        buffer_copy(_buffer_b, 0, _copy_size, argument0, argument3);
        buffer_seek(argument0, buffer_seek_relative, -1);
        return -argument2;
    };
    
    static _func_insert_buffer = function(argument0, argument1, argument2, argument3 = buffer_tell(argument0) - 2)
    {
        static _buffer_b = __scribble_get_buffer_b();
        
        var _insert_size = string_byte_length(argument2);
        
        if (_insert_size <= 0)
            return 0;
        
        var _copy_size = argument1 - argument3;
        var _recopy_size = _insert_size + _copy_size;
        buffer_poke(_buffer_b, 0, buffer_text, argument2);
        buffer_copy(argument0, argument3, _copy_size, _buffer_b, _insert_size);
        buffer_copy(_buffer_b, 0, _recopy_size, argument0, argument3);
        buffer_seek(argument0, buffer_seek_relative, _insert_size - 1);
        return _insert_size;
    };
    
    static _func_delete_and_insert_buffer = function(argument0, argument1, argument2, argument3 = "", argument4 = buffer_tell(argument0) - 2)
    {
        static _buffer_b = __scribble_get_buffer_b();
        
        var _copy_pos = argument4 + argument2;
        var _copy_size = argument1 - _copy_pos;
        var _insert_size = string_byte_length(argument3);
        var _recopy_size = _insert_size + _copy_size;
        buffer_poke(_buffer_b, 0, buffer_text, argument3);
        buffer_copy(argument0, _copy_pos, _copy_size, _buffer_b, _insert_size);
        buffer_copy(_buffer_b, 0, _recopy_size, argument0, argument4);
        buffer_seek(argument0, buffer_seek_relative, _insert_size - 1);
        return _insert_size - argument2;
    };
    
    static _empty_struct = {};
    static _buffer = __scribble_get_buffer_a();
    
    __scribble_initialize();
    var _fallback_styles_struct = 
    {
        body: {},
        header1: 
        {
            bold: true,
            italic: true,
            scale: 1.6
        },
        header2: 
        {
            bold: true,
            scale: 1.4
        },
        header3: 
        {
            italic: true,
            scale: 1.2
        },
        quote: 
        {
            color: #E7E7E7,
            italic: true,
            scale: 0.9,
            prefix: "  "
        },
        bold: 
        {
            bold: true
        },
        italic: 
        {
            italic: true
        },
        bold_italic: 
        {
            bold: true,
            italic: true
        },
        bullet_sprite: scribble_fallback_bulletpoint,
        link: 
        {
            bold: true,
            color: #DF9FFF
        }
    };
    var _markdown_styles_struct = __scribble_get_state().__markdown_styles_struct;
    buffer_seek(_buffer, buffer_seek_start, 0);
    buffer_write(_buffer, buffer_string, argument0);
    var _buffer_size = buffer_tell(_buffer);
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _old_style = undefined;
    var _new_style = "body";
    var _write_style = true;
    var _newline = true;
    var _indent = false;
    var _in_link = false;
    var _prev_value = 0;
    var _value = 0;
    var _next_value = buffer_read(_buffer, buffer_u8);
    
    while (1)
    {
        if (_next_value == 0)
            break;
        
        _value = _next_value;
        _next_value = buffer_read(_buffer, buffer_u8);
        
        if (_value == 10 || _value == 13)
        {
            _newline = true;
            
            if (_indent)
            {
                _indent = false;
                _buffer_size += _func_insert_buffer(_buffer, _buffer_size, "[/indent]", buffer_tell(_buffer) - 2);
                _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
            }
            
            if (!_write_style && (_old_style == "quote" || _old_style == "header1" || _old_style == "header2" || _old_style == "header3"))
            {
                _new_style = "body";
                _write_style = true;
            }
            
            continue;
        }
        
        if (_newline)
        {
            if (_value == 62 && _next_value == 32)
            {
                _new_style = "quote";
                
                if (_old_style != _new_style)
                {
                    _write_style = true;
                    
                    if (_write_style)
                    {
                        _write_style = false;
                        var _old_style_struct = (_old_style == undefined) ? _empty_struct : (variable_struct_get(_markdown_styles_struct, _old_style) ?? variable_struct_get(_fallback_styles_struct, _old_style));
                        var _new_style_struct = variable_struct_get(_markdown_styles_struct, _new_style) ?? variable_struct_get(_fallback_styles_struct, _new_style);
                        var _insert_string = struct_get_from_hash(_old_style_struct, variable_get_hash("suffix")) ?? "";
                        var _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("font"));
                        var _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("font"));
                        
                        if (_old_value != _new_value)
                            _insert_string += ((_new_value == undefined) ? "[/font]" : ("[" + _new_value + "]"));
                        
                        _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("scale")) ?? 1;
                        _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("scale")) ?? 1;
                        
                        if (_old_value != _new_value)
                            _insert_string += ((_new_value == 1) ? "[/scale]" : ("[scale," + string(_new_value) + "]"));
                        
                        _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("color"));
                        _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("color"));
                        
                        if (_old_value != _new_value)
                            _insert_string += ((_new_value == undefined) ? "[/color]" : ("[d#" + string(_new_value) + "]"));
                        
                        _old_value = (struct_get_from_hash(_old_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_old_style_struct, variable_get_hash("bold")) ?? 0));
                        _new_value = (struct_get_from_hash(_new_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_new_style_struct, variable_get_hash("bold")) ?? 0));
                        
                        if (_old_value != _new_value)
                        {
                            if (_new_value == 0)
                            {
                                if (_old_value == 1)
                                    _insert_string += "[/i]";
                                else if (_old_value == 2)
                                    _insert_string += "[/b]";
                                else if (_old_value == 3)
                                    _insert_string += "[/bi]";
                            }
                            else if (_new_value == 1)
                            {
                                _insert_string += "[i]";
                            }
                            else if (_new_value == 2)
                            {
                                _insert_string += "[b]";
                            }
                            else if (_new_value == 3)
                            {
                                _insert_string += "[bi]";
                            }
                        }
                        
                        _insert_string += (struct_get_from_hash(_new_style_struct, variable_get_hash("prefix")) ?? "");
                        _buffer_size += _func_insert_buffer(_buffer, _buffer_size, _insert_string);
                        _old_style = _new_style;
                    }
                    
                    buffer_seek(_buffer, buffer_seek_relative, 1);
                }
                
                if (_indent)
                {
                    __scribble_trace("Warning! Found stacked indentation");
                    _buffer_size += _func_delete_buffer(_buffer, _buffer_size, 2);
                }
                else
                {
                    _indent = true;
                    _buffer_size += _func_delete_and_insert_buffer(_buffer, _buffer_size, 2, "[indent]");
                }
                
                _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
                _newline = false;
                continue;
            }
            else if (_value == 35)
            {
                var _header_level = 1;
                var _header_peek = buffer_tell(_buffer) - 1;
                
                while (1)
                {
                    var _header_next_value = buffer_peek(_buffer, _header_peek, buffer_u8);
                    
                    if (_header_next_value == 0)
                    {
                        _header_level = 0;
                        break;
                    }
                    else if (_header_next_value == 32)
                    {
                        break;
                    }
                    else if (_header_next_value != 35)
                    {
                        _header_level = 0;
                        break;
                    }
                    
                    _header_level++;
                    _header_peek++;
                }
                
                if (_header_level > 0)
                {
                    if (_header_level == 1)
                        _new_style = "header1";
                    else if (_header_level == 2)
                        _new_style = "header2";
                    else if (_header_level >= 3)
                        _new_style = "header3";
                    
                    if (_old_style != _new_style)
                        _write_style = true;
                    
                    _buffer_size += _func_delete_buffer(_buffer, _buffer_size, _header_level + 1);
                    _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
                    _newline = false;
                    continue;
                }
            }
            else if ((_value == 45 || _value == 42) && _next_value == 32)
            {
                _new_style = "body";
                
                if (_old_style != _new_style)
                {
                    _write_style = true;
                    
                    if (_write_style)
                    {
                        _write_style = false;
                        var _old_style_struct = (_old_style == undefined) ? _empty_struct : (variable_struct_get(_markdown_styles_struct, _old_style) ?? variable_struct_get(_fallback_styles_struct, _old_style));
                        var _new_style_struct = variable_struct_get(_markdown_styles_struct, _new_style) ?? variable_struct_get(_fallback_styles_struct, _new_style);
                        var _insert_string = struct_get_from_hash(_old_style_struct, variable_get_hash("suffix")) ?? "";
                        var _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("font"));
                        var _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("font"));
                        
                        if (_old_value != _new_value)
                            _insert_string += ((_new_value == undefined) ? "[/font]" : ("[" + _new_value + "]"));
                        
                        _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("scale")) ?? 1;
                        _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("scale")) ?? 1;
                        
                        if (_old_value != _new_value)
                            _insert_string += ((_new_value == 1) ? "[/scale]" : ("[scale," + string(_new_value) + "]"));
                        
                        _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("color"));
                        _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("color"));
                        
                        if (_old_value != _new_value)
                            _insert_string += ((_new_value == undefined) ? "[/color]" : ("[d#" + string(_new_value) + "]"));
                        
                        _old_value = (struct_get_from_hash(_old_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_old_style_struct, variable_get_hash("bold")) ?? 0));
                        _new_value = (struct_get_from_hash(_new_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_new_style_struct, variable_get_hash("bold")) ?? 0));
                        
                        if (_old_value != _new_value)
                        {
                            if (_new_value == 0)
                            {
                                if (_old_value == 1)
                                    _insert_string += "[/i]";
                                else if (_old_value == 2)
                                    _insert_string += "[/b]";
                                else if (_old_value == 3)
                                    _insert_string += "[/bi]";
                            }
                            else if (_new_value == 1)
                            {
                                _insert_string += "[i]";
                            }
                            else if (_new_value == 2)
                            {
                                _insert_string += "[b]";
                            }
                            else if (_new_value == 3)
                            {
                                _insert_string += "[bi]";
                            }
                        }
                        
                        _insert_string += (struct_get_from_hash(_new_style_struct, variable_get_hash("prefix")) ?? "");
                        _buffer_size += _func_insert_buffer(_buffer, _buffer_size, _insert_string);
                        _old_style = _new_style;
                    }
                    
                    buffer_seek(_buffer, buffer_seek_relative, 1);
                }
                
                var _bullet_sprite = struct_get_from_hash(_markdown_styles_struct, variable_get_hash("bullet_sprite"));
                
                if (_indent)
                {
                    __scribble_trace("Warning! Found stacked indentation");
                    _buffer_size += _func_delete_and_insert_buffer(_buffer, _buffer_size, 2, (_bullet_sprite == undefined) ? "- " : ("[" + sprite_get_name(_bullet_sprite) + "] "));
                }
                else
                {
                    _indent = true;
                    _buffer_size += _func_delete_and_insert_buffer(_buffer, _buffer_size, 2, (_bullet_sprite == undefined) ? "- [indent]" : ("[" + sprite_get_name(_bullet_sprite) + "] [indent]"));
                }
                
                _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
                _newline = false;
                continue;
            }
            else if (_value >= 48 && _value <= 57)
            {
                var _number_size = 1;
                var _number_peek = buffer_tell(_buffer) - 1;
                
                while (1)
                {
                    var _number_next_value = buffer_peek(_buffer, _number_peek, buffer_u8);
                    
                    if (_number_next_value == 0)
                    {
                        _number_size = 0;
                        break;
                    }
                    else if (_number_next_value == 46 || _number_next_value == 41)
                    {
                        break;
                    }
                    else if (_number_next_value < 48 || _number_next_value > 57)
                    {
                        _number_size = 0;
                        break;
                    }
                    
                    _number_size++;
                    _number_peek++;
                }
                
                if (_number_size > 0)
                {
                    _new_style = "body";
                    
                    if (_old_style != _new_style)
                    {
                        _write_style = true;
                        
                        if (_write_style)
                        {
                            _write_style = false;
                            var _old_style_struct = (_old_style == undefined) ? _empty_struct : (variable_struct_get(_markdown_styles_struct, _old_style) ?? variable_struct_get(_fallback_styles_struct, _old_style));
                            var _new_style_struct = variable_struct_get(_markdown_styles_struct, _new_style) ?? variable_struct_get(_fallback_styles_struct, _new_style);
                            var _insert_string = struct_get_from_hash(_old_style_struct, variable_get_hash("suffix")) ?? "";
                            var _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("font"));
                            var _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("font"));
                            
                            if (_old_value != _new_value)
                                _insert_string += ((_new_value == undefined) ? "[/font]" : ("[" + _new_value + "]"));
                            
                            _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("scale")) ?? 1;
                            _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("scale")) ?? 1;
                            
                            if (_old_value != _new_value)
                                _insert_string += ((_new_value == 1) ? "[/scale]" : ("[scale," + string(_new_value) + "]"));
                            
                            _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("color"));
                            _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("color"));
                            
                            if (_old_value != _new_value)
                                _insert_string += ((_new_value == undefined) ? "[/color]" : ("[d#" + string(_new_value) + "]"));
                            
                            _old_value = (struct_get_from_hash(_old_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_old_style_struct, variable_get_hash("bold")) ?? 0));
                            _new_value = (struct_get_from_hash(_new_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_new_style_struct, variable_get_hash("bold")) ?? 0));
                            
                            if (_old_value != _new_value)
                            {
                                if (_new_value == 0)
                                {
                                    if (_old_value == 1)
                                        _insert_string += "[/i]";
                                    else if (_old_value == 2)
                                        _insert_string += "[/b]";
                                    else if (_old_value == 3)
                                        _insert_string += "[/bi]";
                                }
                                else if (_new_value == 1)
                                {
                                    _insert_string += "[i]";
                                }
                                else if (_new_value == 2)
                                {
                                    _insert_string += "[b]";
                                }
                                else if (_new_value == 3)
                                {
                                    _insert_string += "[bi]";
                                }
                            }
                            
                            _insert_string += (struct_get_from_hash(_new_style_struct, variable_get_hash("prefix")) ?? "");
                            _buffer_size += _func_insert_buffer(_buffer, _buffer_size, _insert_string);
                            _old_style = _new_style;
                        }
                        
                        buffer_seek(_buffer, buffer_seek_relative, 1);
                    }
                    
                    buffer_seek(_buffer, buffer_seek_relative, _number_size + 2);
                    
                    if (_indent)
                    {
                        __scribble_trace("Warning! Found stacked indentation");
                    }
                    else
                    {
                        _indent = true;
                        _buffer_size += _func_insert_buffer(_buffer, _buffer_size, "[indent]");
                    }
                    
                    _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
                    _prev_value = 32;
                }
                
                _newline = false;
                continue;
            }
            
            if (_value <= 32)
                continue;
            
            _newline = false;
        }
        
        if (_value == 42)
        {
            var _delete_size;
            
            if (_next_value == 42)
            {
                if (_new_style == "body")
                    _new_style = "bold";
                else if (_new_style == "bold")
                    _new_style = "body";
                else if (_new_style == "italic")
                    _new_style = "bold_italic";
                else if (_new_style == "bold_italic")
                    _new_style = "italic";
                
                if (_old_style != _new_style)
                    _write_style = true;
                
                _delete_size = 2;
            }
            else
            {
                if (_new_style == "body")
                    _new_style = "italic";
                else if (_new_style == "italic")
                    _new_style = "body";
                else if (_new_style == "bold")
                    _new_style = "bold_italic";
                else if (_new_style == "bold_italic")
                    _new_style = "bold";
                
                if (_old_style != _new_style)
                    _write_style = true;
                
                _delete_size = 1;
            }
            
            _buffer_size += _func_delete_buffer(_buffer, _buffer_size, _delete_size);
            _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
        }
        else if (_value == 95 && (_prev_value <= 32 || _next_value <= 32))
        {
            if (_new_style == "body")
                _new_style = "italic";
            else if (_new_style == "italic")
                _new_style = "body";
            else if (_new_style == "bold")
                _new_style = "bold_italic";
            else if (_new_style == "bold_italic")
                _new_style = "bold";
            
            if (_old_style != _new_style)
                _write_style = true;
            
            _buffer_size += _func_delete_buffer(_buffer, _buffer_size, 1);
            _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
        }
        else if (_value == 33 && _next_value == 91)
        {
            _buffer_size += _func_delete_buffer(_buffer, _buffer_size, 1);
            _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
        }
        else if (_value == 92)
        {
            if (_next_value == 0)
                exit;
            
            _buffer_size += _func_delete_buffer(_buffer, _buffer_size, 1);
            buffer_seek(_buffer, buffer_seek_relative, 1);
            _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
        }
        else if (_in_link && _value == 93 && _next_value == 40)
        {
            _buffer_size += _func_delete_and_insert_buffer(_buffer, _buffer_size, 2, "[/region]");
            _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
            _new_style = "body";
            
            if (_old_style != _new_style)
                _write_style = true;
            
            _in_link = false;
        }
        else
        {
            if (!_in_link && _value == 91)
            {
                var _is_link = false;
                var _link_size = 1;
                var _link_start = buffer_tell(_buffer) - 2;
                var _link_peek = _link_start + 1;
                
                while (1)
                {
                    var _link_next_value = buffer_peek(_buffer, _link_peek, buffer_u8);
                    
                    if (_link_next_value == 0)
                    {
                        break;
                    }
                    else if (_link_next_value == 93)
                    {
                        _link_peek++;
                        
                        if (buffer_peek(_buffer, _link_peek, buffer_u8) == 40)
                        {
                            _is_link = true;
                            break;
                        }
                        
                        _link_size++;
                    }
                    else
                    {
                        _link_size++;
                        _link_peek++;
                    }
                }
                
                if (_is_link)
                {
                    _is_link = false;
                    var _region_start = _link_peek + 1;
                    var _region_end;
                    
                    for (_region_end = _region_start; 1; _region_end++)
                    {
                        var _region_next_value = buffer_peek(_buffer, _region_end, buffer_u8);
                        
                        if (_region_next_value == 0 || _region_next_value == 41)
                            break;
                    }
                    
                    buffer_poke(_buffer, _region_end, buffer_u8, 0);
                    var _region_name = buffer_peek(_buffer, _region_start, buffer_string);
                    _buffer_size += _func_delete_buffer(_buffer, _buffer_size, (1 + _region_end) - _region_start, _region_start);
                    _buffer_size += _func_insert_buffer(_buffer, _buffer_size, "region," + _region_name + "]", _link_start + 1);
                    buffer_seek(_buffer, buffer_seek_relative, 2);
                    _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
                    _in_link = true;
                    _new_style = "link";
                    
                    if (_old_style != _new_style)
                        _write_style = true;
                    
                    continue;
                }
            }
            
            _prev_value = _value;
            
            if (_value > 32)
            {
                if (_write_style)
                {
                    _write_style = false;
                    var _old_style_struct = (_old_style == undefined) ? _empty_struct : (variable_struct_get(_markdown_styles_struct, _old_style) ?? variable_struct_get(_fallback_styles_struct, _old_style));
                    var _new_style_struct = variable_struct_get(_markdown_styles_struct, _new_style) ?? variable_struct_get(_fallback_styles_struct, _new_style);
                    var _insert_string = struct_get_from_hash(_old_style_struct, variable_get_hash("suffix")) ?? "";
                    var _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("font"));
                    var _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("font"));
                    
                    if (_old_value != _new_value)
                        _insert_string += ((_new_value == undefined) ? "[/font]" : ("[" + _new_value + "]"));
                    
                    _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("scale")) ?? 1;
                    _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("scale")) ?? 1;
                    
                    if (_old_value != _new_value)
                        _insert_string += ((_new_value == 1) ? "[/scale]" : ("[scale," + string(_new_value) + "]"));
                    
                    _old_value = struct_get_from_hash(_old_style_struct, variable_get_hash("color"));
                    _new_value = struct_get_from_hash(_new_style_struct, variable_get_hash("color"));
                    
                    if (_old_value != _new_value)
                        _insert_string += ((_new_value == undefined) ? "[/color]" : ("[d#" + string(_new_value) + "]"));
                    
                    _old_value = (struct_get_from_hash(_old_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_old_style_struct, variable_get_hash("bold")) ?? 0));
                    _new_value = (struct_get_from_hash(_new_style_struct, variable_get_hash("italic")) ?? 0) | (2 * (struct_get_from_hash(_new_style_struct, variable_get_hash("bold")) ?? 0));
                    
                    if (_old_value != _new_value)
                    {
                        if (_new_value == 0)
                        {
                            if (_old_value == 1)
                                _insert_string += "[/i]";
                            else if (_old_value == 2)
                                _insert_string += "[/b]";
                            else if (_old_value == 3)
                                _insert_string += "[/bi]";
                        }
                        else if (_new_value == 1)
                        {
                            _insert_string += "[i]";
                        }
                        else if (_new_value == 2)
                        {
                            _insert_string += "[b]";
                        }
                        else if (_new_value == 3)
                        {
                            _insert_string += "[bi]";
                        }
                    }
                    
                    _insert_string += (struct_get_from_hash(_new_style_struct, variable_get_hash("prefix")) ?? "");
                    _buffer_size += _func_insert_buffer(_buffer, _buffer_size, _insert_string);
                    _old_style = _new_style;
                }
                
                _next_value = buffer_peek(_buffer, buffer_tell(_buffer) - 1, buffer_u8);
            }
        }
    }
    
    buffer_seek(_buffer, buffer_seek_start, 0);
    return buffer_read(_buffer, buffer_string);
}
