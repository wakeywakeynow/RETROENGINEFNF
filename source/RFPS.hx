package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Lib;
import openfl.system.System;
import flixel.FlxG;

class RFPS extends Sprite
{
	var tf:TextField;
	var fmt:TextFormat;

	var frames:Int = 0;
	var lastTime:Float = 0;

	var fps:Int = 0;
	var memory:Float = 0;

	#if debug
	var peakMemory:Float = 0;
	#end

	public function new(x:Int = 10, y:Int = 10, color:Int = 0xFFFFFF)
	{
		super();

		this.x = x;
		this.y = y;

		fmt = new TextFormat("_sans", 14, color);

		tf = new TextField();
		tf.defaultTextFormat = fmt;
		tf.width = 300;
		tf.height = 60;
		tf.selectable = false;

		addChild(tf);

		lastTime = Lib.getTimer();

		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		visible = ClientPrefs.showFPS;
	}

	function onKeyDown(e:KeyboardEvent)
	{
		if (e.keyCode == 114) // it is F3 sorry i stupid
		{
			visible = !visible;
			ClientPrefs.showFPS = visible;
			ClientPrefs.save();
		}
	}

	function onEnterFrame(e:Event)
	{
		frames++;

		var now = Lib.getTimer();

		if (now - lastTime >= 1000)
		{
			fps = frames;
			frames = 0;
			lastTime = now;

			memory = System.totalMemory / 1024 / 1024;

			#if debug
			if (memory > peakMemory)
				peakMemory = memory;
			#end

			updateText();
		}
	}

	function updateText()
	{
		var targetFPS:Int = FlxG.updateFramerate;

		var fpsColor:Int;
		if (fps >= Std.int(targetFPS * 0.9))
			fpsColor = 0x00FF66;
		else if (fps >= Std.int(targetFPS * 0.6))
			fpsColor = 0xFFCC00;
		else
			fpsColor = 0xFF4444;

		var fpsStr = "FPS: " + fps;
		var memStr = "MEM: " + Std.int(memory) + " MB";

		tf.text = fpsStr + "\n" + memStr;

		#if debug
		tf.appendText("\nPEAK: " + Std.int(peakMemory) + " MB");
		#end

		// base color!
		tf.setTextFormat(new TextFormat("_sans", 14, 0xAAAAAA));

		var fpsValueStart = fpsStr.indexOf(Std.string(fps));
		tf.setTextFormat(
			new TextFormat("_sans", 14, fpsColor),
			fpsValueStart,
			fpsValueStart + Std.string(fps).length
		);
	}
}
