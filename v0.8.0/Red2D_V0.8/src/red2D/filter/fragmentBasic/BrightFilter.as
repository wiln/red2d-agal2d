package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;
	
	/**
	 * 밝기조정필터 
	 * @author redcamel
	 * 
	 */	
	public class BrightFilter extends AFilterBase
	{
		private var _brightStrength:Number=0.7
			
		public function BrightFilter( $brightStrength:Number=0.7)
		{			
			constVectorNum=1
				
			brightStrength = $brightStrength
			resetConst()
			
			type = FilterType.FRAGMENT_BASIC
		}
		
		/**
		 * 필터의 커스텀 AGAL코드
		 * @param $indexNum
		 * 
		 */			
		public override function make_AGAL_code( $indexNum:int ):String{
			agal_code="add ft0.xyz, ft0.xyz, fc"+$indexNum +".w\n"				
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
			constVector1.push(1, 1, 1 ,_brightStrength)
		}
		/********************************************************************************/
		/** get/set  **/
		/********************************************************************************/	
		
		/**
		 * 밝기강도 
		 */
		public function get brightStrength():Number
		{
			return _brightStrength;
		}

		/**
		 * @private
		 */
		public function set brightStrength(value:Number):void
		{
			_brightStrength = value;
			resetConst()
		}
	}
}
