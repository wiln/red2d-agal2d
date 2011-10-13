package game
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import red2D.display.Red_SequenceSprite;
	import red2D.display.Red_Sprite;
	import red2D.display.SequenceManager;
	import red2D.material.SequenceMaterial;
	import red2D.system.Red2D;
	
	/** 
	 * Unit/ Last update - Sep 21, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Unit extends Red_SequenceSprite
	{
		protected var _vx:Number=1
		protected var _vy:Number=1
		protected var _dead:Boolean = false
		/**
		 * 충돌 판정 rectangle 
		 */		
		protected var _rect:Rectangle;
		protected var _rectDebug:Red_Sprite 
		protected var _drawDebugCollision:Boolean =false
		
		/**
		 * 유닛 기본클래스 생성자
		 * @param $width
		 * @param $height
		 * @param $x
		 * @param $y
		 * @param $alpha
		 * 
		 */		
		public function Unit($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0 )
		{
			super($width, $height, $x, $y);	
			_rectDebug	=  new Red_Sprite($width,$height,0,0)
			_rectDebug.alpha=0.3
		
		}		
		
		
		
		
		public function update():void
		{
			x+=_vx
			y+=_vy
			var targetStage:Stage = Red2D.targetStage
			if(_x >= targetStage.stageWidth) {
				_x = targetStage.stageWidth;
				//x축의 벽만, 작용과 반작용의 법칙을 넣음
				_vx *= 0
			}
			if(_x <= 0) {
				_x = 0;
				_vx *= 0
			}			 
			
			if(_y >= targetStage.stageHeight) {
				_y = targetStage.stageHeight;
				//x축의 벽만, 작용과 반작용의 법칙을 넣음
				_vy *= 0
			}
			if(_y <= -100) {
				_y = -100;
				_vy *= 0
			}
			
			_vx *= 0.6
			_vy *= 0.6
				
		}	
		
		/**
		 * 충돌판정 
		 * @param $rect
		 * @return 
		 * 
		 */		
		public function checkCollison( $rect:Rectangle ):Boolean{
			_rect = new Rectangle(_x-_width/2,_y-_height/2,_width,_height)

			
			if(_rect.intersects( $rect )){
				return true
			}else{
				return false
			}
		}
		/********************************************************************/
		/** get / set ***/
		/********************************************************************/
		
		/**
		 * 가로이동속도 
		 */
		public function get vx():Number
		{
			return _vx;
		}

		/**
		 * @private
		 */
		public function set vx(value:Number):void
		{
			_vx = value;
		}

		/**
		 * 세로이동 속도 
		 */
		public function get vy():Number
		{
			return _vy;
		}

		/**
		 * @private
		 */
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		
		public function get rect():Rectangle{
			return new Rectangle(_x,_y,_width, _height)
		}

		public function get dead():Boolean
		{
			return _dead;
		}

		public function set dead(value:Boolean):void
		{
			_dead = value;
		}

		public function get drawDebugCollision():Boolean
		{
			return _drawDebugCollision;
		}

		public function set drawDebugCollision(value:Boolean):void
		{
			if(_drawDebugCollision){
				removeChild(_rectDebug)
			}			
			if(value){
				addChild(_rectDebug)
			}
			_drawDebugCollision = value;
		}


	}
}
