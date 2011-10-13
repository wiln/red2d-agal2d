package ex
{
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapFileMaterial;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test16_BitmapFileMaterial
	 * <p>Last update - Oct 13, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test16_BitmapFileMaterial extends Red_Scene
	{
		private var _test:Red_Sprite;
		private var _testMaterial:BitmapFileMaterial;
		public function Test16_BitmapFileMaterial()
		{			
		}
		
		/**
		 * 기본 오버라이드 
		 * 
		 */		
		public override function setDesign():void{
			_test = new Red_Sprite(100,100,stage.stageWidth/2, stage.stageHeight/2)
			addChild(_test)
			
			_testMaterial = new BitmapFileMaterial("../resource/flower.png")
			_test.material = _testMaterial
		}
	}
}