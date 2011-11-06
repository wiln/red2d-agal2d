package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/**
	 * <p>색상을 반전시킵니다.</p>
	 * Last update - OCT 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class InvertFilter extends AFilterBase
	{
		
		public function InvertFilter()
		{
			constVectorNum=1
			resetConst()
			type = FilterType.FRAGMENT_BASIC
		}
		
		/**
		 * 필터의 커스텀 AGAL코드
		 * @param $indexNum
		 * 
		 */		
		public override function make_AGAL_code( $indexNum:int ):String{
			agal_code = 
				"neg ft0.xyz, ft0.xyz\n"+
				"add ft0, ft0, fc"+$indexNum+"\n"				
			return agal_code
		}
		
		/**
		 * const 재입력 
		 * 
		 */		
		protected override function resetConst():void
		{
			constVector1 = null
			constVector1 = new Vector.<Number>
			constVector1.push(1, 1, 1, 0)
		}
	}
}