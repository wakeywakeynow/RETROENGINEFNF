package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxBasic;
import openfl.system.System;

class RFPS extends Sprite
{
	var tf:TextField;

	var frames:Int = 0;
	var lastTime:Float = 0;

	var fps:Int = 0;
	var memory:Float = 0;
	var objects:Int = 0;

	public function new(x:Int = 10, y:Int = 10, color:Int = 0xFFFFFF)
	{
		super();

		this.x = x;
		this.y = y;

		tf = new TextField();
		tf.defaultTextFormat = new TextFormat("_sans", 14, color);
		tf.width = 300;
		tf.height = 100;
		tf.selectable = false;

		addChild(tf);

		lastTime = Lib.getTimer();

		addEventListener(Event.ENTER_FRAME, update);
	}

	function update(e:Event)
	{
		frames++;

		var now = Lib.getTimer();

		if (now - lastTime >= 1000)
		{
			fps = frames;
			frames = 0;
			lastTime = now;

			// MB
			memory = System.totalMemory / 1024 / 1024;

			#if debug
			objects = countObjects();
			#end

			updateText();
		}
	}

	function updateText()
	{
		var text = "FPS: " + fps + "\n";
		text += "MEM: " + Std.int(memory) + " MB";

		#if debug
		text += "\nOBJS: " + objects;
		#end

		tf.text = text;
	}

	function countObjects():Int
	{
		var count = 0;

		if (FlxG.state != null)
		{
			for (obj in FlxG.state.members)
			{
				if (obj != null)
					count++;
			}
		}

		return count;
	}
}