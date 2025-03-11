global.music = -4;
music_details = ds_list_create();
secret = false;
muID = -4;
currentmusic = "";
prevmuID = muID;
lock = false;
panicstart = false;

function music_add(setroom, mus, secretmus = -4)
{
    var _mu = 
    {
        roomtoset: setroom,
        music: mus,
        secret: secretmus,
        func: -4
    };
    ds_list_add(music_details, _mu);
    return _mu;
}

music_add(hub_hallway, "event:/Music/hub", "event:/Music/hub");
music_add(hub_main, "event:/Music/hub", "event:/Music/hub");
music_add(crashout_1, "event:/Music/crashout", "event:/Music/crashoutsecret");
escape = fmod_createEventInstance("event:/Music/escape");
