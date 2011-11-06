package red2D.util
{
	/**  
	 * <p>거듭제곱인지를 판단하고 인수보다큰 가장 가까운 다음 거듭제곱을 반환 </p>
	 * Last update - July 25, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * 
	 */
	public class CheckPower
	{
		public function CheckPower()
		{
		}
		
		/**
		 * checkNum이 거듭제곱인지를 판단하고 인수보다큰 가장 가까운 다음 거듭제곱을 반환 
		 * @param $checkNum
		 * @return 
		 * 
		 */		
		static public function Check( $checkNum:Number ):int {
			var checkNum:Number = 1
			for( var i:Number=0 ; i < 100 ; i++){
				if( $checkNum <= checkNum ){
					break
				}					
				checkNum = checkNum*2
			}			
			return checkNum			
		}
	}
}


