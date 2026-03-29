package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public static var SEEN_CUTSCENES:Array<Dynamic> = [];

	public var level:Dynamic = 'intro';

	override public function new(level:Dynamic = 'intro')
	{
		super();

		this.level = level ?? 'intro';
		trace('New level: ${this.level}');

		Main.save.data.lastLevel = this.level;
		if (!Main.save.data.unlockedLevels.contains(this.level))
			Main.save.data.unlockedLevels.push(this.level);
	}

	public var due:FlxSprite;

	override public function create()
	{
		super.create();
		add(bgElements);
		add(bgOptionElements);

		add(mgElements);
		add(mgOptionElements);

		due = new FlxSprite(0, 0, 'assets/play/due.png');
		add(due);

		due.screenCenter();

		add(fgElements);
		add(fgOptionElements);

		if (level == 'intro')
		{
			if (!SEEN_CUTSCENES.contains(level))
				FlxG.switchState(() -> new DialogueState(level));
		}

		if (level == 'start')
		{
			FlxG.camera.bgColor = FlxColor.fromString('#1D1B23');

			bgOptionElements.add(new TouchMeSprite(183, 109, getLevelAsset('door.png')).addClickFunction(o -> newLevel('enterDoor')));

			mgElements.add(new TouchMeSprite(0, 0, getLevelAsset('floorback.png')));
			mgElements.add(new TouchMeSprite(0, 0, getLevelAsset('wall.png')));

			fgOptionElements.add(new TouchMeSprite(401, 0, getLevelAsset('rope.png')).addClickFunction(o -> newLevel('climbRope')));
		}
	}

	public function getLevelAsset(asset:String):String
		return _getLevelAsset(this.level, asset);

	public static function _getLevelAsset(level:String, asset:String):String
		return 'assets/play/$level/$asset';

	public static function newLevel(level:String)
	{
		FlxG.switchState(() -> new PlayState(level));
	}

	public var bgElements:TouchMeSpriteGroup = new TouchMeSpriteGroup();
	public var bgOptionElements:TouchMeSpriteGroup = new TouchMeSpriteGroup();

	public var mgElements:TouchMeSpriteGroup = new TouchMeSpriteGroup();
	public var mgOptionElements:TouchMeSpriteGroup = new TouchMeSpriteGroup();

	public var fgElements:TouchMeSpriteGroup = new TouchMeSpriteGroup();
	public var fgOptionElements:TouchMeSpriteGroup = new TouchMeSpriteGroup();
}
