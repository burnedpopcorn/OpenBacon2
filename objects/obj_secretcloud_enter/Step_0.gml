switch (state)
{
    case secretstates.exist:
        if (animation_end() && obj_player.state == states.actor)
        {
            obj_player.state = states.normal;
            state = secretstates.disappear;
            sprite_index = spr_secretportal_tired;
        }
        
        break;
    
    case secretstates.disappear:
        leavetimer = approach(leavetimer, 0, 1);
        
        if (leavetimer == 0)
            instance_destroy();
        
        break;
}
