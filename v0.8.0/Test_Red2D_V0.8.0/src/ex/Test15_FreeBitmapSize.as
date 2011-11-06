package ex
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	import red2D.material.MovieClipMaterial;
	import red2D.system.Red_Scene;
	import red2D.util.CheckPower;
	
	/**
	 * Test15_FreeBitmapSize
	 * 2의 거듭제곱형태가아닌 프리사이즈 이미지를 재질로 사용가능하십니다.
	 * <p>Last update - Oct 13, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */	
	public class Test15_FreeBitmapSize extends Red_Scene
	{
		[Embed( source = "./resource/freeSizeMap/test1.jpg" )]
		private var MapTest1:Class;
		
		[Embed( source = "./resource/freeSizeMap/test2.jpg" )]
		private var MapTest2:Class;

		[Embed( source = "./resource/freeSizeMap/test3.jpg" )]
		private var MapTest3:Class;
		
		[Embed( source = "./resource/freeSizeMap/test4.jpg" )]
		private var MapTest4:Class;
		
		private var test1:Red_Sprite;
		private var test2:Red_Sprite;
		private var test3:Red_Sprite;
		private var test4:Red_Sprite;
		
		private var testMaterial:BitmapMaterial;
		private var testMaterial1:BitmapMaterial;
		private var testMaterial2:BitmapMaterial;
		private var testMaterial3:BitmapMaterial;
		private var testMaterial4:MovieClipMaterial;
		
		
		public function Test15_FreeBitmapSize()
		{
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	

			// 설명텍스트 출력
			setInfo()
			
			// 크기를 0,0으로 설정할경우 컨테이너로 사용)
			test1 = new Red_Sprite(100,100,100,stage.stageHeight/2)
			test2 = new Red_Sprite(100,150,250,stage.stageHeight/2)
			test3 = new Red_Sprite(150,100,400,stage.stageHeight/2)
			test4 = new Red_Sprite(130,130,500,stage.stageHeight/2)
			addChild(test1)
			addChild(test2)
			addChild(test3)
			addChild(test4)
			
			
			// 재질설정
			testMaterial1 = new BitmapMaterial(new MapTest1().bitmapData)
			testMaterial2 = new BitmapMaterial(new MapTest2().bitmapData)
			testMaterial3 = new BitmapMaterial(new MapTest3().bitmapData)
			testMaterial4 = new MovieClipMaterial(new SWC_TestAir)
			testMaterial4.useAnimation=true
			
			test1.material = testMaterial1
			test2.material = testMaterial2
			test3.material = testMaterial3
			test4.material = testMaterial4
			
		}
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{			
			test1.rotation++
			test2.rotation++
			test3.rotation++
			test4.rotation++
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
			infoTitle.appendText("Test15_FreeBitmapSize")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/\n")			
			infoTitle.appendText("\nV0.8버전부터는 맵소스입력시 2의 거듭제곱이 아닌형태도 입력가능합니다. ")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
		
	}
}

