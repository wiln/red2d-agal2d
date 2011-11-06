package ex
{
	import flash.text.TextField;
	
	import red2D.display.Red_SequenceSprite;
	import red2D.display.SequenceManager;
	import red2D.material.SequenceMaterial;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test08_SequenceMaterial
	 * <p>Last update - Oct 22, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test08_Red_SequenceSprite extends Red_Scene
	{
		private var test:Red_SequenceSprite;
		private var testMaterial:SequenceMaterial;
		private var testSequenceManager:SequenceManager;
		
		public function Test08_Red_SequenceSprite()
		{
			
		}
		
		public override function setDesign():void{
			setInfo()
			
			// 시퀀스를 사용하기위해서는 시퀀스스프라이트를 사용합니다.
			test = new Red_SequenceSprite(128,128,stage.stageWidth/2,stage.stageHeight/2)
			addChild(test)
			
			// 시퀀스 스프라이트에 재질을 설정할떄는 반드시 시퀀스 매니저를 통하여 지정합니
			testSequenceManager = new SequenceManager()
				
			// 시퀀스재질을 생성합니다.
			// 다른 재질과는 달리 이미지크기는 입력을 해주어야합니다
			// 경로, 파일기본이름(파일이름을 지정하면  파일이름0001.png 과 같이 1000단위 넘버링이 생성됩니다.), 총파일갯수, 총파일이 플레이되는 시간(주기), 크기
			testMaterial = new SequenceMaterial("../resource/sequence/비행/","비행","png",15,1000,128,128)
	
			// 시퀀스 매니저에 시퀀스 재질을 추가합니다.
			testSequenceManager.addSequenceMaterial("비행아이디",testMaterial)
				
			test.setSequence("비행아이디",testSequenceManager)
		}
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{			
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
			infoTitle.appendText("Test08_Red_SequenceSprite")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/\n")			
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000			
		}		
	}
}

