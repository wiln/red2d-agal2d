package Red2D.Material
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**  
	 * MovieClipMaterial	
	 * TODO:마우스인터렉션은 아직안됨...
	 * TODO:렌더개선방법을 찾아야함(이자식도....AGAL이나 벤더로 돌려야하는것인가 -_-)
	 * 다량의 무비클립을 한꺼번에 움직일경우 프레임이 급격히 떨어짐..
	 * / Last update - May 31, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 * 
	 */  
	
	public class MovieClipMaterial implements IMaterial
	{
		/**
		 * 텍스쳐 
		 */		
		private var _texture:Texture
		
		/**
		 * movieClip을  bitmapData에 카피하여 bitmap에 지속적으로 입힌다. 
		 */		
		private var _bitmapData:BitmapData

		/**
		 * 재질로 사용할 무비클립 
		 */		
		private var _movieClip:MovieClip;

		private var _rect:Rectangle;

		private var _point:Point;

		private var _matrixScaleX:Number;

		private var _matrixScaleY:Number;
		
		/**
		 * MovieClipMaterial 
		 * @param $context3d
		 * @param $bitmapData
		 * @param $width
		 * @param $height
		 * @param $format
		 * @param $optimizeRenderToTexture
		 * 
		 */		
		public function MovieClipMaterial( $context3d:Context3D , $movieClip:MovieClip , $width:Number=128, $height:Number=128, $format:String = Context3DTextureFormat.BGRA, $optimizeRenderToTexture:Boolean=false)
		{
			_bitmapData = new BitmapData( $width , $height , false , 0xffffff)
			_movieClip = $movieClip
			_rect = new Rectangle(0,0,$width , $height)
			_point = new Point()
			_texture= $context3d.createTexture( $width , $height , $format , $optimizeRenderToTexture );
			
			_matrixScaleX = $width/_movieClip.width
			_matrixScaleY = $height/_movieClip.height
		}
		
		/**
		 * 텍스쳐반환 
		 * @return 
		 * 
		 */		
		public function getTexture():*{
			_bitmapData.draw(_movieClip,new Matrix(Math.ceil(1*_matrixScaleX),0,0,Math.ceil(1*_matrixScaleY)),null,null,null,true)
			_texture.uploadFromBitmapData(_bitmapData);
			return _texture
		}
		
	}
}