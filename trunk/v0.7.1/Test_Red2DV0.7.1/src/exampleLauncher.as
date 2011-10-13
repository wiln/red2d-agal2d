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
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test01_HelloRed2D);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test02_BitmapMaterial);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test03_MovieClipMaterial);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test04_Red_TextField);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test05_hierarchyTest);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test06_Red_Sprite_Property);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test07_Red_TextField_Property);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test08_Red_SequenceSprite);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test09_Red_ImageScroller);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test10_Multi_ImageScroller);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test11_MouseEvent);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test12_StressTest);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test13_Demo);
			
			// fix 2011.10.13 by redcamel
			 red2d.setScene(new Test_Game);
			
			// fix 2011.10.13 by redcamel
			//red2d.setScene(new Test14_DisplayContainer_Mathod);
			
			// fix 2011.10.13 by redcamel new update v0.7.1
			//red2d.setScene(new Test15_FreeBitmapSize());
			
			// fix 2011.10.13 by redcamel new update v0.7.1
			//red2d.setScene(new Test16_BitmapFileMaterial());
		}
	}
}

