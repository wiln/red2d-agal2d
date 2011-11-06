package red2D.material
{
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;

	/** 
	 * <p>기본 컬러재질</p> 
	 * Last update - Sep 13, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class ColorMaterial extends MaterialBase
	{

		public function ColorMaterial( $color:int=0xffffff )
		{			
			_bitmapData = new BitmapData( 1 , 1 , false , $color)		
			
			_texture= _context3d.createTexture( 1 , 1 ,  Context3DTextureFormat.BGRA , false );
			_texture.uploadFromBitmapData( _bitmapData);
		}
	}
}

