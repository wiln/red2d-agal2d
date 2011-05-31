package 
{

	import Red2D.Material.ColorMaterial;
	import Red2D.container.Red_Scene;
	import Red2D.display.Red_DisplayObject;
	
	import flash.events.Event;
	
	/**  
	 * TestScene	
	 * / Last update - May 24, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 128~ 
	 * 
	 * 
	 */  
	public class TestScene01 extends Red_Scene
	{
		private var testBox:Red_DisplayObject;
		
		/**
		 * 사각형생성하고 회전하는 예제 
		 * 
		 */
		public override function setDesign():void
		{		
			var _material:ColorMaterial = new ColorMaterial(targetContext3D)
				
			// * 2D생성
			testBox = new Red_DisplayObject(
				targetStage, targetContext3D ,100 , 100 ,_material,
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