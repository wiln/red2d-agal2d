package game
{
	import com.greensock.motionPaths.Direction;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import red2D.system.Red2D;
	
	/** 
	 * Frame/ Last update - Oct 4, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Frame extends Sprite
	{
		[Embed( source = "./resource/game/bottom.png" )]
		private var Bottom:Class;
		
		[Embed( source = "./resource/game/left_pan.png" )]
		private var LeftSystem:Class;
		
		[Embed( source = "./resource/game/left_pan2.png" )]
		private var LeftSystem2:Class;
		
		
		[Embed( source = "./resource/game/right_pan.png" )]
		private var RightSystem:Class;
		
		[Embed( source = "./resource/game/right_top.png" )]
		private var RightTop:Class;
		
		
		[Embed( source = "./resource/game/info.png" )]
		private var Information:Class;
		
		[Embed( source = "./resource/game/btLine.png" )]
		private var BtLine:Class;
		
		[Embed( source = "./resource/game/logo.png" )]
		private var Logo:Class;
		
		[Embed( source = "./resource/game/direction.png" )]
		private var Direction_t:Class;

		[Embed( source = "./resource/game/direction2.png" )]
		private var Direction_b:Class;
		
		[Embed( source = "./resource/game/direction_left.png" )]
		private var Direction_l:Class;
		
		[Embed( source = "./resource/game/direction_right.png" )]
		private var Direction_r:Class;
		
		private var _bottom:Bitmap;
		private var _leftSystem:Bitmap;
		private var _rightSystem:Bitmap;
		private var _leftSystem2:Bitmap;
		private var _information:Bitmap
		private var _btLine:Bitmap;
		private var _logo:Bitmap;
		private var _rightTop:Bitmap;
		private var _direction_t:Bitmap;
		private var _direction_b:Bitmap;
		private var _direction_l:Bitmap;
		private var _direction_r:Bitmap;
		
		public function Frame()
		{
			setFrame()
		}
		
		private function setFrame():void
		{
			_bottom = new Bottom()				
			_leftSystem = new LeftSystem()
			_leftSystem2 = new LeftSystem2()
			_rightSystem = new RightSystem()
			_information = new Information()
			_btLine = new BtLine()
			_logo = new Logo()
			_rightTop = new RightTop()
			_direction_t = new Direction_t()
			_direction_b = new Direction_b()
			_direction_l = new Direction_l()
			_direction_r = new Direction_r()

				
			addChild(_logo)
			
			addChild(_bottom)
			addChild(_information)
			addChild(_btLine)
			addChild(_leftSystem)
			addChild(_leftSystem2)
			addChild(_rightSystem)
			addChild(_rightTop)
			addChild(_direction_t)
			addChild(_direction_b)
			addChild(_direction_l)
			addChild(_direction_r)
			
			HD_resize()
			
			Red2D.targetStage.addEventListener(Event.RESIZE, HD_resize)
		}
		
		protected function HD_resize(event:Event=null):void
		{
			var targetStage:Stage = Red2D.targetStage
				
			_logo.x=10
			_logo.y=10
				
			_bottom.y = targetStage.stageHeight - _bottom.height
			_leftSystem.y = targetStage.stageHeight - _leftSystem.height
			_leftSystem2.y = targetStage.stageHeight - _leftSystem2.height+10
			_rightSystem.y = targetStage.stageHeight - _rightSystem.height
				
			_information.y = targetStage.stageHeight - _information.height-190
			_btLine.y = targetStage.stageHeight - _btLine.height
				
			_bottom.x = (targetStage.stageWidth - _bottom.width)/2
			_btLine.x = (targetStage.stageWidth - _btLine.width)/2
			_leftSystem.x = 0
			_leftSystem2.x = 280
			_rightSystem.x = targetStage.stageWidth - _rightSystem.width
			_rightTop.x = targetStage.stageWidth - _rightTop.width
				
			_direction_t.x = (targetStage.stageWidth - _direction_t.width)/2
			_direction_t.y=10
				
			_direction_b.x = (targetStage.stageWidth - _direction_b.width)/2
			_direction_b.y=targetStage.stageHeight-150
				
			_direction_l.x = 10
			_direction_l.y=targetStage.stageHeight/2
				
			_direction_r.x = targetStage.stageWidth-70
			_direction_r.y= targetStage.stageHeight/2
				
			_information.x=10
		}
	}
}

