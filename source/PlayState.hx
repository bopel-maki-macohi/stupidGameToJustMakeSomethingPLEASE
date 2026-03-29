package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

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

	override public function create()
	{
		super.create();
		if (level == 1)
		{
			due = new FlxSprite(0, 0, 'assets/images/play/due.png');
			kue = new FlxSprite(0, 0, 'assets/images/play/kue.png');
			add(due);
			add(kue);

			due.screenCenter();
			kue.screenCenter();

			due.x -= due.width;
			kue.x += kue.width;

			if (!SEEN_CUTSCENES.contains(level))
				FlxG.switchState(() -> new DialogueState(level));
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
	public var due:FlxSprite;
	public var kue:FlxSprite;
}
