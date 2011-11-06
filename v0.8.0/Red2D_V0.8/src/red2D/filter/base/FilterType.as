package red2D.filter.base
{
	/** 
	 * <p>필터쉐이더의 유형을 구분</p>
	 * Last update - OCT 28, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class FilterType
	{
		/**
		 * 쉐이더 결과값을 fragment픽셀에만 저장하는 타입
		 */		
		public static const FRAGMENT_BASIC:String = "fragmentBasic"
			
		/**
		 * 쉐이더 결과값을 공용 UV에 저장하는 타입
		 */			
		public static const FRAGMENT_UV:String = "fragmentUV"
	
	}
}