package
{
	
	import Red2D.container.Red2D;
	import Red2D.container.Red_Scene;
	
	import com.lia.utils.SWFProfiler;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.events.KeyboardEvent;
	
	[SWF( frameRate="60", backgroundColor="#ffffff")]
	
	public class Test_Index extends Sprite
	{
		
		private var _Red2D:Red2D;
		private var _scene:Red_Scene
		
		/**
		 * 생성자 
		 * 
		 */		 
		public function Test_Index()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align=StageAlign.TOP_LEFT		

			SWFProfiler.init(stage,this)
			SWFProfiler.show()
			init()		
		}
		
		
		/*********************************************************************/		 
		/** 초기화 */
		/** Red2D와 관련해서 입력해야할 코드 **/
		/** 실제 디스플레이구성은 Red_Scene을 확장한 TestScene클래스에서 이루어집니다.**/
		/*********************************************************************/
		
		private function init():void{
			// * Scene을 생성하고(실제 디자인부분) 
			
			// * TestScene01 사각형그리기 ColorMaterial
			// * TestScene02 사각형그리기 BitmapMaterial
			// * TestScene03 대량의 사각형 그리기 BitmapMaterial & ColorMaterial
			// * TestScene04 사각형하나그리기 MovieClipMaterial
			
			
			// _scene = new TestScene01()
			// _scene = new TestScene02()
			 _scene = new TestScene03()
			// _scene = new TestScene04()
			
			// *  Red2D를 생성하고 초기화합니다. 반드시 stqage를 넣어야합니다.
			_Red2D = new Red2D()
			_Red2D.init(stage)
			
			// * Red2D의 Scene에 추가합니다.
			_Red2D.setScene(_scene)
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,HD_keyDown)
		}
			
		
		/*********************************************************************/		 
		/** 이벤트핸들러 */
		/*********************************************************************/
		/**
		 * 키다운이벤트 
		 * @param e
		 * 
		 */		
		private function HD_keyDown(e:KeyboardEvent):void{
			if(e.keyCode ==70){
				stage.displayState = StageDisplayState.FULL_SCREEN
			}
		}		
	}
}