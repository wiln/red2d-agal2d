package ex
{
	/** 
	 * by Paik seonki / redcamel
	 * webseon@hanmail.net	 
	 */
	import flash.events.Event;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.material.MovieClipMaterial;
	import red2D.system.Red_Scene;
	

	/**
	 * 03 red2D 예제3 - MovieClipMaterial 사용하기 Oct 3, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */	
	public class Test03_MovieClipMaterial extends Red_Scene
	{

		private var testBox:Red_Sprite;

		private var movieClipMaterial:MovieClipMaterial;
		private var test:Red_Sprite;
		private var testMaterial:MovieClipMaterial;
		
		public function Test03_MovieClipMaterial()
		{
			
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	
			// 정보텍스트
			setInfo()
			
			// 크기를 0,0으로 설정할경우 컨테이너로 사용)
			test = new Red_Sprite(128,128,stage.stageWidth/2,stage.stageHeight/2)
			addChild(test)
			
			testMaterial = new MovieClipMaterial(new SWC_TestAir,128,128)
			test.material = testMaterial
				
			// 무비클립 애니메이션을 사용할경우 설정(꺼두는것이 리소스상 좋습니다)
			testMaterial.useAnimation = true
		
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
			infoTitle.appendText("Test03_MovieClipMaterial")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
		
	}
}

