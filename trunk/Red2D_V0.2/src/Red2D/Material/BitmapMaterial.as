package Red2D.Material
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;

	/**  
	 * BitmapMaterial	
	 * / Last update - May 25, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 * 
	 */  
	
	public class BitmapMaterial implements IMaterial
	{
		/**
		 * 텍스쳐 
		 */		
		private var _texture:Texture
		/**
		 * 텍스쳐에 입힐  Bitmap 
		 */		
		private var _bitmap:Bitmap
		
		/**
		 * BitmapMaterial 
		 * @param $context3d
		 * @param $bitmapData
		 * @param $width
		 * @param $height
		 * @param $format
		 * @param $optimizeRenderToTexture
		 * 
		 */		
		public function BitmapMaterial( $context3d:Context3D , $bitmapData:BitmapData , $width:Number=128, $height:Number=128, $format:String = Context3DTextureFormat.BGRA, $optimizeRenderToTexture:Boolean=false)
		{
			_bitmap = new Bitmap($bitmapData)
			_texture= $context3d.createTexture( $width , $height , $format , $optimizeRenderToTexture );
			_texture.uploadFromBitmapData( _bitmap.bitmapData );
		}
		
		/**
		 * 텍스쳐반환 
		 * @return 
		 * 
		 */		
		public function getTexture():*{
			return _texture
		}
	}
}