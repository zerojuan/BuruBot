package burubot 
{
	import burubot.Player;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSpriteSheet;
	
	public class PlayState extends FlxState
	{
			[Embed(source = "../assets/torso.png")] private var ImgTorso:Class;
		private var _player:Player;
		
		override public function PlayState():void{
			this.add(new FlxText(100, 100, 100, 20, "Whoah here we are now at the text", 0xffffff));
			FlxG.log("Here!");
			_player = new Player(50, 50);
			FlxG.log("..");			
			this.add(_player);
			
			FlxG.follow(_player, 2.5);
			FlxG.followAdjust(0.5, 0.0);
			//FlxG.followBounds(0, 0, 640, 640);
		}
		
		override public function update():void {
			super.update();			
		}
		
	}
	
}