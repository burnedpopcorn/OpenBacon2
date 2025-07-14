function do_taunt()
{
    if (key_taunt2)
    {
        scr_soundeffect_3d(choose(sfx_taunt1, sfx_taunt2, sfx_taunt3), x, y);
        tauntsavedState = state;
        tauntsavedSprite = sprite_index;
        tauntsavedIndex = image_index;
        tauntsavedSpeed = image_speed;
        tauntsavedMovespeed = movespeed;
        tauntsavedVsp = vsp;
        hsp = 0;
        vsp = 0;
        state = states.taunt;
        instance_create_depth(x, y, depth + 1, obj_taunteffect);
        image_speed = 0;
        sprite_index = spr_player_taunt;
        image_index = random_range(0, image_number);
        tauntTimer = 20;
    }
}

function do_grab()
{
    if (key_slap2 && !key_up)
    {
        create_particle(spr_dustjump, x, y, xscale);
        flash = true;
        
        if (!grounded)
            sprite_index = spr_player_suplexgrabjumpstart;
        else
            sprite_index = spr_player_suplexdash;
        
        image_index = 0;
        state = states.grab;
        
        if (movespeed < 8)
            movespeed = 8;
    }
    else if (key_slap2 && key_up)
    {
        create_particle(spr_highjump, x, y, 1);
        flash = true;
        sprite_index = spr_player_uppercut;
        image_index = 0;
        state = states.punch;
        
        if (grounded)
            vsp = -14;
        else
            vsp = -9;
    }
}

function player_reset()
{
    with (obj_player)
    {
        global.collect = 0;
        ds_list_clear(global.saveroom);
        ds_list_clear(global.escaperoom);
        ds_list_clear(global.followerlist);
        image_alpha = 1;
        global.escape = false;
        global.lap = false;
        global.combo = 0;
        global.combotime = 60;
        global.combodropped = false;
        global.fill = [3, 50, 100];
        obj_music.lock = true;
        obj_camera.lock = false;
        combo = 0;
        hitX = x;
        hitY = y;
        hitstuntimer = 0;
        hitstun = false;
        instakillmove = false;
        tauntsavedState = 0;
        tauntsavedSprite = bg_crashout_0;
        tauntsavedIndex = 0;
        tauntsavedMovespeed = 0;
        tauntsavedVsp = 0;
        tauntsavedSpeed = 0;
        tauntTimer = 0;
        targetRoom = -4;
        targetDoor = "A";
        hallway = false;
        hallwaydirection = 1;
        baddieID = -4;
        grabbedID = -4;
        SjumpVsp = 0;
        c = c_black;
        afterimagetimer = 0;
        crouchsliptimer = 0;
        flash = false;
        steppy = 0;
        combo = 0;
    }
}

enum states
{
	normal,
	jump,
	mach2,
	mach3,
	machslide,
	taunt,
	Sjumpprep,
	Sjump,
	walkfront,
	grab,
	tumble,
	wallsplat,
	hauling,
	finishingblow,
	enterdoor,
	freefall,
	freefallland,
	wallclimb,
	punch,
	crouch,
	actor,
	wallkick,
	hurt
}

function scr_playerstate()
{
    var _state = undefined;
    
    switch (state)
    {
        case states.normal:
            _state = scr_player_normal;
            break;
        
        case states.jump:
            _state = scr_player_jump;
            break;
        
        case states.mach2:
            _state = scr_player_mach2;
            break;
        
        case states.mach3:
            _state = scr_player_mach3;
            break;
        
        case states.machslide:
            _state = scr_player_machslide;
            break;
        
        case states.taunt:
            _state = scr_player_taunt;
            break;
        
        case states.Sjumpprep:
            _state = scr_player_Sjumpprep;
            break;
        
        case states.Sjump:
            _state = scr_player_Sjump;
            break;
        
        case states.walkfront:
            _state = scr_player_walkfront;
            break;
        
        case states.grab:
            _state = scr_player_grab;
            break;
        
        case states.tumble:
            _state = scr_player_tumble;
            break;
        
        case states.wallsplat:
            _state = scr_player_wallsplat;
            break;
        
        case states.hauling:
            _state = scr_player_hauling;
            break;
        
        case states.finishingblow:
            _state = scr_player_finishingblow;
            break;
        
        case states.enterdoor:
            _state = scr_player_enterdoor;
            break;
        
        case states.freefall:
            _state = scr_player_freefall;
            break;
        
        case states.freefallland:
            _state = scr_player_freefallland;
            break;
        
        case states.wallclimb:
            _state = scr_player_wallclimb;
            break;
        
        case states.punch:
            _state = scr_player_punch;
            break;
        
        case states.crouch:
            _state = scr_player_crouch;
            break;
        
        case states.actor:
            _state = scr_player_actor;
            break;
        
        case states.wallkick:
            _state = scr_player_wallkick;
            break;
        
        case states.hurt:
            _state = scr_player_hurt;
            break;
    }
    
    if (_state != undefined)
    {
        _state();
        var _name = "states." + string_extract(script_get_name(_state) + "_", "_", 2);
        statename = _name;
    }
    else
        statename = "states.undefined";
}

function scr_player_actor()
{
    hsp = 0;
    vsp = 0;
    movespeed = 0;
}
