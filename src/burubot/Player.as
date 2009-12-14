package burubot 
{
		
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "../assets/torso.png")] private var ImgLeg:Class;
		[Embed(source = "../assets/body/elite-gun.png")] private var ImgEliteGun:Class;
		
		private var force:int = 1; //how strong the engine is
		
		public function Player(x:int, y:int) 
		{			
			super(x, y, ImgLeg);
			this.loadGraphic(ImgLeg, false, false, 48, 48);
			this.loadGraphic(ImgEliteGun, false, false, 48, 48);
			this.addAnimation("n", [24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35], 15);	
			this.addAnimation("s", [72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83], 15);
			this.addAnimation("w", [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59], 15);
			this.addAnimation("e", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 15);
			this.addAnimation("sw", [60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71], 15);
			this.addAnimation("se", [84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95], 15);
			this.addAnimation("ne", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 15);
			this.addAnimation("nw", [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], 15);
			play("n");
			
			drag = new Point(10, 10);
			maxVelocity = new Point(20, 20);
			
			
		}
		
		override public function update():void {	
			super.update(); //call animation and collision detection first
			
			getInput();
		}
		
		public function getInput():void {
			if (FlxG.keys.UP && !FlxG.keys.LEFT && !FlxG.keys.RIGHT) {
				play("n");				
				y += -force;
			}else if (FlxG.keys.DOWN && !FlxG.keys.LEFT && !FlxG.keys.RIGHT) {
				play("s");
				y += force;
			}else if (FlxG.keys.LEFT && !FlxG.keys.DOWN && !FlxG.keys.UP) {
				play("w");
				x += -force;
			}else if (FlxG.keys.RIGHT && !FlxG.keys.DOWN && !FlxG.keys.UP) {
				play("e");
				x += force;
			}else if (FlxG.keys.LEFT && FlxG.keys.DOWN) {
				play("sw");				
				x += -force;
				y += force;
			}else if (FlxG.keys.RIGHT && FlxG.keys.DOWN) {
				play("se");
				x += force;
				y += force;
			}else if (FlxG.keys.RIGHT && FlxG.keys.UP) {
				play("ne");
				x += force;
				y += -force;
			}else if(FlxG.keys.LEFT && FlxG.keys.UP) {
				play("nw");
				x += -force;
				y += -force;
			}
		}
	}
	
}