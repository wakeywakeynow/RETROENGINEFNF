package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		#if OFFICIAL_BUILD
		addChild(new FlxGame(0, 0, UpdateCheckState));
		#else
		addChild(new FlxGame(0, 0, TitleState));
		#end

		#if !mobile
		addChild(new RFPS(10, 3, 0xFFFFFF));
		#end
	}
}
