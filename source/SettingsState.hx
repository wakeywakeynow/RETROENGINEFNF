package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class SettingsState extends MusicBeatState
{
	var options:Array<String> = [
		"AUDIO",
		"BACK"
	];

	var curSelected:Int = 0;

	private var grpOptions:FlxTypedGroup<Alphabet>;

	private var bg:FlxSprite;

	override function create()
	{
		bg = new FlxSprite().loadGraphic(AssetPaths.menuDesat__png);
		bg.scrollFactor.set(0, 0.18);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.color = 0xFFea71fd;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, (70 * i) + 30, options[i], true, false);
			optionText.isMenuItem = true;
			optionText.targetY = i;

			optionText.screenCenter(X);

			grpOptions.add(optionText);
		}

		changeSelection();

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;

		if (upP)
			changeSelection(-1);

		if (downP)
			changeSelection(1);

		if (controls.BACK)
			FlxG.switchState(new MainMenuState());

		if (controls.ACCEPT)
			selectOption();
	}

	function selectOption()
	{
		switch(options[curSelected])
		{
			case "AUDIO":
				FlxG.switchState(new AudioSettingsState());

			case "BACK":
				FlxG.switchState(new MainMenuState());
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = options.length - 1;

		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
				item.alpha = 1;
		}
	}
}