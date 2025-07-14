global.music = -4;
music_details = ds_list_create();
secret = false;
muID = -4;
currentmusic = -4;
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

music_add(hub_hallway, mu_hub, mu_hub);
music_add(hub_main, mu_hub, mu_hub);
music_add(crashout_1, whateverthisis, A_Secret_I_Threw_Away);
