package Red2D.projectInfomation{
	
	import flash.events.EventDispatcher;
	
	/**  
	 * (사용자 접근 필요없음) BaseClass 사용을 체크하는 Class 
	 * / Last update - Date -2010.05.10
	 * @author 백선기(seon ki, paik), http://redcamel-studio.tistory.com
	 */ 
	
	public class InfoLogger extends EventDispatcher {
		/**
		 * InfoLogger의 반복실행을 체크하기 위한 변수
		 */
		public static var InfoLogger:Number = 0;
		
		/**
		 * BaseClass에 관한 정보를 출력합니다.
		 */		
		public static function traceLogger ():void {
			
			if (InfoLogger == 0)
			{
				InfoLogger = 1;
				traceLogger ();
				trace("--------------------------------------------------------------------------------------------------------------")
				trace (ProjectInfomation.NAME,"VERSION",ProjectInfomation.VERSION,ProjectInfomation.AUTHOR,ProjectInfomation.DATE);
				trace ("http://redcamel-studio.tistory.com");
				trace("--------------------------------------------------------------------------------------------------------------")
			}
			else
			{
				//trace ("기존의 로거 실행이 확인되었습니다");
			}
		}
	}
}