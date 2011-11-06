package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;
	
	/**
	 * <p>이미지를 Black과 White로만 표현합니다.</p>
	 * Last update - OCT 24, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class BlackAndWhite extends AFilterBase
	{
		
		private var _referenceValue:Number=0.5
		
		public function BlackAndWhite($referenceValue:Number =0.5)
		{			
			constVectorNum=2
			referenceValue = $referenceValue
			resetConst()
			
			type = FilterType.FRAGMENT_BASIC
		}
		
		/**
		 * 필터의 커스텀 AGAL코드
		 * @param $indexNum
		 * 
		 */			
		public override function make_AGAL_code( $indexNum:int ):String{
			agal_code=
				//ft7는 이전에 연산된 픽셀쉐이더 정점정보를 가진다
				//ft0는 이전에 연산된 픽셀쉐이더 컬러정보를 가진다
/*				"mov ft1, ft0\n"+
				"dp3 ft1.xyz, ft1.xyz, fc1.xyz\n"+
				"sge ft1.r, ft1.r, fc2.x\n"+
				"sge ft1.g, ft1.g, fc2.x\n"+
				"sge ft1.b, ft1.b, fc2.x\n"+
				"mov ft0, ft1\n"*/
				"mov ft1, ft0\n"+
				"dp3 ft1.xyz, ft1.xyz, fc1.xyz\n"+
				"sge ft1.r, ft1.r, fc2.x\n"+
				"sge ft1.g, ft1.g, fc2.x\n"+
				"sge ft1.b, ft1.b, fc2.x\n"+
				
				"mov ft0, ft1\n"
			
			// 최종 필터 합산을 위하여 텍스쳐 최종 결과값으 ft0으로 반환합니다.
			
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
			constVector1.push(0.333,0.333,0.333,1)
			
			constVector2 = null
			constVector2 = new Vector.<Number>
			constVector2.push(_referenceValue,1,1,1)
			
		}
		public function get referenceValue():Number
		{
			return _referenceValue
		}
		
		public function set referenceValue(value:Number):void
		{
			_referenceValue = value;
			resetConst()
		}
	}
}
