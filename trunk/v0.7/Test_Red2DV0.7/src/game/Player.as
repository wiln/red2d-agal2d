package game
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import red2D.display.Red_Sprite;
	import red2D.system.Red2D;

	/** 
	 * Player/ Last update - Sep 23, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Player extends Unit
	{
		private var _rect2:Rectangle;
		protected var _rectDebug2:Red_Sprite
		public function Player($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			super($width, $height, $x, $y);
			_rectDebug	=  new Red_Sprite($width,30,0,0)
			_rectDebug.alpha=0.3
			_rectDebug2	=  new Red_Sprite(30,$height,0,0)
			_rectDebug2.alpha=0.3
		}
		/**
		 * 상태업데이트 
		 * 
		 */		
		public function keyStateUpdate( $keyState:KeyBoardState):void{
			if($keyState.leftKey) {
				_vx -=2
			}else if($keyState.rightKey) {
				_vx +=2;
			}
			
			if($keyState.upKey) {
				_vy -=2
			}else if($keyState.downKey) {
				_vy +=2
			}			
			
		}
		
		
		public override function update():void
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
			
			if(_y >= targetStage.stageHeight-100) {
				_y = targetStage.stageHeight-100;
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
		public override function checkCollison( $rect:Rectangle ):Boolean{
			_rect = new Rectangle(_x-_width/2,_y-_height/2,_width,_height)
			_rect2 = new Rectangle(_x-_width/2,_y-_height/2,_width,_height)
			
			
			if(_rect.intersects( $rect )){
				return true
			}else{
				return false
			}
		}
		
		public override function get drawDebugCollision():Boolean
		{
			return _drawDebugCollision;
		}
		
		public override function set drawDebugCollision(value:Boolean):void
		{
			if(_drawDebugCollision){
				removeChild(_rectDebug)
				removeChild(_rectDebug2)
			}			
			if(value){
				addChild(_rectDebug)
				addChild(_rectDebug2)
			}
			_drawDebugCollision = value;
		}
	}
}

