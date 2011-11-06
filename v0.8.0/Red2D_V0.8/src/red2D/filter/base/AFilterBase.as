package red2D.filter.base
{
	/** 
	 * <p>Filter 기본 추상클래스</p>
	 * <p>Last update - Oct 26, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class AFilterBase
	{
		/**
		 * 업로드할 상수벡터1 
		 */		
		public var constVector1:Vector.<Number>= new Vector.<Number>
		/**
		 * 업로드할 상수벡터2 
		 */
		public var constVector2:Vector.<Number>= new Vector.<Number>
		/**
		 * 업로드할 상수벡터3 
		 */
		public var constVector3:Vector.<Number>= new Vector.<Number>
		/**
		 * 업로드할 상수벡터4 
		 */
		public var constVector4:Vector.<Number>= new Vector.<Number>
		
		/**
		 * 쉐이더의 AGAL코드 
		 */		
		public var agal_code:String =""
		
		/**
		 * 상수벡터의 갯수 
		 */		
		public var constVectorNum:int = 1
		
		/**
		 * 필터가의 타입을 지정
		 */			
		public var type:String = ""
			
		/**
		 * 필터만의 고유 AGAL코드를 생성(실제 AGAL코드작성부분)
		 * @param $indexNum
		 * @return 
		 * 
		 */		
		public function make_AGAL_code( $indexNum:int ):String{
			return ""
		}
		
		/**
		 * 상수재설정 
		 * 
		 */		
		protected function resetConst():void
		{
		}
	}
}