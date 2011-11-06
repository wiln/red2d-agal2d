package red2D.filter.fragmentUV
{
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;
	
	/**
	 * <p>UV_Wave</p>
	 * Last update - OCT 29, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class UV_Wave extends AFilterBase
	{
		
		private var _wavelength:Number=0.5
		private var _amplitude:Number=0.5
		
		public function UV_Wave( $wavelength:Number = 200, $amplitude:Number = 1)
		{			
			constVectorNum=1
			wavelength = $wavelength
			amplitude = $amplitude
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
				//ft0는 이전에 연산된 픽셀쉐이더 컬러정보를 가진다
				"mov ft1, ft7\n"+
				"mov ft6, fc1\n"+
				
				"mul ft1.x, ft1.x, ft6.x\n"+
				"sin ft1.x, ft1.x\n"+
				"mul ft1.x, ft1.x, ft6.y\n"+
				"add ft1.y, ft1.y, ft1.x\n"+
				"mov ft1.x, ft7.x\n"+

				// uv 결과값 저장  최종필터 합산을 위하여 uv계산이 종료된후 반드시 ft7로 저장합니다.
				"mov ft7, ft2\n"+	
				
				"tex ft3, ft1, fs0 <2d,clamp,linear>\n"+
				
				//ft0애에 결과값을저장한다.
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
			constVector1.push(_wavelength,_amplitude,1,1)
			
		}
		public function get wavelength():Number
		{
			return _wavelength
		}
		
		public function set wavelength(value:Number):void
		{
			_wavelength = value;
			resetConst()
		}
		
		public function get amplitude():Number
		{
			return _amplitude;
		}
		
		public function set amplitude(value:Number):void
		{
			_amplitude = value/100;
			resetConst()
		}
		
	}
}
