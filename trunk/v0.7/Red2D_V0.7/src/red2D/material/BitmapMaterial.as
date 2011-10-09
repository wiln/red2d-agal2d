package red2D.material
{
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import red2D.system.Red2D;

	/**  
	 * <p>BitmapData를 재질로 지정하는 Class</p>
	 * Last update - July 25, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 * 
	 */ 
	public class BitmapMaterial extends MaterialBase
	{
		private var _prevNum:int =0;
		private var _rect:Rectangle;
		private var _point:Point=new Point
		
		
		public function BitmapMaterial( $bitmapData:BitmapData , $width:Number=128, $height:Number=128, $format:String = Context3DTextureFormat.BGRA, $optimizeRenderToTexture:Boolean=false)
		{
			_width = $width
			_height = $height
			_rect =new Rectangle(0,0,_width,_height)
				
			_context3d = Red2D.targetContext3d
				
			_bitmapData = new BitmapData( _width , _height , true , 0x00ffffff)		

			//_bitmapData.fillRect(_rect,0x00ffffff)
			//_bitmapData.copyPixels($bitmapData,_rect,_point,null,null,true)
			_bitmapData.draw($bitmapData,null,null,null,null,true)
				
			_texture= _context3d.createTexture( _width , _height , $format , $optimizeRenderToTexture );
			_texture.uploadFromBitmapData( _bitmapData);
			
		}	
	
	}
}