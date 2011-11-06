package red2D.filter.fragmentUV
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/**
	 * <p>UV기반의 Move 필터입니다.</p>
	 * Last update - OCT 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class UV_OffsetFilter extends AFilterBase
	{
		private var _centerX:Number;
		private var _centerY:Number;
		
		public function UV_OffsetFilter( $moveX:Number=0.5, $moveY:Number=0.5)
		{
			constVectorNum=1
				
			_centerX = $moveX	
			_centerY = $moveY	
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
				
				"add ft1.x, ft1.x, fc"+$indexNum +".x\n"+
				"frc ft1.xyz, ft1.xyz\n"+
				"add ft1.y, ft1.y, fc"+$indexNum +".y\n"+
				"frc ft1.xyz, ft1.xyz\n"+
				
				// uv 결과값 저장  최종필터 합산을 위하여 uv계산이 종료된후 반드시 ft7로 저장합니다.
				"mov ft7 ft1\n"+
				
				// 텍스쳐화
				"tex ft2, ft1, ft0 <2d,clamp,linear>\n"+
				
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
			constVector1.push(_centerX, _centerY, 1, 1)
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



	}
}
