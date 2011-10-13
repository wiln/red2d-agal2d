package game
{
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	
	/** 
	 * Pointer/ Last update - Oct 6, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Pointer extends Red_Sprite
	{
		[Embed( source = "./resource/game/circle1.png" )]
		private var Circle1:Class;
		[Embed( source = "./resource/game/circle2.png" )]
		private var Circle2:Class;
		private var _circleMaterial1:BitmapMaterial;
		private var _circleMaterial2:BitmapMaterial;
		private var _circle1:Red_Sprite;
		private var _circle2:Red_Sprite;
		private var _circle3:Red_Sprite;
		
		public function Pointer()
		{

			_circleMaterial1 = new BitmapMaterial(new Circle1().bitmapData)
			_circleMaterial2 = new BitmapMaterial(new Circle2().bitmapData)
			
			_circle1 = new Red_Sprite(128,128)
			_circle2 = new Red_Sprite(45,45)
			_circle2.alpha=0.8
				
			_circle3 = new Red_Sprite(100,100)
			_circle3.alpha=0.7
				
			_circle1.material = _circleMaterial1
			_circle2.material = _circleMaterial2
			_circle3.material = _circleMaterial2
				
			addChild(_circle1)
			addChild(_circle2)
			addChild(_circle3)
		}
	}
}

