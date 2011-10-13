package ex
{
	import flash.text.TextField;
	
	import red2D.text.Red_TextField;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test04_Red_TextField/ Last update - Oct 3, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test04_Red_TextField extends Red_Scene
	{
		private var test:Red_TextField
		public function Test04_Red_TextField()
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
			
			test = new Red_TextField()
			
			test.text="가나다라마바사"
			test.x=500
			test.y=300
				
			test.background=true
			test.backgroundColor=0x335566
			
			addChild(test)						
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
			infoTitle.appendText("Test04_Red_TextField")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
		
	}
}

