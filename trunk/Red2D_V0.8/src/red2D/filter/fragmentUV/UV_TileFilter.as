package red2D.filter.fragmentUV
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;
	
	/**
	 * <p>UV Tile필터</p>
	 * <p>타일필터는 세분화 할수록 다른 필터에비해 GPU연산 부하가 많이 걸립니다</p>
	 * Last update - OCT 24, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class UV_TileFilter extends AFilterBase
	{
		private var _tileScale:Number=1
		
		public function UV_TileFilter( $scale:Number=0)
		{			
			constVectorNum=1
			tileScale = $scale
			
			resetConst()
			
			type = FilterType.FRAGMENT_UV
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
				"mov ft1, ft7\n"+						
				"sub ft1, fc"+$indexNum +".xy, ft1.xy\n"+ // 0.0을 기준점으로 변환함								
				"div ft2, ft1, ft1\n"+
				"div ft2, ft2, fc"+$indexNum +".w\n"+
				"mul ft2.xyz, ft1.xyz, ft2.xyz\n"+
				"sub ft2.xy, ft2.xy, fc"+$indexNum +".xy\n"+ // uv를 가운대로 맞춤
				"frc ft2.xyz, ft2.xyz\n"+ //fractional - 이걸분수함수화라고 해석해야하나 -_-
				
				// uv 결과값 저장  최종필터 합산을 위하여 uv계산이 종료된후 반드시 ft7로 저장합니다.
				"mov ft7, ft2\n"+	
				
				// 텍스쳐화
				"tex ft3, ft2, fs0 <2d,clamp,linear>\n"+
				
				// 최종 필터 합산을 위하여 텍스쳐 최종 결과값으 ft0으로 반환합니다.
				"mov ft0, ft3\n"
			
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
			constVector1.push(0.5, 0.5, 0.01 ,_tileScale-1)
		}
		/********************************************************************************/
		/** get/set  **/
		/********************************************************************************/	
		
		/**
		 * tile 강도
		 */
		public function get tileScale():Number
		{
			return _tileScale;
		}
		
		/**
		 * @private
		 */
		public function set tileScale(value:Number):void
		{
			_tileScale = value
			if(_tileScale==1){
				_tileScale = 0.99
			}
			resetConst()
		}
	}
}
