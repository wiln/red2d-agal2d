package ex
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.system.Red_Scene;
	
	/** 
	 * Red2D를 이용한 HelloWorld
	 * Test_Scene/ Last update - Sep 11, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test01_HelloRed2D extends Red_Scene
	{

		private var test:Red_Sprite;
		
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
			test = new Red_Sprite(100,100,stage.stageWidth/2,stage.stageHeight/2)
			addChild(test)
			
			// 피봇설정
			//test.pivotX=50
			//test.pivotY=50
			// stage이벤트 등록
			stage.addEventListener(Event.ENTER_FRAME, HD_Enterframe)
		}
		
		protected function HD_Enterframe(event:Event):void
		{
			test.rotation++
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
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
	}
}

