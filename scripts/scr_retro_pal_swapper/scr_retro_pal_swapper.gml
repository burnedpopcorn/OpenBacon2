function pal_swap_init_system(main_pal_shd, html5_spr_shd, html5_surf_shd)
{
    var _swapper = 
    {
        shader: -4,
        html5: false,
        html5_sprite: -4,
        html5_surface: -4,
        texel_size: [0],
        uvs: [0],
        index: [0],
        texture: [0],
        layer_priority: 0,
        layer_temp_priority: 0,
        layer_map: 0,
        
        cleanup: function()
        {
            ds_priority_destroy(layer_priority);
            ds_priority_destroy(layer_temp_priority);
            ds_map_destroy(layer_map);
        }
    };
    _swapper.html5 = false;
    
    if (!_swapper.html5)
    {
        _swapper.shader = main_pal_shd;
        _swapper.texel_size[0] = shader_get_uniform(main_pal_shd, "u_pixelSize");
        _swapper.uvs[0] = shader_get_uniform(main_pal_shd, "u_Uvs");
        _swapper.index[0] = shader_get_uniform(main_pal_shd, "u_paletteId");
        _swapper.texture[0] = shader_get_sampler_index(main_pal_shd, "u_palTexture");
    }
    else
    {
        if (html5_spr_shd == undefined || html5_surf_shd == undefined)
        {
            show_message("Must provide pal_swap_init_system() with 2 additional arguments for HTML5 Compatible Sprite and Surface Shaders");
            game_end();
        }
        
        _swapper.html5_sprite = html5_spr_shd;
        _swapper.html5_surface = html5_surf_shd;
		
        _swapper.texel_size[1] = shader_get_uniform(html5_spr_shd, "u_pixelSize");
        _swapper.uvs[1] = shader_get_uniform(html5_spr_shd, "u_Uvs");
        _swapper.index[1] = shader_get_uniform(html5_spr_shd, "u_paletteId");
        _swapper.texture[1] = shader_get_sampler_index(html5_spr_shd, "u_palTexture");
		
        _swapper.texel_size[2] = shader_get_uniform(html5_surf_shd, "u_pixelSize");
        _swapper.uvs[2] = shader_get_uniform(html5_surf_shd, "u_Uvs");
        _swapper.index[2] = shader_get_uniform(html5_surf_shd, "u_paletteId");
        _swapper.texture[2] = shader_get_sampler_index(html5_surf_shd, "u_palTexture");
    }
    
    _swapper.layer_priority = ds_priority_create();
    _swapper.layer_temp_priority = ds_priority_create();
    _swapper.layer_map = ds_map_create();
    global.retro_pal_swapper = _swapper;
}

function pal_swap_set(spr, value, is_surface)
{
    var _swapper = global.retro_pal_swapper;
    
    if (value == 0)
        exit;
    
    var _mode = 0;
    
    if (!is_surface)
    {
        if (_swapper.html5)
        {
            shader_set(_swapper.html5_sprite);
            _mode = 1;
        }
        else
        {
            shader_set(_swapper.shader);
        }
        
        var _tex = sprite_get_texture(spr, 0);
        var _UVs = sprite_get_uvs(spr, 0);
        texture_set_stage(_swapper.texture[_mode], _tex);
        var _texel_x = texture_get_texel_width(_tex);
        var _texel_y = texture_get_texel_height(_tex);
        var _texel_hx = _texel_x * 0.5;
        var _texel_hy = _texel_y * 0.5;
        shader_set_uniform_f(_swapper.texel_size[_mode], _texel_x, _texel_y);
        shader_set_uniform_f(_swapper.uvs[_mode], _UVs[0] + _texel_hx, _UVs[1] + _texel_hy, _UVs[2], _UVs[3]);
        shader_set_uniform_f(_swapper.index[_mode], value);
    }
    else
    {
        if (_swapper.html5)
        {
            shader_set(_swapper.html5_surface);
            _mode = 2;
        }
        else
        {
            shader_set(_swapper.shader);
        }
        
        var _tex = surface_get_texture(spr);
        texture_set_stage(_swapper.texture[_mode], _tex);
        var _texel_x = texture_get_texel_width(_tex);
        var _texel_y = texture_get_texel_height(_tex);
        var _texel_hx = _texel_x * 0.5;
        var _texel_hy = _texel_y * 0.5;
        shader_set_uniform_f(_swapper.texel_size[_mode], _texel_x, _texel_y);
        shader_set_uniform_f(_swapper.uvs[_mode], _texel_hx, _texel_hy, 1 + _texel_hx, 1 + _texel_hy);
        shader_set_uniform_f(_swapper.index[_mode], value);
    }
}

function pal_swap_reset()
{
    if (shader_current() != -1)
        shader_reset();
}

function pal_swap_layer_init()
{
    ds_map_clear(global.retro_pal_swapper.layer_map);
    ds_priority_clear(global.retro_pal_swapper.layer_priority);
    ds_priority_clear(global.retro_pal_swapper.layer_temp_priority);
}

function pal_swap_set_layer(spr, spr_index, value, is_surface)
{
    var _data = ds_map_find_value(global.retro_pal_swapper.layer_map, value);
    
    if (_data == undefined)
        exit;
    
    ds_map_set(global.retro_pal_swapper.layer_map, value, 
    {
        sprite: spr,
        index: spr_index,
        is_surf: is_surface
    });
}

function pal_swap_enable_layer(_layer)
{
    if (!layer_exists(_layer))
        exit;
    
    var _data = 
    {
        sprite: undefined,
        index: undefined,
        is_surf: undefined
    };
    layer_script_begin(_layer, function()
    {
        if (event_type == ev_draw)
        {
            var _id = ds_priority_delete_min(global.retro_pal_swapper.layer_priority);
            var _data = ds_map_find_value(global.retro_pal_swapper.layer_map, _id);
            
            if (_data == "<undefined>")
                exit;
            
            pal_swap_set(_data.sprite, _data.index, _data.is_surf);
            ds_priority_add(global.retro_pal_swapper.layer_temp_priority, _id, layer_get_depth(_id));
        }
    });
    layer_script_end(_layer, function()
    {
        if (event_type == ev_draw)
        {
            pal_swap_reset();
            
            if (ds_priority_empty(global.retro_pal_swapper.layer_priority))
            {
                ds_priority_copy(global.retro_pal_swapper.layer_priority, global.retro_pal_swapper.layer_temp_priority);
                ds_priority_clear(global.retro_pal_swapper.layer_temp_priority);
            }
        }
    });
    ds_map_set(global.retro_pal_swapper.layer_map, _layer, _data);
    ds_priority_add(global.retro_pal_swapper.layer_priority, _layer, layer_get_depth(_layer));
}
