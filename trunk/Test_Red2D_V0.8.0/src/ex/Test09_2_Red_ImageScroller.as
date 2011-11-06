package ex
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import red2D.display.Red_ImageScroller;
	import red2D.display.Red_ImageScroller_Direction;
	import red2D.filter.fragmentBasic.InvertFilter;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test09_Red_ImageScroller
	 * <p>Last update - Oct 22, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test09_2_Red_ImageScroller extends Red_Scene
	{
		[Embed( source = "./resource/scrollImg/testImg1.jpg" )]
		private  var Bg:Class;
		
		private var _scrollBg:Red_ImageScroller;
		
		public function Test09_2_Red_ImageScroller()
		{
		}
		
		public override function setDesign():void{
			setInfo();
			// 비트맵데이터를 소스로 받으며, 이동 속도를 픽셀단뒤오 입력가능하며
			// 3번째 파라미터 입력의 의미는 전체 화면에 맞추어 스크롤이미지를 변경할것인가..여부를 결정
			_scrollBg = new Red_ImageScroller(new Bg().bitmapData,3,true,Red_ImageScroller_Direction.LEFT_TO_RIGHT)

			addChild(_scrollBg)

		}
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{			
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

