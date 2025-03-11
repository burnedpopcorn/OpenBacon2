if (active == true)
{
    for (var i = 0; i < gamepad_get_device_count(); i++)
        if (gamepad_is_connected(i) && gamepad_check_any(i))
        {
            if (checking_for_player == 0)
            {
                player_input[0] = i;
                checking_for_player = 1;
            }
            else
            {
                player_input[0] = i;
                active = false;
            }
        }
}
