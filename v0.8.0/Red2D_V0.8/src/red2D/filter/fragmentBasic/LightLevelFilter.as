package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/**
	 * <p>이미지중 밝은 부분의 강도를 조절하실 수 있습니다.</p>
	 * Last update - OCT 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class LightLevelFilter extends AFilterBase
	{
		private var _lightStrength:Number=1
		
		public function LightLevelFilter( $light:Number=2)
		{			
			constVectorNum=1
			lightStrength = $light
				
			resetConst()
			
			type = FilterType.FRAGMENT_BASIC
		}
		
		/**
		 * 필터의 커스텀 AGAL코드
		 * @param $indexNum
		 * 
		 */			
		public override function make_AGAL_code( $indexNum:int ):String{
			agal_code="mul ft0.xyz, ft0.xyz, fc"+$indexNum +".w\n"
				
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
			constVector1.push(1, 1, 1 ,_lightStrength)
		}
		/********************************************************************************/
		/** get/set  **/
		/********************************************************************************/	
		
		/**
		 * 밝은부분의 강도
		 */
		public function get lightStrength():Number
		{
			return _lightStrength;
		}

		/**
		 * @private
		 */
		public function set lightStrength(value:Number):void
		{
			_lightStrength = value;
			resetConst()
		}
	}
}
