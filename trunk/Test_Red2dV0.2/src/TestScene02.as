package 
{

	import Red2D.Material.BitmapMaterial;
	import Red2D.container.Red_Scene;
	import Red2D.display.Red_DisplayObject;
	
	import flash.events.Event;
	
	/**  
	 * TestScene
	 * 다중 객체 드로잉 테스트 및 BitmapMaterial 테스트	
	 * / Last update - May 24, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 128~ 
	 * 
	 * 
	 */  
	public class TestScene02 extends Red_Scene
	{
		[Embed( source = "./res/test1.jpg" )]
		private static var MapTest1:Class;
		
		[Embed( source = "./res/test2.jpg" )]
		private static var MapTest2:Class;
		
		private var testBox:Red_DisplayObject;
		private var testBox2:Red_DisplayObject;
		
		/**
		 * 사각형생성하고 회전하는 예제 
		 * 
		 */
		public override function setDesign():void
		{		
			var _material:BitmapMaterial = new BitmapMaterial(targetContext3D, new MapTest1().bitmapData)
			var _material2:BitmapMaterial = new BitmapMaterial(targetContext3D ,new MapTest2().bitmapData)
				
			// * 2D생성
			testBox = new Red_DisplayObject(
				targetStage, targetContext3D ,100 , 100 ,_material,
				targetStage.stageWidth/2, targetStage.stageHeight/2
			)				
			testBox2 = new Red_DisplayObject(
				targetStage, targetContext3D ,100 , 100 ,_material2,
				targetStage.stageWidth/2+150, targetStage.stageHeight/2+150
			)				
				
			addChild(testBox)
			addChild(testBox2)		
			targetStage.addEventListener(Event.ENTER_FRAME , HD_enterTest)
		}
	
		/**
		 * 엔터프레임 이벤트 
		 * @param e
		 * 
		 */		
		private function HD_enterTest(e:Event):void{
			testBox.rotation++
			testBox2.rotation++
		}
	}
}