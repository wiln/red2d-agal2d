package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/**
	 * <p>이미지색상에 네온사인효과를 더합니다.</p>
	 * Last update - OCT 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */	
	public class NeonSign extends AFilterBase
	{
		private var _r:Number = 0.2
		private var _g:Number = 0.2
		private var _b:Number = 0.2
		
		public function NeonSign( $r:Number=0.2,$g:Number=0.2,$b:Number=0.2 )
		{
			_r = $r
			_g = $g
			_b = $b
				
			resetConst()
			type = FilterType.FRAGMENT_BASIC
		}
		
		/**
		 * 필터의 커스텀 AGAL코드
		 * @param $indexNum
		 * 
		 */			
		public override function make_AGAL_code( $indexNum:int ):String{
			agal_code = "add ft0, ft0, fc"+$indexNum+"\n" 
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
			constVector1.push(_r, _g, _b, 0)
		}
		
		/********************************************************************************/
		/** get/set  **/
		/********************************************************************************/	
		
		/**
		 * red 가중치 
		 */
		public function get r():Number
		{
			return _r;
		}

		/**
		 * @private
		 */
		public function set r(value:Number):void
		{
			_r = value;
			resetConst()
		}
		
		
		/**
		 * green 가중치 
		 */
		public function get g():Number
		{
			return _g;
		}

		/**
		 * @private
		 */
		public function set g(value:Number):void
		{
			_g = value;
			resetConst()
		}

		/**
		 * blue 가중치 
		 */
		public function get b():Number
		{
			return _b;
		}

		/**
		 * @private
		 */
		public function set b(value:Number):void
		{
			_b = value;
			resetConst()
		}


	}
}