package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/**
	 * <p>야간 투시경효과</p>
	 * Last update - OCT 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class NightVisionFilter extends AFilterBase
	{

		public function NightVisionFilter()
		{
			resetConst()
			
			type = FilterType.FRAGMENT_BASIC
		}
		
		/**
		 * 필터의 커스텀 AGAL코드
		 * @param $indexNum
		 * 
		 */			
		public override function make_AGAL_code( $indexNum:int ):String{
			//agal_code = "add ft0, ft0, fc"+$indexNum+"\n"
			agal_code = 
				"mov ft1, ft0\n"+
				"mul ft1.rgb, ft1.rgb, fc"+$indexNum+".xyz\n"+	
				"sqt ft1.rgb, ft1.rgb\n"+	
				"mul ft1.rgb, ft1.rgb, ft0.xyz\n"+				
				"sqt ft1.rgb, ft1.rgb\n"+
				"mov ft1.w, ft0.w\n"+					
				"mov ft0, ft1\n"
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
			//constVector1.push(-0.3, 0.2, -0.3, 0)
			constVector1.push(0, 0.3, 0,1)
		}
	}
}