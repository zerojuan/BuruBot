package org.flixel
{
	import org.flixel.data.FlxAnim;
	import org.flixel.FlxCore;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	//@desc		The main "game object" class, handles basic physics and animation
	public class FlxSpriteSheet extends FlxSprite
	{
		protected var _reverse:Boolean = false;
		private var _initWidth:int;
		//@desc		Constructor
		//@param	Graphic		The image you want to use
		//@param	X			The initial X position of the sprite
		//@param	Y			The initial Y position of the sprite
		//@param	Animated	Whether the Graphic parameter is a single sprite or a row of sprites
		//@param	Reverse		Whether you need this class to generate horizontally flipped versions of the animation frames
		//@param	Width		If you opt to NOT use an image and want to generate a colored block, or your sprite's frames are not square, you can specify a width here 
		//@param	Height		If you opt to NOT use an image you can specify the height of the colored block here (ignored if Graphic is not null)
		//@param	Color		Specifies the color of the generated block (ignored if Graphic is not null)
		public function FlxSpriteSheet(Graphic:Class=null,X:int=0,Y:int=0,Animated:Boolean=false,Reverse:Boolean=false,Width:uint=48,Height:uint=48,Color:uint=0)
		{
			FlxG.log("Starting spritesheet");
			_reverse = Reverse;
			var tmpWidth:uint = Width;
			var tmpHeight:uint = Height;
			super(Graphic,X,Y,Animated,Reverse,Width,Height,Color);
			Width=tmpWidth;
			Height=tmpHeight ;										
			width = _bw = Width;
			height = _bh = Height;
			_initWidth = Width;
			_r = new Rectangle(0,0,_bw,_bh);
			if(Animated)
			{
				_pixels = new BitmapData(width,height);
				_pixels.copyPixels(pixels,_r,new Point());
			}								
		}
				
		//@desc		Internal function to update the current animation frame
		override protected function calcFrame():void
		{			
			if (_curAnim == null) return;
			
			var rx:uint = 0; var ry:uint = 0;			
			if(_reverse){
				rx = (_curAnim.frames[_curFrame]%Math.floor(pixels.width/_initWidth/2))*_bw;
				ry = Math.floor(_curAnim.frames[_curFrame]/Math.floor(pixels.width/width/2))*_bh;
			}else{
				rx = (_curAnim.frames[_curFrame]%Math.floor(pixels.width/width))*_bw;
				ry = Math.floor(_curAnim.frames[_curFrame]/Math.floor(pixels.width/width))*_bh;
			}
			if (!facing && (_flipped > 0)) {
				rx = (_flipped << 1) - rx - _bw;
			}
			_pixels.copyPixels(pixels,new Rectangle(rx,ry,_bw,_bh),new Point());
			if(_callback != null) _callback(_curAnim.name,_curFrame,_curAnim.frames[_curFrame]);
		}
	}
}