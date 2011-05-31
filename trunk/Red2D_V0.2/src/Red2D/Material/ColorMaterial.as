package Red2D.Material
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;

	/**  
	 * ColorMaterial	
	 * / Last update - May 25, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 */  
	
	public class ColorMaterial implements IMaterial
	{
		/**
		 * 텍스쳐 
		 */		
		private var _texture:Texture
		/**
		 * 텍스쳐에 입힐 bitmapdate bitmap을 입혀 마치 ColorMaterial과 같은 효과를 낸다. 
		 */		
		private var _bitmapData:BitmapData;
		
		/**
		 * ColorMaterial 
		 * @param $context3d
		 * @param $color
		 * 
		 */		
		public function ColorMaterial( $context3d:Context3D , $color:int=0xffffff )
		{
			_bitmapData = new BitmapData( 1 , 1 , false , $color)
			_texture= $context3d.createTexture( 1 , 1 , Context3DTextureFormat.BGRA , false );
			_texture.uploadFromBitmapData( _bitmapData );
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