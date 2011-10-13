package ex
{
	import red2D.display.Red_SequenceSprite;
	import red2D.display.SequenceManager;
	import red2D.material.SequenceMaterial;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test08_SequenceMaterial
	 * <p>Last update - Oct 3, 2011</p>
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
		// codeonwort님께 테스트 오류신고를 해주셨습니다. 적극적인 테스트를 해주신 codeonwort님께 다시한번 감사드립니다. 2011.10.13
		// 시퀀스 경로가 잘못 지정될시 아무 오류메시지도 뜨지않으면서도 테스트 진행이 안되는 상황이 발생하여 경로지정이 잘못되었을겨웅 iOErrow메시지를 Trace하게 하였습니다.
		
		public override function setDesign():void{
			// 시퀀스를 사용하기위해서는 시퀀스스프라이트를 사용합니다.
			test = new Red_SequenceSprite(128,128,stage.stageWidth/2,stage.stageHeight/2)
			addChild(test)
			
			// 시퀀스 스프라이트에 재질을 설정할떄는 반드시 시퀀스 매니저를 통하여 지정합니
			testSequenceManager = new SequenceManager()
				
			// 시퀀스재질을 생성합니다.
			// 경로, 파일기본이름(파일이름을 지정하면  파일이름0001.png 과 같이 1000단위 넘버링이 생성됩니다.), 총파일갯수, 총파일이 플레이되는 시간(주기), 크기
			testMaterial = new SequenceMaterial("../resource/sequence/비행/","비행","png",15,1000,128,128)
	
			// 시퀀스 매니저에 시퀀스 재질을 추가합니다.
			testSequenceManager.addSequenceMaterial("비행아이디",testMaterial)
				
			test.setSequence("비행아이디",testSequenceManager)
			
		}
	}
}

