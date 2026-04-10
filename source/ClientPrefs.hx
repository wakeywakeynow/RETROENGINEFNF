package;

import flixel.FlxG;

class ClientPrefs
{
	public static var lowQuality:Bool = false;
	public static var showFPS:Bool = true;

	public static function load():Void
	{
		if (FlxG.save.data.lowQuality != null)
			lowQuality = FlxG.save.data.lowQuality;
		if (FlxG.save.data.showFPS != null)
			showFPS = FlxG.save.data.showFPS;
	}

	public static function save():Void
	{
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.flush();
	}
}
