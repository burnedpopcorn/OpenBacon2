if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    scr_soundeffect_3d(metalblock, x, y);
    obj_camera.shake = 30;
    
    repeat (2)
    {
        with (instance_create_depth(x + 16, y + 16, depth, obj_slapstar))
        {
            hsp = random_range(-10, 10);
            image_speed = 0.35;
            sprite_index = spr_towerblockdebris;
        }
    }
}
