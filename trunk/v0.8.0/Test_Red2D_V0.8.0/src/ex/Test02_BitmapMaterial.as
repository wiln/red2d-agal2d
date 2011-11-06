package ex
{
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	import red2D.system.Red_Scene;
	
	/** 
	 * BitmapMaterial 적용
	 * Test02_BitmapMaterial/ Last update - Oct 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test02_BitmapMaterial extends Red_Scene
	{
		[Embed( source = "./resource/testImg3.jpg" )]
		private var MapTest:Class;
		private var _testSprite:Red_Sprite;
		private var testMaterial:BitmapMaterial;
				
		public function Test02_BitmapMaterial()
		{
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	
			// 설명텍스트 출력(Stage3D API를 쓴다고해서 기존의 API들을 사용못하는것은 아닙니다^^)
			setInfo()
			
			// 크기를 0,0으로 설정할경우 컨테이너로 사용)
			_testSprite = new Red_Sprite(100,100,stage.stageWidth/2,stage.stageHeight/2)
			addChild(_testSprite)
			
			// 재질설정 (V0.8버전부터는 맵소스 크기제한이 없어졌습니다. 어떠한 이미지라도 프리사이즈로 입력가능합니다.)
			testMaterial = new BitmapMaterial(new MapTest().bitmapData)
			_testSprite.material = testMaterial
			
				
		}
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{			
			_testSprite.rotation++
		}
		
		/**
		 * 정보타이틀 출력 
		 * 
		 */		
		protected function setInfo():void{
			
			var infoTitle:TextField = new TextField
			stage.addChild(infoTitle)
			
			infoTitle.x=infoTitle.y=10
			
			infoTitle.text = "Red2D "
			infoTitle.textColor=0x777777
			infoTitle.appendText("Test02_BitmapMaterial")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/\n")			
			infoTitle.appendText("\nBitmapMaterial를 사용하는 예제입니다.")
			infoTitle.appendText("\nV0.8버전부터는 맵소스입력시 2의 거듭제곱이 아닌형태도 입력가능합니다. ")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000			
		}		
	}
}