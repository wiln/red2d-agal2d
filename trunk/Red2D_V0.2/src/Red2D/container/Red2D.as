package Red2D.container
{
	
	import Red2D.projectInfomation.InfoLogger;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	
	/**  
	 * Red2D molehill을 사용하기위한 기본 렌더링 환경을 실행하는 Class 
	 * / Last update - May 31, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 * 
	 */ 
	
	public class Red2D extends Sprite
	{
		/*********************************************************************************/
		/** 변수선언 **/
		/*********************************************************************************/	
		private var _context3d:Context3D
		private var _program3d:Program3D
		private var _vertexBuffer3D:VertexBuffer3D
		private var _indexBuffer3D:IndexBuffer3D
		private var _texture:Texture
		private var _matrix:Matrix3D = new Matrix3D		
		private var _scene:Red_Scene;
		private var _stage:Stage;		
		private var _checkError:Boolean;
		private var settingWorld:Boolean=false;
		
		/********************************************************************************/
		/** 초기화  매서드 **/
		/********************************************************************************/
		/**
		 * 초기화준비 
		 * @param $stage stage 설정(익스에서 stage가 초기화 되지않을때 오는것을 막기위해 stage초기화 확인후 지정하기위함입니다)
		 * @param $renderType 렌더타입(AUTO로하면 GPU연산을 합니다. SOFTWARE로 렌더하실분은 없을듯)
		 * @param $checkError 에러 체킹 할꺼냐 말꺼냐!! 최종에선 하지맙시다. 폴리곤 갯수가 늘어날수록 퍼포먼스차이가 생각보다 많이 납니다.
		 */		
		
		public function init( $stage:Stage , $renderType:String=Context3DRenderMode.AUTO , $checkError:Boolean=false ):void{
			InfoLogger.traceLogger()
			_stage = $stage
				
			// *stage3Ds가 초기에 왜 4개나 있는지 이유를 모르겠다...				
			// * 뷰포트를 설정하고 Event.CONTEXT3D_CREATE를 등록 Event.ADDED_TO_STAGE와 비슷한개념입니다.
			_stage.stage3Ds[0].viewPort = new Rectangle(0,0,_stage.stageWidth, _stage.stageHeight)
			_stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, setupContext3D)
			_stage.stage3Ds[0].requestContext3D( $renderType )
				
			_checkError = $checkError
				
		}
		
		/**
		 * setupContext3D 구성 
		 * @param $event
		 * 
		 */		
		private function setupContext3D( $event:Event ):void
		{
			trace("Red2D를 시작합니다.")
			
			var target:Stage3D = _stage.stage3Ds[0]
			_context3d = target.context3D
			
			// 에러체크를 일단 하는데...최종에서는 뺴자...무겁다..
			_context3d.enableErrorChecking = _checkError
			
			_context3d.configureBackBuffer( _stage.stageWidth , _stage.stageHeight , 2 , false)
			_context3d.setCulling(Context3DTriangleFace.FRONT)
			
			settingWorld = true
		}
		
		/**
		 * _context3d 가 정상적으로 생성되었는지를 확인한다. 
		 * 
		 */		
		private function setCheckStage():void {
			_stage.addEventListener(Event.ENTER_FRAME, tempLoop );
		}
		
		/**
		 * _context3d 실행준비가 되었는지 확인한다. 
		 * @param event
		 * 
		 */		
		private function tempLoop( $event:Event ):void {
			if (settingWorld) {
				if ( _stage.stageWidth > 0 && _stage.stageHeight > 0 ) {
					_stage.removeEventListener( Event.ENTER_FRAME, tempLoop );
					// * F키를 통한 풀스크린과 스테이지 리사이즈를 자동으로 넣기위하여 랩핑한다.
					// * 원하는 클래스를 확장하여 사용하면 편리~					
					setSceneEnd(_scene)
				}
			}
			trace("리사이즈실행")
		}	
		
		/**
		 * Red_Scene 지정 
		 * @param $scene
		 * 
		 */		
		public function setScene( $scene:Red_Scene ):void{
			// * scene 등록
			_scene = $scene
			setCheckStage()	
		}
		
		/**
		 * Red_Scene 지정완료 
		 * 
		 */		
		private function setSceneEnd( $scene:Red_Scene ):void
		{
			_scene = $scene
			_scene.init(_stage , _context3d)
			_scene.setDesign()
				
			// * 렌더설정
			setRender()
		}
		
		
		/********************************************************************************/
		/** 렌더링 **/
		/********************************************************************************/
		/**
		 * 렌더링 설정 (랜더 핸들러와 리사이즈 핸들러설정)
		 * 
		 */		
		public function setRender():void
		{
			// * program3d 생성만 하고 하위에다가 연산은 넘긴다!!!!!
			_program3d = _context3d.createProgram()
			_context3d.setProgram( _program3d )			
			
			// * 확실한 stage와 _context3d설정을 위하여 resize를 한번더해줌
			HD_Resize() 
			
			// * 렌더링겁시다.
			_stage.addEventListener( Event.ENTER_FRAME, HD_render )			
			_stage.addEventListener(Event.RESIZE , HD_Resize)
		}
		
		/**
		 * 렌더 엔터프레임 핸들러
		 * @param event
		 * 
		 */		
		private function HD_render( $event:Event ):void
		{
			// * Context3d를 지움
			_context3d.clear()
				
				
			// * Context3D를 지우고 표시만하고 vertex관련 추가와 연산은 하위 개별 객체에게 맡긴다.
			// * 등록된 scene에  setRenderList명령을 실행함 - 연산끝나면 World에서는 present만 실행				
			_scene.setRenderList(_program3d)	
			
				
			// * context3d를 표시함
			_context3d.present()			
		}	
		
		/**
		 * 리사이즈 
		 * @param event
		 * 
		 */		
		protected function HD_Resize(event:Event=null):void
		{
			trace("Red2D Resize")
			var target:Stage3D = _stage.stage3Ds[0]
			target.viewPort = new Rectangle(0,0,_stage.stageWidth, _stage.stageHeight)
			_context3d.configureBackBuffer(target.viewPort.width, target.viewPort.height, 2, false);
		}
		
		
	}
}