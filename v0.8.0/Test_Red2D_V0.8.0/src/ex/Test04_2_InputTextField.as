package ex
{
	import flash.text.TextField;
	
	import red2D.system.Red_Scene;
	import red2D.text.Red_InputTextField;
	import red2D.text.Red_TextField;
	
	/** 
	 * Test04_2_InputTextField/ Last update - Oct 22, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test04_2_InputTextField extends Red_Scene
	{
		private var _test:Red_InputTextField
		public function Test04_2_InputTextField()
		{
		}
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	
			// 정보텍스트출력
			setInfo()
			
			_test = new Red_InputTextField()
			
			_test.text="클릭 후 키보드 입력이 가능합니다.\nTest_Red_InputTextField"
			_test.x=stage.stageWidth/2
			_test.y=stage.stageHeight/2
				
			_test.size = 30

			addChild(_test)						
		}
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{			
			//_test.rotation++
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
			infoTitle.appendText("Test Red_InputTextField")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/\n")			
			infoTitle.appendText("\nRed_InputTextField를 사용하는 예제입니다.")
			infoTitle.appendText("\nV0.8부터는 Red_TextFieldRotationCenterPoint를 제공합니다.")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
		
	}
}

