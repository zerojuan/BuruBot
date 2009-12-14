package burubot 
{
	import org.flixel.FlxSprite;
	
	/**	 
	 * @author Julius
	 */
	public class Torso extends FlxSprite
	{
		[Embed(source = "../assets/body/dual-fire.png")] private var ImgDualFire:Class;
		[Embed(source = "../assets/body/elite-gun.png")] private var ImgEliteGun:Class;
		[Embed(source = "../assets/body/elite-sword.png")] private var ImgEliteSword:Class;
		[Embed(source = "../assets/body/one-barrel.png")] private var ImgOneBarrel:Class;
		[Embed(source = "../assets/body/swordie.png")] private var ImgSwordie:Class;
		
		
		public static final var DUAL_FIRE:int = 0;
		public static final var ELITE_GUN:int = 1;
		public static final var ELITE_SWORD:int = 2;
		public static final var ONE_BARREL:int = 3;
		public static final var SWORDIE:int = 4;
		
		private var _frameRate:int;
		
		public function Torso() {
			
		}
		/**
		 * Sets the graphics that'll show
		 * --Auto fixes the animation states for spritesheets that have different layouts
		 */
		public function setGraphic(type:int) {
			switch(type) {
				case DUAL_FIRE: 
					loadGraphic(ImgDualFire, true, false, 48, 48, false);
					addAnimation("n_i", [10], _frameRate);
					addAnimation("s_i", [30], _frameRate);
					addAnimation("w_i", [20], _frameRate);
					addAnimation("e_i", [0], _frameRate);
					addAnimation("ne_i", [5], _frameRate);
					addAnimation("nw_i", [15], _frameRate);
					addAnimation("sw_i", [25], _frameRate);
					addAnimation("se_i", [35], _frameRate);
					addAnimation("n", [11, 12, 13, 14], _frameRate);
					addAnimation("s", [31, 32, 33, 34], _frameRate);
					addAnimation("e", [1, 2, 3, 4], _frameRate);
					addAnimation("w", [21, 22, 23, 24], _frameRate);
					addAnimation("ne", [6, 7, 8, 9], _frameRate);
					addAnimation("nw", [16, 17, 18, 19], _frameRate);
					addAnimation("sw", [26, 27, 28, 29], _frameRate);
					addAnimation("se", [36,37,38,39], _frameRate);
					break;
				case ELITE_GUN:
					loadGraphic(ImgEliteGun, true, false, 48, 48, false);
					addAnimation("n_i", [6], _frameRate);
					addAnimation("s_i", [8], _frameRate);
					addAnimation("w_i", [12], _frameRate);
					addAnimation("e_i", [0], _frameRate);
					addAnimation("ne_i", [3], _frameRate);
					addAnimation("nw_i", [9], _frameRate);
					addAnimation("sw_i", [15], _frameRate);
					addAnimation("se_i", [21], _frameRate);
					addAnimation("n", [7, 8], _frameRate);
					addAnimation("s", [9, 10], _frameRate);
					addAnimation("e", [1, 2], _frameRate);
					addAnimation("w", [13, 14], _frameRate);
					addAnimation("ne", [4, 5], _frameRate);
					addAnimation("nw", [10, 11], _frameRate);
					addAnimation("sw", [16, 17], _frameRate);
					addAnimation("se", [22, 23], _frameRate);
					break;
				case ELITE_SWORD:
					loadGraphic(ImgEliteSword, true, false, 48, 48, false);
					addAnimation("n_i", [6], _frameRate);
					addAnimation("s_i", [8], _frameRate);
					addAnimation("w_i", [12], _frameRate);
					addAnimation("e_i", [0], _frameRate);
					addAnimation("ne_i", [3], _frameRate);
					addAnimation("nw_i", [9], _frameRate);
					addAnimation("sw_i", [15], _frameRate);
					addAnimation("se_i", [21], _frameRate);
					addAnimation("n", [7, 8], _frameRate);
					addAnimation("s", [9, 10], _frameRate);
					addAnimation("e", [1, 2], _frameRate);
					addAnimation("w", [13, 14], _frameRate);
					addAnimation("ne", [4, 5], _frameRate);
					addAnimation("nw", [10, 11], _frameRate);
					addAnimation("sw", [16, 17], _frameRate);
					addAnimation("se", [22, 23], _frameRate);
					break;
				case ONE_BARREL:
					loadGraphic(ImgOneBarrel, true, false, 48, 48, false);
					addAnimation("n_i", [10], _frameRate);
					addAnimation("s_i", [30], _frameRate);
					addAnimation("w_i", [20], _frameRate);
					addAnimation("e_i", [0], _frameRate);
					addAnimation("ne_i", [5], _frameRate);
					addAnimation("nw_i", [15], _frameRate);
					addAnimation("sw_i", [25], _frameRate);
					addAnimation("se_i", [35], _frameRate);
					addAnimation("n", [11, 12, 13, 14], _frameRate);
					addAnimation("s", [31, 32, 33, 34], _frameRate);
					addAnimation("e", [1, 2, 3, 4], _frameRate);
					addAnimation("w", [21, 22, 23, 24], _frameRate);
					addAnimation("ne", [6, 7, 8, 9], _frameRate);
					addAnimation("nw", [16, 17, 18, 19], _frameRate);
					addAnimation("sw", [26, 27, 28, 29], _frameRate);
					addAnimation("se", [36,37,38,39], _frameRate);
					break;
				case SWORDIE:
					loadGraphics(ImgSwordie, true, false, 48, 48, false);
					addAnimation("n_i", [10], _frameRate);
					addAnimation("s_i", [30], _frameRate);
					addAnimation("w_i", [20], _frameRate);
					addAnimation("e_i", [0], _frameRate);
					addAnimation("ne_i", [5], _frameRate);
					addAnimation("nw_i", [15], _frameRate);
					addAnimation("sw_i", [25], _frameRate);
					addAnimation("se_i", [35], _frameRate);
					addAnimation("n", [11, 12, 13, 14], _frameRate);
					addAnimation("s", [31, 32, 33, 34], _frameRate);
					addAnimation("e", [1, 2, 3, 4], _frameRate);
					addAnimation("w", [21, 22, 23, 24], _frameRate);
					addAnimation("ne", [6, 7, 8, 9], _frameRate);
					addAnimation("nw", [16, 17, 18, 19], _frameRate);
					addAnimation("sw", [26, 27, 28, 29], _frameRate);
					addAnimation("se", [36,37,38,39], _frameRate);
					break;
			}
		}
	}
	
}