import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
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

		diaText = new FlxText();
		diaText.color = FlxColor.WHITE;
		add(diaText);

		if (level == 1)
		{
			dia_due = new FlxSprite(0, 0, 'assets/images/dia/due1.png');
			dia_kue = new FlxSprite(0, 0, 'assets/images/dia/kue1.png');

			dia_due.screenCenter();
			add(dia_due);

			dia_kue.screenCenter();
			add(dia_kue);

			inDialogue = true;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
				diaText.text = 'IM GONNA BEAT YOUR ASS!';
			else if (dialogueBit == 4)
				diaText.text = 'Gota catch me first >:3';
			else
			{
				inDialogue = false;

                FlxTimer.wait(1, () -> {
                    FlxG.switchState(() -> new PlayState(level));
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
}
