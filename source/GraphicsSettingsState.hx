package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GraphicsSettingsState extends MusicBeatState
{
	var curSelected:Int = 0;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var grpLabels:FlxTypedGroup<FlxText>;
	private var bg:FlxSprite;

	override function create()
	{
		bg = new FlxSprite().loadGraphic(AssetPaths.menuDesat__png);
		bg.scrollFactor.set(0, 0.18);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = !ClientPrefs.lowQuality;
		bg.color = 0xFFea71fd;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		grpLabels = new FlxTypedGroup<FlxText>();
		add(grpLabels);

		var optionNames:Array<String> = ["LOW QUALITY", "BACK"];

		for (i in 0...optionNames.length)
		{
			var optionText:Alphabet = new Alphabet(0, (70 * i) + 30, optionNames[i], true, false);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.screenCenter(X);
			optionText.ID = i;
			grpOptions.add(optionText);
		}

		var valueLabel:FlxText = new FlxText(0, 0, 0, "", 20);
		valueLabel.setFormat("assets/fonts/vcr.ttf", 20, FlxColor.WHITE);
		valueLabel.ID = 0;
		grpLabels.add(valueLabel);

		updateLabels();
		changeSelection();

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);

		if (controls.ACCEPT)
			selectOption();

		if (controls.BACK)
			FlxG.switchState(new SettingsState());
	}

	function selectOption()
	{
		switch (curSelected)
		{
			case 0: // LOW QUALITY
				ClientPrefs.lowQuality = !ClientPrefs.lowQuality;
				ClientPrefs.save();
				updateLabels();
			case 1: // BACK
				FlxG.switchState(new SettingsState());
		}
	}

	function updateLabels()
	{
		for (label in grpLabels.members)
		{
			if (label.ID == 0)
			{
				label.text = ClientPrefs.lowQuality ? 'ON' : 'OFF';
				label.x = FlxG.width - label.width - 40;
				label.y = (70 * 0) + 30 + 10;
			}
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpOptions.length - 1;
		if (curSelected >= grpOptions.length)
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
