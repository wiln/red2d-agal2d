package 
{
	
	import Red2D.Material.BitmapMaterial;
	import Red2D.Material.MovieClipMaterial;
	import Red2D.container.Red_Scene;
	import Red2D.display.Red_DisplayObject;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**  
	 * TestScene
	 * MovieMaterial을 테스트
	 * / Last update - May 24, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 128~ 
	 * 
	 * 
	 */  
	public class TestScene04 extends Red_Scene
	{

		private var testBox:Red_DisplayObject;
		
		/**
		 * 사각형생성하고 회전하는 예제 
		 * 
		 */
		public override function setDesign():void
		{		
			
			// * new SWC_TestMaterial() <<- 이놈은 뭐냐..하면..
			// * 개인적으로 스킨을 생성할때 플래시에서 작업해서 SWC형태로 들고와서 사용하는 방식을 선호합니다.
			// * 
			var _material:MovieClipMaterial = new MovieClipMaterial(targetContext3D,  new SWC_TestMaterial() , 256 , 256)

			// * 2D생성
			testBox = new Red_DisplayObject(
				targetStage, targetContext3D ,300 , 300 ,_material,
				targetStage.stageWidth/2, targetStage.stageHeight/2
			)	
			
			addChild(testBox)
			targetStage.addEventListener(Event.ENTER_FRAME , HD_enterTest)
		}
		
		/**
		 * 엔터프레임 이벤트 
		 * @param e
		 * 
		 */		
		private function HD_enterTest(e:Event):void{
			testBox.rotation++
		}
	}
}