package ex
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	import red2D.system.Red_Scene;
	
	/** 
	 * BitmapMaterial 적용
	 * Test02_BitmapMaterial/ Last update - Oct 3, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test02_BitmapMaterial extends Red_Scene
	{
		[Embed( source = "./resource/testImg3.jpg" )]
		private var MapTest:Class;
		private var test:Red_Sprite;
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
			// 설명텍스트 출력
			setInfo()
			
			// 크기를 0,0으로 설정할경우 컨테이너로 사용)
			test = new Red_Sprite(100,100,stage.stageWidth/2,stage.stageHeight/2)
			addChild(test)
			
			// 재질설정
			testMaterial = new BitmapMaterial(new MapTest().bitmapData)
			test.material = testMaterial
			
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
			infoTitle.appendText("Test02_BitmapMaterial")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
		
	}
}

