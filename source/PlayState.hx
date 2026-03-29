package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public static var SEEN_CUTSCENES:Array<Int> = [];

	public var level:Int = 0;

	override public function new(level:Int = 1)
	{
		super();

		this.level = level;

		if (this.level < 1)
			this.level = 1;
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

		if (level == 1)
		{
			if (!SEEN_CUTSCENES.contains(level))
				FlxG.switchState(() -> new DialogueState(level));
			FlxG.camera.bgColor = FlxColor.fromString('#1D1B23');

			bgElements.add(new FlxSprite(191, 0, 'assets/images/play/level1/door-select.png'));
			bgElements.members[0].visible = false;

			bgOptionElements.add(new FlxSprite(201, 0, 'assets/images/play/level1/door.png'));

			mgElements.add(new FlxSprite(0, 0, 'assets/images/play/level1/floorback.png'));
			mgElements.add(new FlxSprite(0, 0, 'assets/images/play/level1/wall.png'));

			fgElements.add(new FlxSprite(391, 0, 'assets/images/play/level1/rope-select.png'));
			fgElements.members[0].visible = false;

			fgOptionElements.add(new FlxSprite(401, 0, 'assets/images/play/level1/rope.png'));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (level == 1)
		{
			fgElements.members[0].visible = FlxG.mouse.overlaps(fgOptionElements.members[0]);
			bgElements.members[0].visible = FlxG.mouse.overlaps(bgOptionElements.members[0]) && !fgElements.members[0].visible;
		}
	}

	public var bgElements:FlxSpriteGroup = new FlxSpriteGroup();
	public var bgOptionElements:FlxSpriteGroup = new FlxSpriteGroup();

	public var mgElements:FlxSpriteGroup = new FlxSpriteGroup();
	public var mgOptionElements:FlxSpriteGroup = new FlxSpriteGroup();

	public var fgElements:FlxSpriteGroup = new FlxSpriteGroup();
	public var fgOptionElements:FlxSpriteGroup = new FlxSpriteGroup();
}
