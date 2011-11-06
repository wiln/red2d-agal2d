package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/**
	 * <p>색상을 모노톤으로 변경합니다.</p>
	 * Last update - OCT 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class MonoFilter extends AFilterBase
	{		
		public function MonoFilter()
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
			agal_code = "dp3 ft0.xyz, ft0.xyz, fc"+$indexNum+"\n" 
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
			constVector1.push(0.333, 0.333, 0.333, 1)
		}
	}
}