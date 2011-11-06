package red2D.util
{
	/** 
	 * RGB - RGB채널을 분리해주는 Class/ Last update - Aug 21, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 */
	public class RGB_separator
	{
		public static function divide( $targetColor:int = 0x000000 ):Array{
			
			var _colorOfContext3D:int = $targetColor
			var _color_Data:Array =[]
				
			_color_Data[uint(0)] = ( (_colorOfContext3D >> 16) & 0xff)/0xff;
			_color_Data[uint(1)] = ( (_colorOfContext3D >> 8) & 0xff)/0xff;
			_color_Data[uint(2)] = (_colorOfContext3D & 0xff)/0xff;
			
			return _color_Data
		}
	}
}

