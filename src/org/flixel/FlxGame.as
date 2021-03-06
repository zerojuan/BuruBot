package org.flixel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import org.flixel.data.*;

	//@desc		FlxGame is the heart of all flixel games, and contains a bunch of basic game loops and things.  It is a long and sloppy file that you shouldn't have to worry about too much!
	public class FlxGame extends Sprite
	{
		[Embed(source="data/nokiafc22.ttf",fontFamily="system")] private var junk:String;
		[Embed(source="data/poweredby.png")] private var ImgPoweredBy:Class;
		[Embed(source="data/beep.mp3")] private var SndBeep:Class;
		[Embed(source="data/flixel.mp3")] private var SndFlixel:Class;

		internal const MAX_ELAPSED:Number = 0.0333;
		
		//startup
		internal var _iState:Class;
		internal var _created:Boolean;
		
		//basic display stuff
		internal var _buffer:Sprite;
		internal var _bmpBack:Bitmap;
		internal var _bmpFront:Bitmap;
		internal var _flipped:Boolean;
		internal var _zoom:uint;
		internal var _gameXOffset:int;
		internal var _gameYOffset:int;
		internal var _bgColor:Number;
		internal var _frame:Class;
		internal var _curState:FlxState;
		internal var _cursor:Bitmap;
		
		//basic update stuff
		internal var _elapsed:Number;
		internal var _total:uint;
		internal var _paused:Boolean;
		
		//Pause screen, sound tray, support panel, dev console, and special effects objects
		internal var _pausePopup:FlxPause;
		internal var _helpStrings:Array;
		internal var _soundTray:Sprite;
		internal var _soundTrayTimer:Number;
		internal var _soundTrayBars:Array;
		internal var _panel:FlxPanel;
		internal var _console:FlxConsole;
		internal var _quake:FlxQuake;
		internal var _flash:FlxFlash;
		internal var _fade:FlxFade;
		internal var _defaultSoundControls:Boolean;
		
		//logo stuff
		internal var _f:FlxArray;
		internal var _fc:uint;
		internal var _logoComplete:Boolean;
		internal var _logoTimer:Number;
		internal var _poweredBy:Bitmap;
		internal var _logoFade:Bitmap;
		internal var _fSound:Class;
		internal var _showLogo:Boolean;
		
		//@desc		Constructor
		//@param	GameSizeX		The width of your game in pixels (e.g. 320)
		//@param	GameSizeY		The height of your game in pixels (e.g. 240)
		//@param	InitialState	The class name of the state you want to create and switch to first (e.g. MenuState)
		//@param	Zoom			The level of zoom (e.g. 2 means all pixels are now rendered twice as big)
		//@param	BGColor			The color of the Flash app's background
		//@param	FlixelColor		The color of the great big 'f' in the flixel logo
		//@param	FlixelSound		The sound that is played over the flixel 'f' logo
		//@param	Frame			If you want you can add a little graphical frame to the outside edges of your game
		//@param	ScreenOffsetX	If you use a frame, you're probably going to want to scoot your game down to fit properly inside it
		//@param	ScreenOffsetY	These variables do exactly that :)	
		public function FlxGame(GameSizeX:uint,GameSizeY:uint,InitialState:Class,Zoom:uint=2,BGColor:Number=0xff000000,ShowFlixelLogo:Boolean=true,FlixelColor:Number=0xffffffff,FlixelSound:Class=null,Frame:Class=null,ScreenOffsetX:uint=0,ScreenOffsetY:uint=0)
		{
			_zoom = Zoom;
			_gameXOffset = ScreenOffsetX;
			_gameYOffset = ScreenOffsetY;
			_bgColor = BGColor;
			_fc = FlixelColor;
			FlxG.setGameData(this,GameSizeX,GameSizeY);
			_created = false;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_elapsed = 0;
			_total = 0;
			flash.ui.Mouse.hide();
			_logoComplete = false;
			_f = null;
			_quake = new FlxQuake(_zoom);
			_flash = new FlxFlash();
			_fade = new FlxFade();
			if(FlixelSound == null)
				_fSound = SndFlixel;
			else
				_fSound = FlixelSound;
			_curState = null;
			_frame = Frame;
			_iState = InitialState;
			_paused = false;
			_helpStrings = new Array();
			_helpStrings.push("Button 1");
			_helpStrings.push("Button 2");
			_helpStrings.push("Mouse");
			_helpStrings.push("Move");
			_showLogo = ShowFlixelLogo;
			_panel = new FlxPanel();
		}
		
		//@desc		Sets up the strings that are displayed on the left side of the pause game popup
		//@param	X		What to display next to the X button
		//@param	C		What to display next to the C button
		//@param	Mouse	What to display next to the mouse icon
		//@param	Arrows	What to display next to the arrows icon
		protected function help(X:String=null,C:String=null,Mouse:String=null,Arrows:String=null):void
		{
			if(X != null)
				_helpStrings[0] = X;
			if(C != null)
				_helpStrings[1] = C;
			if(Mouse != null)
				_helpStrings[2] = Mouse;
			if(Arrows != null)
				_helpStrings[3] = Arrows;
		}
		
		protected function useDefaultVolumeControls(YesPlz:Boolean):void
		{
			_defaultSoundControls = YesPlz;
		}
		
		//@desc		This function is only used by the FlxGame class to do important internal management stuff
		private function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == 192)
			{
				_console.toggle();
				return;
			}
			if(_defaultSoundControls)
			{
				var c:int = event.keyCode;
				var code:String = String.fromCharCode(event.charCode);
				switch(c)
				{
					case 48:
						FlxG.setMute(!FlxG.getMute());
			    		showSoundTray();
						return;
					case 189:
						FlxG.setMute(false);
			    		FlxG.setMasterVolume(FlxG.getMasterVolume() - 0.1);
			    		showSoundTray();
						return;
					case 187:
						FlxG.setMute(false);
			    		FlxG.setMasterVolume(FlxG.getMasterVolume() + 0.1);
			    		showSoundTray();
						return;
					default: break;
				}
			}
			FlxG.keys.handleKeyUp(event);
		}
		
		//@desc		This function is only used by the FlxGame class to do important internal management stuff
		private function onKeyDown(event:KeyboardEvent):void
		{
			FlxG.keys.handleKeyDown(event);
		}
		
		//@desc		This function is only used by the FlxGame class to do important internal management stuff
		private function onMouseUp(event:MouseEvent):void
		{
			FlxG.mouse.handleMouseUp(event);
		}
		
		//@desc		This function is only used by the FlxGame class to do important internal management stuff
		private function onMouseDown(event:MouseEvent):void
		{
			FlxG.mouse.handleMouseDown(event);
		}
		
		//@desc		This function is only used by the FlxGame class to do important internal management stuff
		private function onFocus(event:Event=null):void
		{
			if(!_panel.visible) flash.ui.Mouse.hide();
			_pausePopup.visible = false;
			FlxG.resetInput();
			_paused = false;
			FlxG.playMusic();
			stage.frameRate = 90;
		}
		
		//@desc		This function is only used by the FlxGame class to do important internal management stuff
		private function onFocusLost(event:Event=null):void
		{
			if((x != 0) || (y != 0))
			{
				x = 0;
				y = 0;
			}
			flash.ui.Mouse.show();
			_pausePopup.visible = true;
			_paused = true;
			FlxG.pauseMusic();
			stage.frameRate = 10;
		}
		
		//@desc		This is the main game loop, but only once creation and logo playback is finished
		private function onEnterFrame(event:Event):void
		{
			var i:uint;
			
			//Frame timing
			var t:uint = getTimer();
			_elapsed = (t-_total)/1000;
			_total = t;
			FlxG.elapsed = _elapsed;
			if(FlxG.elapsed > MAX_ELAPSED)
				FlxG.elapsed = MAX_ELAPSED;
			
			if(_logoComplete)
			{
				//Animate flixel HUD elements
				_panel.update();
				_console.update();
				if(_soundTrayTimer > 0)
					_soundTrayTimer -= _elapsed;
				else if(_soundTray.y > -_soundTray.height)
				{
					_soundTray.y -= _elapsed*FlxG.height*2;
					if(_soundTray.y < -_soundTray.height)
						_soundTray.visible = false;
				}
				
				//State updating
				if(!_paused)
				{
					FlxG.updateInput();
					if(_cursor != null)
					{
						_cursor.x = FlxG.mouse.x+FlxG.scroll.x;
						_cursor.y = FlxG.mouse.y+FlxG.scroll.y;
					}
					FlxG.doFollow();
					_curState.update();
					
					//Update the various special effects
					_flash.update()
					_fade.update();
					_quake.update();
					_buffer.x = _quake.x;
					_buffer.y = _quake.y;					
					
					//Clear buffer
					if(_flipped)
					{
						_bmpFront.bitmapData.fillRect(new Rectangle(0,0,_bmpFront.width,_bmpFront.height),_bgColor);
						FlxG.buffer = _bmpFront.bitmapData;
					}
					else
					{
						_bmpBack.bitmapData.fillRect(new Rectangle(0,0,_bmpBack.width,_bmpBack.height),_bgColor);
						FlxG.buffer = _bmpBack.bitmapData;
					}
					
					//Render game content, special fx, and overlays
					_curState.render();
					_flash.render();
					_fade.render();
					_panel.render();
					
					//Swap buffers
					_bmpBack.visible = !(_bmpFront.visible = _flipped);
					_flipped = !_flipped;
				}
			}
			else if(_created)
			{
				if(!_showLogo)
				{
					_logoComplete = true;
					FlxG.switchState(_iState);
				}
				else
				{
					if(_f == null)
					{
						var tmp:Bitmap;
						_f = new FlxArray();
						var scale:uint = 1;
						if(FlxG.height > 200)
							scale = 2;
						var pixelSize:uint = 32*scale;
						var top:int = FlxG.height*_zoom/2-pixelSize*2;
						var left:int = FlxG.width*_zoom/2-pixelSize;
						
						_f.push(addChild(new FlxLogoPixel(left+pixelSize,top,pixelSize,0,_fc)) as FlxLogoPixel);
						_f.push(addChild(new FlxLogoPixel(left,top+pixelSize,pixelSize,1,_fc)) as FlxLogoPixel);
						_f.push(addChild(new FlxLogoPixel(left,top+pixelSize*2,pixelSize,2,_fc)) as FlxLogoPixel);
						_f.push(addChild(new FlxLogoPixel(left+pixelSize,top+pixelSize*2,pixelSize,3,_fc)) as FlxLogoPixel);
						_f.push(addChild(new FlxLogoPixel(left,top+pixelSize*3,pixelSize,4,_fc)) as FlxLogoPixel);
						
						_poweredBy = new ImgPoweredBy;
						_poweredBy.scaleX = scale;
						_poweredBy.scaleY = scale;
						_poweredBy.x = FlxG.width*_zoom/2-_poweredBy.width/2;
						_poweredBy.y = top+pixelSize*4+16;
						var ct:ColorTransform = new ColorTransform();
						ct.color = _fc;
						_poweredBy.bitmapData.colorTransform(new Rectangle(0,0,_poweredBy.width,_poweredBy.height),ct);
						addChild(_poweredBy);
						
						_logoFade = addChild(new Bitmap(new BitmapData(FlxG.width*_zoom,FlxG.height*_zoom,true,0xFF000000))) as Bitmap;
						_logoFade.x = _gameXOffset*_zoom;
						_logoFade.y = _gameYOffset*_zoom;
						
						if(_fSound != null)
							(new _fSound).play(0,0,new SoundTransform(0.35,0));
					}
					
					_logoTimer += _elapsed;
					for(i = 0; i < _f.length; i++)
						_f[i].update();
					if(_logoFade.alpha > 0)
						_logoFade.alpha -= _elapsed*0.5;
						
					if(_logoTimer > 2)
					{
						removeChild(_poweredBy);
						for(i = 0; i < _f.length; i++)
							removeChild(_f[i]);
						_f.clear();
						removeChild(_logoFade);
						FlxG.switchState(_iState);
						_logoComplete = true;
					}
				}
			}
			else if(root != null)
			{
				//Set up the view window and double buffering
				stage.scaleMode = StageScaleMode.NO_SCALE;
	            stage.align = StageAlign.TOP_LEFT;
	            stage.frameRate = 90;
	            _buffer = new Sprite();
	            _buffer.scaleX = _zoom;
	            _buffer.scaleY = _zoom;
	            addChild(_buffer);
				_bmpBack = new Bitmap(new BitmapData(FlxG.width,FlxG.height,true,_bgColor));
				_bmpBack.x = _gameXOffset;
				_bmpBack.y = _gameYOffset;
				_buffer.addChild(_bmpBack);
				_bmpFront = new Bitmap(new BitmapData(_bmpBack.width,_bmpBack.height,true,_bgColor));
				_bmpFront.x = _bmpBack.x;
				_bmpFront.y = _bmpBack.y;
				_buffer.addChild(_bmpFront);
				_flipped = false;
				
				//Initialize game console
				_console = new FlxConsole(_gameXOffset,_gameYOffset,_zoom);
				addChild(_console);
				var vstring:String = FlxG.LIBRARY_NAME+" v"+FlxG.LIBRARY_MAJOR_VERSION+"."+FlxG.LIBRARY_MINOR_VERSION;
				var underline:String = "";
				for(i = 0; i < vstring.length+32; i++)
					underline += "-";
				FlxG.log(vstring);
				FlxG.log(underline);
				
				//Add basic input even listeners
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				
				//Initialize the pause screen
				_pausePopup = new FlxPause(_gameXOffset,_gameYOffset,_zoom,_helpStrings);
				addChild(_pausePopup);
				stage.addEventListener(Event.DEACTIVATE, onFocusLost);
				stage.addEventListener(Event.ACTIVATE, onFocus);
				
				//Sound Tray popup
				_soundTray = new Sprite();
				_soundTray.visible = false;
				_soundTray.scaleX = 2;
				_soundTray.scaleY = 2;
				tmp = new Bitmap(new BitmapData(80,30,true,0x7F000000));
				_soundTray.x = (_gameXOffset+FlxG.width/2)*_zoom-(tmp.width/2)*_soundTray.scaleX;
				_soundTray.addChild(tmp);
				
				var text:TextField = new TextField();
				text.width = tmp.width;
				text.height = tmp.height;
				text.multiline = true;
				text.wordWrap = true;
				text.selectable = false;
				text.embedFonts = true;
				text.antiAliasType = AntiAliasType.NORMAL;
				text.gridFitType = GridFitType.PIXEL;
				text.defaultTextFormat = new TextFormat("system",8,0xffffff,null,null,null,null,null,"center");;
				_soundTray.addChild(text);
				text.text = "VOLUME";
				text.y = 16;
				
				var bx:uint = 10;
				var by:uint = 14;
				_soundTrayBars = new Array();
				for(i = 0; i < 10; i++)
				{
					tmp = new Bitmap(new BitmapData(4,i+1,false,0xffffff));
					tmp.x = bx;
					tmp.y = by;
					_soundTrayBars.push(_soundTray.addChild(tmp));
					bx += 6;
					by--;
				}
				addChild(_soundTray);

				//Initialize the decorative frame (optional)
				if(_frame != null)
				{
					var bmp:Bitmap = new _frame;
					bmp.scaleX = _zoom;
					bmp.scaleY = _zoom;
					addChild(bmp);
				}
				
				//All set!
				_created = true;
				_logoTimer = 0;
			}
		}
		
		//@desc		This function is only used by the FlxGame class to do important internal management stuff
		private function showSoundTray():void
		{
			FlxG.play(SndBeep);
			_soundTrayTimer = 1;
			_soundTray.y = _gameYOffset*_zoom;
			_soundTray.visible = true;
			var gv:uint = Math.round(FlxG.getMasterVolume()*10);
			if(FlxG.getMute())
				gv = 0;
			for (var i:uint = 0; i < _soundTrayBars.length; i++)
			{
				if(i < gv) _soundTrayBars[i].alpha = 1;
				else _soundTrayBars[i].alpha = 0.5;
			}
		}
		
		//@desc		Set up the support panel thingy with donation and aggregation info
		//@param	PayPalID		Your paypal username, usually your email address (leave it blank to disable donations)
		//@param	PayPalAmount	The default amount of the donation
		//@param	GameTitle		The text that you would like to appear in the aggregation services (usually just the name of your game)
		//@param	GameURL			The URL you would like people to use when trying to find your game
		protected function setupSupportPanel(PayPalID:String,PayPalAmount:Number,GameTitle:String,GameURL:String,Caption:String):void
		{
			_panel.init(PayPalID,PayPalAmount,GameTitle,GameURL,Caption);
		}
	}
}
