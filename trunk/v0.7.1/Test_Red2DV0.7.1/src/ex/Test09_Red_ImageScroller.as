package ex
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import red2D.display.Red_ImageScroller;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test09_Red_ImageScroller
	 * <p>Last update - Oct 3, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test09_Red_ImageScroller extends Red_Scene
	{
		[Embed( source = "./resource/testImg1.jpg" )]
		private  var Bg:Class;
		private var _scrollBg:Red_ImageScroller;
		
		public function Test09_Red_ImageScroller()
		{
			super();
		}
		
		public override function setDesign():void{
			setInfo();
			// 비트맵데이터를 소스로 받으며, 이동 속도를 픽셀단뒤오 입력가능하며
			// 3번째 파라미터 입력의 의미는 전체 화면에 맞추어 스크롤이미지를 변경할것인가..여부를 결정
			_scrollBg = new Red_ImageScroller(new Bg().bitmapData,3,true)
			addChild(_scrollBg)
			
			stage.addEventListener(Event.ENTER_FRAME, HD_update)
		}
		
		protected function HD_update(event:Event):void
		{
			// 원하는 호출간격마다업데이트를 호출하면 스크롤링이 진행됩니다
			_scrollBg.update()
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
			infoTitle.appendText("Test09_Red_ImageScroller")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
	}
}

