package red2D.material
{
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	
	import red2D.util.CheckPower;

	/**  
	 * <p>BitmapData를 재질로 지정하는 Class</p>
	 * Last update - Oct 13, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 * 
	 */ 
	public class BitmapMaterial extends MaterialBase
	{
		public function BitmapMaterial( $bitmapData:BitmapData, $format:String = Context3DTextureFormat.BGRA, $optimizeRenderToTexture:Boolean=false)
		{			
			// 실제 사이즈 입력
			_inputWidth =$bitmapData.width
			_inputHeight =$bitmapData.height
			
			// 생성할 사이즈 리턴
			_width =  CheckPower.Check(_inputWidth)
			_height = CheckPower.Check(_inputHeight)
				
			// 실제사이즈와 생성사이즈 사이의 비율을 구함
			_sizeRatioWidth =  _width/_inputWidth
			_sizeRatioHeight =  _height/_inputHeight		
				
			// 비율보간 매트릭스
			_mapRatioMatrix.scale(_sizeRatioWidth, _sizeRatioHeight)
				
			_bitmapData = new BitmapData( _width , _height , true , 0x00ffffff)
			_bitmapData.draw($bitmapData,_mapRatioMatrix,null,null,null,true)
				
			_texture= _context3d.createTexture( _width , _height , $format , $optimizeRenderToTexture );
			_texture.uploadFromBitmapData( _bitmapData);			
		}	
	
	}
}