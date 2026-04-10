package;

import flixel.FlxG;
import flixel.FlxSubState;

class MusicBeatSubstate extends FlxSubState
{
	public function new()
	{
		super();
	}

	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var totalBeats:Int = 0;
	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override function create()
	{
		#if (!web)
		TitleState.soundExt = '.ogg';
		#end

		super.create();
	}

	override function update(elapsed:Float)
	{
		var prevStep:Int = curStep;
		var prevBeat:Int = curBeat;

		curStep = Math.floor(Conductor.songPosition / Conductor.stepCrochet);
		curBeat = Math.floor(curStep / 4);

		if (curStep > prevStep)
			stepHit();

		if (curBeat > prevBeat)
			beatHit();

		super.update(elapsed);
	}

	public function stepHit():Void {}

	public function beatHit():Void
	{
		totalBeats = curBeat;
	}
}
