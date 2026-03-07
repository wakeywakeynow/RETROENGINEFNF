package;

import flixel.FlxG;
import lime.app.Application;
import haxe.Http;
import sys.io.Process;

class UpdateCheckState extends MusicBeatState
{
    var latestVersion:String = "";
    var currentVersion:String = MainMenuState.engineVersion;

    override function create()
    {
        var url = "https://raw.githubusercontent.com/wakeywakeynow/RETROENGINEFNF/refs/heads/main/retrover.txt";
        var http = new Http(url);

        http.onData = function(response:String)
        {
            latestVersion = response;
            if (latestVersion != currentVersion)
            {
                FlxG.openURL("https://gamebanana.com/tools/22083");
                Sys.exit(0);
            }
            else
            {
                FlxG.switchState(new TitleState());
            }
        }

        http.onError = function(err:String)
        {
            FlxG.switchState(new TitleState());
        }

        http.request();

        super.create();
    }
}