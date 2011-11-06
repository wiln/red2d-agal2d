package 
{
	import ex.*;
	
	import filter_ex.*;
	
	import game_ex.*;
	
	import particle_ex.*;
	
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
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test01_HelloRed2D);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test02_BitmapMaterial);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test03_MovieClipMaterial);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test04_Red_TextField);
			
			// fix 2011.11.04 by redcamel
			//red2d.setScene(new Test04_2_InputTextField);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test05_hierarchyTest);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test06_Red_Sprite_Property);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test07_Red_TextField_Property);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test08_Red_SequenceSprite);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test09_Red_ImageScroller);
			
			// fix 2011.10.31 by redcamel
			//red2d.setScene(new Test09_2_Red_ImageScroller);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test10_Multi_ImageScroller);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test11_MouseEvent);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test12_StressTest);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test13_Demo);
			
			// fix 2011.10.22 by redcamel
			//red2d.setScene(new Test14_DisplayContainer_Mathod);
			
			// fix 2011.10.22 by redcamel 
			//red2d.setScene(new Test15_FreeBitmapSize());
			
			// fix 2011.10.22 by redcamel 
			//red2d.setScene(new Test16_BitmapFileMaterial());
			
			//////////////// 필터예제입니다. //////////////////////
			
			// fix 2011.10.23 by redcamel 
			// red2d.setScene(new Test01_UseFilters);
			
			// fix 2011.11.04 by redcamel 
			//red2d.setScene(new Test02_MultiFilter);

			// fix 2011.10.23 by redcamel 
			//red2d.setScene(new Test03_FilterAnimation);	
			
			// fix 2011.11.04 by redcamel 
			//red2d.setScene(new Test04_Filter_Hierarchy);
			
			// fix 2011.11.04 by redcamel 
			//red2d.setScene(new Test05_FilterStressTest);
			
			// particle ex!!
			// 현재 파티클은 연구단계수준입니다.
			
			//red2d.setScene(new Test02_Use_Controller);	
			//red2d.setScene(new Test03_DemoView);	
			//red2d.setScene(new Test04_DemoView2);	
			//red2d.setScene(new Test05_DemoView3);	
			//red2d.setScene(new Test06_DemoView4);	
			//red2d.setScene(new Test07_DemoView5);
			//red2d.setScene(new Test08_DemoView6);	
			
			 // Game Test ex!!
			 // 간단한수준의 게임데모입니다.
			red2d.setScene(new Test_Game);	
		}
	}
}

