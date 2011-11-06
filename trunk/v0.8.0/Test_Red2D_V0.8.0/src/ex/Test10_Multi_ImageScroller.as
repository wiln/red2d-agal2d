package ex
{
	import flash.text.TextField;
	
	import red2D.display.Red_ImageScroller;
	import red2D.filter.fragmentUV.UV_ZoomFilter;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test11_Multi_ImageScroller/ Last update - Oct 3, 2011
	 * <p>Last update - Oct 22, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test10_Multi_ImageScroller extends Red_Scene
	{
		[Embed( source = "./resource/scrollImg/testImg1.jpg" )]
		private  var Bg:Class;
		
		[Embed( source = "./resource/scrollImg/cloud.png" )]
		private  var Bg2:Class;
		
		private var _scrollBg:Red_ImageScroller;
		private var _scrollBg2:Red_ImageScroller;
				
		public function Test10_Multi_ImageScroller()
		{		
		}
		
		public override function setDesign():void{
			setInfo();
			// 비트맵데이터를 소스로 받으며, 이동 속도를 픽셀단뒤오 입력가능하며
			// 3번째 파라미터 입력의 의미는 전체 화면에 맞추어 스크롤이미지를 변경할것인가..여부를 결정
			_scrollBg = new Red_ImageScroller(new Bg().bitmapData,1,true)
			_scrollBg2 = new Red_ImageScroller(new Bg2().bitmapData,3,true)

			addChild(_scrollBg)
			addChild(_scrollBg2)

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
			_scrollBg2.update()
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
			infoTitle.appendText("Test10_Multi_ImageScroller")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
	}
}

