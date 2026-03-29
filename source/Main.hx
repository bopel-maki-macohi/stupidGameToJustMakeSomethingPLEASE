package;

import flixel.FlxGame;
import flixel.util.FlxSave;
import lime.app.Application;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var save:FlxSave;

	public function new()
	{
		super();
		save = new FlxSave();
		save.bind('due-and-kue', Application.current.meta.get('company'));

		addChild(new FlxGame(0, 0, InitState));
	}
}
