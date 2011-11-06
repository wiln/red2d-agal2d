package red2D.filter.fragmentBasic
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;
	
	/**
	 * <p>엠보스필터</p>
	 * Last update - OCT 28, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class EmbossFilter extends AFilterBase
	{		
		private var _strength:Number;
		public function EmbossFilter( $strength:Number =0.5 )
		{
			strength = $strength
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
			agal_code=
				//ft7는 이전에 연산된 픽셀쉐이더 정점정보를 가진다
				
				// uv계산
				"mov ft1 ft7\n"+
				"add ft1.xy, ft1.xy, fc"+$indexNum +".x\n"+	
				
				// 텍스쳐화
				"tex ft2, ft1, ft0 <2d,clamp,linear>\n"+
				"mul ft2, ft2, fc"+$indexNum +".y\n"+	
				"sub ft2, ft0, ft2\n"+
				
				// 이미지 합산을 위해서 저장
				"mov ft3 ft2\n"+
				
				// uv계산
				"mov ft1 ft7\n"+
				"sub ft1.xy, ft1.xy, fc"+$indexNum +".x\n"+		
				
				// 텍스쳐화
				"tex ft2, ft1, ft0 <2d,clamp,linear>\n"+
				"mul ft2, ft2, fc"+$indexNum +".y\n"+	
				"add ft2, ft3, ft2\n"+	
				
				// 최종 필터 합산을 위하여 텍스쳐 최종 결과값으 ft0으로 반환합니다.
				"mov ft0, ft2\n"							
			
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
			constVector1.push(0.001,_strength, 1, 1)
		}
		
		public function get strength():Number
		{
			return _strength
		}
		
		public function set strength(value:Number):void
		{
			_strength = value;
			resetConst()
		}
		
	}
}