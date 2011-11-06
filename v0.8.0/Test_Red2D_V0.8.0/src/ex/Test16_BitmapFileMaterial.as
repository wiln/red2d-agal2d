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
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{			
		}
	}
}