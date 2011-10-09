package 
{
	import ex.*;
	
	import game.Test_Game;
	
	import red2D.system.Red2D;
	
	/** 
	 * 테스트 예제 런처
	 * example/ Last update - Oct 3, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	[SWF (frameRate="60")]
	public class exampleLauncher extends LauncherBase
	{
		public function exampleLauncher()
		{
		
			var red2d:Red2D = new Red2D()
			addChild(red2d)
			
			//red2d.setScene(new Test01_HelloRed2D);
			
			red2d.setScene(new Test02_BitmapMaterial);
			
			//red2d.setScene(new Test03_MovieClipMaterial);
			
			//red2d.setScene(new Test04_Red_TextField);
			
			//red2d.setScene(new Test05_hierarchyTest);
			
			//red2d.setScene(new Test06_Red_Sprite_Property);
			
			//red2d.setScene(new Test07_Red_TextField_Property);
			
			//red2d.setScene(new Test08_Red_SequenceSprite);
			
			//red2d.setScene(new Test09_Red_ImageScroller);
			
			//red2d.setScene(new Test10_Multi_ImageScroller);
			
			//red2d.setScene(new Test11_MouseEvent);
			
			//red2d.setScene(new Test12_StressTest);
			
			//red2d.setScene(new Test13_Demo);
			
			//red2d.setScene(new Test_Game);
			
			//red2d.setScene(new Test14_DisplayContainer_Mathod);
		}
	}
}

