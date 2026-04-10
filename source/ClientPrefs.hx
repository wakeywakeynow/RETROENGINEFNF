package;

import flixel.FlxG;

class ClientPrefs
{
	public static var lowQuality:Bool = false;

	public static function load():Void
	{
		if (FlxG.save.data.lowQuality != null)
			lowQuality = FlxG.save.data.lowQuality;
	}

	public static function save():Void
	{
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.flush();
	}
}
