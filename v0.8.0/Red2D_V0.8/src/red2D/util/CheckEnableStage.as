package red2D.util
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**  
	 * stage가 정상적으로 사용가능한 상태인지를 체크
	 * / Last update - July 25, 2011
	 * @author 백선기(seon ki, Paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11 Beta 
	 * 
	 */ 
	public class CheckEnableStage extends Sprite
	{
		public static const ENABLE_STAGE:String = "ENABLE_STAGE"		
		private var _enableStage:Boolean = false			
			
		public function CheckEnableStage()
		{
			addEventListener(Event.ADDED_TO_STAGE, setCheckStage)
		}

		/**
		 * stage가 익스플로어에서 사용할 수 있는 상태인지를 체크한다. 
		 * @param $event
		 * 
		 */		
		private function setCheckStage( $event:Event ):void {		
			addEventListener(Event.ENTER_FRAME, tempLoop );
		}
		
		/**
		 * stage 사용가능확인
		 * @param event
		 * 
		 */		
		private function tempLoop( $event:Event ):void {
				if ( stage.stageWidth > 0 && stage.stageHeight > 0 ) {
					removeEventListener( Event.ENTER_FRAME, tempLoop );
					trace(":::::::::: Stage Test : Pass!!")
					dispatchEvent(new Event(ENABLE_STAGE))	
					_enableStage=true
				}						
		}		
		
		public function get enableStage():Boolean
		{
			return _enableStage;
		}
		
		public function set enableStage(value:Boolean):void
		{
			_enableStage = value;
		}
	}	
}
