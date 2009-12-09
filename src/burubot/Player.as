package burubot 
{
	
	import org.flixel.FlxSpriteSheet;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class Player extends FlxSpriteSheet
	{
		[Embed(source = "../assets/torso.png")] private var ImgTorso:Class;
		
		public function Player(x:int, y:int) 
		{
			super(ImgTorso, x, y, true, false, 48, 48);				
			this.addAnimation("n", [24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35], 15);	
			this.addAnimation("s", [72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83], 15);
			this.addAnimation("w", [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59], 15);
			this.addAnimation("e", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 15);
			this.addAnimation("sw", [60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71], 15);
			this.addAnimation("se", [84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95], 15);
			this.addAnimation("ne", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 15);
			this.addAnimation("nw", [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], 15);
			play("n");
			
			
		}
		
		override public function update():void {	
			super.update(); //call animation and collision detection first
			
			if (FlxG.keys.UP && !FlxG.keys.LEFT && !FlxG.keys.RIGHT) {
				play("n");
				y--;				
			}else if (FlxG.keys.DOWN && !FlxG.keys.LEFT && !FlxG.keys.RIGHT) {
				play("s");
				y++;
			}else if (FlxG.keys.LEFT && !FlxG.keys.DOWN && !FlxG.keys.UP) {
				play("w");
				x--;
			}else if (FlxG.keys.RIGHT && !FlxG.keys.DOWN && !FlxG.keys.UP) {
				play("e");
				x++;
			}else if (FlxG.keys.LEFT && FlxG.keys.DOWN) {
				play("sw");
				x--;
				y++;
			}else if (FlxG.keys.RIGHT && FlxG.keys.DOWN) {
				play("se");
				x++;
				y++;
			}else if (FlxG.keys.RIGHT && FlxG.keys.UP) {
				play("ne");
				x++;
				y--;
			}else if(FlxG.keys.LEFT && FlxG.keys.UP) {
				play("nw");
				x--;
				y--;
			}
		}
	}
	
}