/*
*   Hier können eigene Sounds eingebunden werden.
*   Ist in CfgSounds included.
*/

#define VOLUME 4
#define DISTANCE 15


class remote_start
{
    name = "remote_start";
    sound[] = {"USER\sounds\remote_start.ogg", 1, 1, 200};
    titles[] = {0, ""};
};

class remote_end
{
    name = "remote_end";
    sound[] = {"USER\sounds\remote_end.ogg", 1, 1, 200};
    titles[] = {0, ""};
};
