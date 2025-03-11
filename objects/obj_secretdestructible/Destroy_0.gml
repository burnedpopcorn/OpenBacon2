if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    scr_soundeffect_3d(choose(sfx_breakblock1, sfx_breakblock2), x, y);
}

tile_delete(x, y);
tile_delete(x + (32 * image_xscale), y);
tile_delete(x + (32 * image_xscale), y + (32 * image_yscale));
tile_delete(x, y + (32 * image_yscale));
