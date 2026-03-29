import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class DialogueState extends FlxState
{
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
		dialogueBit = 0;

		FlxG.camera.bgColor = FlxColor.WHITE;

		diaText = new FlxText();
		diaText.color = FlxColor.BLACK;
		diaText.size = 32;
		add(diaText);

		if (level == 1)
		{
			dia_due = new FlxSprite(0, 0, 'assets/images/dia/due-big.png');
			dia_kue = new FlxSprite(0, 0, 'assets/images/dia/kue-big.png');

			dia_due.screenCenter();
			add(dia_due);

			dia_kue.screenCenter();
			add(dia_kue);

			inDialogue = true;
			due = new FlxSprite(0, 0, 'assets/images/dia/due-mini.png');
			kue = new FlxSprite(0, 0, 'assets/images/dia/kue-mini.png');
			add(due);
			add(kue);

			due.screenCenter();
			kue.screenCenter();

			due.x -= due.width;
			kue.x += kue.width;

			due.visible = false;
			kue.visible = false;
		}
		PlayState.SEEN_CUTSCENES.push(this.level);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		diaText.visible = inDialogue;
		if (inDialogue)
			if (FlxG.keys.justPressed.SPACE)
				dialogueBit++;

		if (level == 1)
		{
			dia_due.visible = dd.contains(dialogueBit);
			dia_kue.visible = dk.contains(dialogueBit);

			if (dialogueBit == 0 || dialogueBit == 2)
				diaText.text = 'KUE!';
			else if (dialogueBit == 1)
				diaText.text = 'Due...';
			else if (dialogueBit == 3)
				diaText.text = 'IM GONNA\nBEAT YOUR\nASS!';
			else if (dialogueBit == 4)
				diaText.text = 'Gota catch me first >:3';
			else if (dialogueBit == 5)
			{
				inDialogue = false;
				dialogueBit++;

				kue.visible = true;
				due.visible = true;

				FlxTween.tween(kue, {y: -kue.height}, .2, {
					startDelay: 1,
					ease: FlxEase.sineOut,
					onComplete: function(t)
					{
						kue.visible = false;
					}
				});

				FlxTween.tween(due, {x: FlxG.width + due.width}, 1.5, {
					startDelay: 2,
					ease: FlxEase.sineIn,
					onComplete: function(t)
					{
						due.visible = false;

						FlxTimer.wait(1, () ->
						{
							FlxG.switchState(() -> new PlayState(level));
						});
					}
				});
			}
			diaText.screenCenter();

			if (dia_due.visible)
				diaText.y += dia_due.height;

			if (dia_kue.visible)
				diaText.y += dia_kue.height;
		}
	}

	public var dialogueBit:Int = 0;
	public var inDialogue:Bool = false;

	public var diaText:FlxText;

	public var dia_due:FlxSprite;

	final dd = [0, 2, 3];

	public var dia_kue:FlxSprite;

	final dk = [1, 4];

	public var due:FlxSprite;
	public var kue:FlxSprite;
}
