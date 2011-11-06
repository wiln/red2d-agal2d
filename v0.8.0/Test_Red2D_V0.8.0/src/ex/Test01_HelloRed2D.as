package ex
{
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.system.Red_Scene;
	
	/** 
	 * Red2D를 이용한 HelloWorld
	 * Test_Scene/ Last update - oct 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test01_HelloRed2D extends Red_Scene
	{

		private var _testSprite:Red_Sprite;
		
		public function Test01_HelloRed2D()
		{			
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	
			// 정보텍스트 출력
			setInfo();
			
			// Red_Sprite 생성
			_testSprite = new Red_Sprite(100,100,stage.stageWidth/2,stage.stageHeight/2)
			addChild(_testSprite)
			
			// 피봇설정 V0.8에서부터 피봇을 지원합니다.
			// test.pivotX=50
			// test.pivotY=50
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
			infoTitle.appendText("Test01_HelloRed2D")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/")			
			infoTitle.appendText("\nRed2D의 기초 디스플레이 오브젝트인 Red_Sprite를 사용하는 예제입니다.")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000			
		}
	}
}

