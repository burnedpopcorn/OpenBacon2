if (active == false)
{
    with (obj_player)
    {
        targetRoom = other.targetRoom;
        targetDoor = other.targetDoor;
        hallwaydirection = other.hallwaydirection;
        hallway = true;
        
        with (instance_create_depth(x, y, 0, obj_fadeout))
            targetRoom = other.targetRoom;
        
        other.active = true;
    }
}
