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
	}

	public var due:FlxSprite;

	override public function create()
	{
		super.create();
		add(bgElements);
		add(bgOptionElements);

		add(mgElements);
		add(mgOptionElements);

		due = new FlxSprite(0, 0, 'assets/images/play/due.png');
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

			bgOptionElements.add(new TouchMeSprite(201, 0, 'assets/images/play/level1/door.png').addClickFunction(() -> newLevel('enterDoor')));

			mgElements.add(new TouchMeSprite(0, 0, 'assets/images/play/level1/floorback.png'));
			mgElements.add(new TouchMeSprite(0, 0, 'assets/images/play/level1/wall.png'));

			fgOptionElements.add(new TouchMeSprite(401, 0, 'assets/images/play/level1/rope.png').addClickFunction(() -> newLevel('climbRope')));
		}
	}

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
