package 
{
	import org.flixel.FlxGame;
	import burubot.PlayState;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	public class Main extends FlxGame {
		public function Main():void {
			//super(320, 240, PlayState, 2, 0xffffff, false, 0xffffff, null, null, 0, 0);
			super(640, 480, PlayState, 1);
		}
	}
	
}