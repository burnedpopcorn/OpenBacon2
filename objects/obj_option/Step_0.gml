scr_getinput();
var m = menus[currentmenu];
var opt = m.options;
var _length = array_length(opt) - 1;
var q = opt[selected];
BGX = wave(-32, 32, 5, 0);
BGY--;

if (q.type != 2)
    move = key_left2 + key_right2;
else
    move = key_left + key_right;

if (move != 0 && q.type != 0)
{
    q.val += move;
    q.val = clamp(q.val, 0, q.max);
    q.func();
}

if (key_down2)
{
    if (selected < _length)
        selected++;
    else
        selected = 0;
}

if (key_up2)
{
    if (selected > 0)
        selected--;
    else
        selected = _length;
}

if (key_jump2)
{
    if (q.type != 0)
    {
        q.val += 1;
        q.val = wrap(q.val, 0, q.max);
    }
    
    q.func();
}

if (key_slap2)
    m.backfunc();

if (q.type == 2)
{
    if (move != 0)
    {
        q.moving = true;
        
        if (!audio_is_playing(slidersnd))
            scr_soundeffect_2d(slidersnd);
        
        set_audio_gain(slidersnd, q.val / 100);
    }
    else
    {
        q.moving = false;
        
        if (audio_is_playing(slidersnd))
            audio_stop_sound(slidersnd);
    }
}
