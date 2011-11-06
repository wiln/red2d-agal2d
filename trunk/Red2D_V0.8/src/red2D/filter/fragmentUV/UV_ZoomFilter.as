package red2D.filter.fragmentUV
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/**
	 * <p>UV기반의 zoom 필터입니다.</p>
	 * Last update - OCT 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class UV_ZoomFilter extends AFilterBase
	{
		private var _centerX:Number;
		private var _centerY:Number;
		private var _zoomScale:Number;
				
		public function UV_ZoomFilter( $centerX:Number=0.5, $centerY:Number=0.5, $zoomScale:Number=0)
		{
			constVectorNum=1
				
			_centerX = $centerX	
			_centerY= $centerY	
			_zoomScale = $zoomScale
				
			resetConst()
			type = FilterType.FRAGMENT_UV
		}
		
		/**
		 * 필터리스트 번호에따라 새롭게 지정 
		 * @param $indexNum
		 * 
		 */		
		public override function make_AGAL_code( $indexNum:int ):String{
				agal_code=
				//ft7는 이전에 연산된 픽셀쉐이더 정점정보를 가진다
					
				// uv계산
				"mov ft1 ft7\n"+
				
				"sub ft1.xy, ft1.xy, ft7.xy\n"+
				"mul ft1.xy, ft1.xy, ft7.z\n"+
				"add ft1.xy, ft1.xy, ft7.xy\n"+
				
				"sub ft1.xy, ft1.xy, fc"+$indexNum +".xy\n"+
				"mul ft1.xy, ft1.xy, fc"+$indexNum +".z\n"+
				"add ft1.xy, ft1.xy, fc"+$indexNum +".xy\n"+
				
				// 텍스쳐화
				"tex ft2, ft1, ft0 <2d,clamp,linear>\n"+
				
				// uv 결과값 저장  최종필터 합산을 위하여 uv계산이 종료된후 반드시 ft7로 저장합니다.
				"mov ft7 ft1\n"+
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
			
			constVector1.push(_centerX, _centerY, 1-_zoomScale, 1)
		}
		
		/********************************************************************************/
		/** get/set  **/
		/********************************************************************************/	
		
		/**
		 * 가로중심 (가로 전체를 1로봤을때 비율을 뜻합니다)
		 */
		public function get centerX():Number
		{
			return _centerX;
		}

		/**
		 * @private
		 */
		public function set centerX(value:Number):void
		{
			_centerX = value;
			resetConst()
		}

		/**
		 * 세로중심 (세로 전체를 1로봤을때 비율을 뜻합니다)
		 */
		public function get centerY():Number
		{
			return _centerY;
		}

		/**
		 * @private
		 */
		public function set centerY(value:Number):void
		{
			_centerY = value;
			resetConst()
		}

		/**
		 * 줌 값
		 */
		public function get zoomScale():Number
		{
			return _zoomScale;
		}

		/**
		 * @private
		 */
		public function set zoomScale(value:Number):void
		{
			_zoomScale = value;
			resetConst()
		}


	}
}
