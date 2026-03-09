package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class AudioSettingsState extends MusicBeatState
{
    var options:Array<String> = [
        "MUSIC VOLUME",
        "SFX VOLUME",
        "BACK"
    ];

    var curSelected:Int = 0;

    private var grpOptions:FlxTypedGroup<Alphabet>;
    private var bg:FlxSprite;

    private var musicVolume:Float = FlxG.sound.music.volume;
    private var sfxVolume:Float = FlxG.sound.volume;

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
        var leftP = controls.LEFT_P;
        var rightP = controls.RIGHT_P;

        if (upP)
            changeSelection(-1);
        if (downP)
            changeSelection(1);

        if (leftP || rightP)
            adjustVolume(leftP ? -0.1 : 0.1);

        if (controls.BACK)
            FlxG.switchState(new SettingsState());

        if (controls.ACCEPT)
            selectOption();
    }

    function selectOption()
    {
        switch(options[curSelected])
        {
            case "BACK":
                FlxG.switchState(new SettingsState());
        }
    }

    function adjustVolume(change:Float)
    {
        switch(options[curSelected])
        {
            case "MUSIC VOLUME":
                musicVolume += change;
                musicVolume = Math.max(0, Math.min(1, musicVolume));
                FlxG.sound.music.volume = musicVolume;
            case "SFX VOLUME":
                sfxVolume += change;
                sfxVolume = Math.max(0, Math.min(1, sfxVolume));
                FlxG.sound.volume = sfxVolume;
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