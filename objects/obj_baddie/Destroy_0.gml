if (ds_list_find_index(global.saveroom, id) == -1)
{
    with (instance_create_depth(x, y, -10, obj_baddiedead))
    {
        image_xscale = other.xscale;
        sprite_index = other.spr_dead;
    }
    
    create_particle(spr_poofeffect, x, y, 1);
    create_particle(spr_kungfueffect, x, y, 1);
    instance_create_depth(x, y, -1, obj_slapstar);
    instance_create_depth(x, y, -1, obj_slapstar);
    instance_create_depth(x, y, -1, obj_slapstar);
    ds_list_add(global.saveroom, id);
    fmod_soundeffect_3d(x, y, "event:/Sfx/killenemy");
    global.combo += 1;
    global.combotime = 60;
    global.collect += 20;
}
