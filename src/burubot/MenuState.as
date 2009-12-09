package burubot 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	import burubot.PlayState;
	
	public class MenuState extends FlxState
	{
		
		override public function MenuState():void {
			this.add(new FlxText(0, (FlxG.width / 2) - 80, FlxG.width, 80, "Robot", 0xffffffff, null, 16, "center")) as FlxText;
            this.add(new FlxText(0, FlxG.height  -24, FlxG.width, 8, "PRESS X TO START", 0xffffffff, null, 8, "center"));	
		}
		
		override public function update():void {
			if (FlxG.keys.X){
                FlxG.flash(0xffffffff, 0.75);
                FlxG.fade(0xff000000, 1, onFade);
            }
            super.update();
		}
		private function onFade():void {
			FlxG.switchState(PlayState);
		}
	}
	
}