package red2D.system
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DCompareMode;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	import red2D.projectInfomation.InfoLogger;
	import red2D.util.CheckEnableStage;
	import red2D.util.RGB_separator;
	
	/** 
	 * <p>Red2D를 사용하기위한 기본 렌더링 환경을 설정하는 Class</p> 
	 * Last update - Sep 10, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0  
	 */
	public class Red2D extends Sprite
	{
		/********************************************************************************/
		/** static 변수들 **/
		/********************************************************************************/	
		
		/**
		 * 실제로 사용 하는 context3D (유저사용빈도는 거의 없습니다)
		 */		
		public static var targetContext3d:Context3D;
		
		/**
		 * 실제로 사용 하는 Stage3D (유저사용빈도는 거의 없습니다)
		 */		
		public static var targetStage3d:Stage3D;
		
		/**
		 * 화면을 구성하는데 사용되는 Scene객체
		 */		
		public static var targetScene:Red_Scene;
		
		/**
		 * Red2d환경내에서 stage를 static으로 접근할때 사용 / Red_Scene내에서는 stage변수로 접근가능
		 */		
		public static var targetStage:Stage;
		
		/**
		 * shader 프로그램 전체 리스트 (유저사용빈도는 거의 없습니다)
		 */		
		public static var targetProgramData:Red_ProgramData;
		
		/**
		 * 사각형을 그릴 공용 버퍼데이터와 인덱스버퍼 (유저사용빈도는 거의 없습니다)
		 */		
		public static var targetBufferData:Red_BufferData;
		
		
		/********************************************************************************/
		/** 초기 활성화관련 변수들 **/
		/********************************************************************************/	
		
		/**
		 * 스테이지 활성화 체크 
		 */		
		private var _checkStage:CheckEnableStage; 
		
		/**
		 * context3D 활성화체크
		 */		
		private var _enableRed2D:Boolean=false;
		
		
		/********************************************************************************/
		/** 렌더링관련 변수들 
		 * Red2D는 엔터프레임을 이용한 렌더주기를 설정합니다. 
		 * 타이머를 이용한 렌더주기 설정은 퍼포먼스상의 이점은 있지만 애니메이션의 부드러움이 엔터프레임을 따라잡지못합니다.
		 * 향후 렌더링주기설정을 타이머로 할지, 엔터프레임으로 할지 선택할수 있는 기능을 추가할예정입니다.
		 **/		
		/********************************************************************************/	
		
		/**
		 * 렌더타이머 - 타이머를 이용하여 렌더링을 실행할때 사용 
		 */		
		private var _timer:Timer;
		
		/**
		 * 현재 스테이지의 마우스가 MouseDown상태인지를 판단하기위한 변수 (유저사용빈도는 거의 없습니다)
		 */		
		public static var currentMouseDown:Boolean;
		private var checkTime:int;
		private var _prevNum:int;
		
		/********************************************************************************/
		/** 배경색상 관련 변수들 **/
		/********************************************************************************/	
		
		/**
		 * 배경컬러지정 
		 */		
		private static var _backgroundColor:int;
		
		/**
		 * 배경컬러를 RGB로 나눈값을 저장 
		 */		
		private static var _backgroundColor_Data:Array;
		
		
		/********************************************************************************/
		/** 초기화 매서드 **/
		/********************************************************************************/	
		/**
		 * 생성자 
		 * 
		 */		
		public function Red2D()
		{
			InfoLogger.traceLogger()
			addEventListener(Event.ADDED_TO_STAGE, init)
			backgroundColor=0x000000
		}
		
		/**
		 * red2D를 초기화 1단계 - stage활성화 확인
		 * @param $event
		 * 
		 */		
		private function init( $event:Event ):void{			
			stage.doubleClickEnabled = false
			stage.stageFocusRect = false
			//stage.quality = StageQuality.LOW
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align = StageAlign.TOP_LEFT			
			
			// stage활성화확인
			_checkStage = new CheckEnableStage()
			addChild(_checkStage)				
			_checkStage.addEventListener(CheckEnableStage.ENABLE_STAGE, check_contex3D)			
		}				
		
		/**
		 * red2D를 초기화 2단계-1 - context3D 활성화 요청
		 * @param event
		 * 
		 */		
		private function check_contex3D( $event:Event ):void
		{
			// context3D 생성요청
			targetStage = stage				
			targetStage3d = targetStage.stage3Ds[0]
			targetStage3d.addEventListener(Event.CONTEXT3D_CREATE, setContext3D)
			targetStage3d.addEventListener(ErrorEvent.ERROR, HD_context3D_Error)
			targetStage3d.requestContext3D(Context3DRenderMode.AUTO)			
		}
		
		/**
		 * red2D를 초기화 2단계-2 - context3D 활성화 확인가능 체크
		 * @param event
		 * 
		 */		
		private function setContext3D( $event:Event ):void
		{
			trace(":::::::::: Context3D Test : Pass!!")		
			_enableRed2D = true
			targetContext3d = targetStage.stage3Ds[0].context3D
			
			// targetContext3d관련정보 세팅
			resetContext3D_property()			
			// 공용 - 사각형정점 정보와 인덱스 정보세팅
			setBufferData()
			// 공용 - program3D정보세팅 : 재질에서 ProgramData 클래스에 접근하여 재질명을 기준으로 program을 리턴받아 setProgram매서드를 실행합니다.
			setProgramData()
			
			// 리사이즈 될떄마다 필요한 정보를 다시 세팅합니다.
			targetStage.addEventListener(Event.RESIZE, HD_Resize)
			trace(":::::::::: Start Molehill!! With red2D ::::::::::")
		}
		
		
		/**
		 * red2D를 초기화 3단계 context3D를 설정합니다. 
		 * 
		 */		
		private function resetContext3D_property():void
		{
			targetContext3d.enableErrorChecking = false	
			targetContext3d.configureBackBuffer( targetStage.stageWidth , targetStage.stageHeight ,2, false)				
			targetContext3d.setCulling(Context3DTriangleFace.BACK);
			targetContext3d.setDepthTest(false, Context3DCompareMode.NEVER)
			
			// 마우스 이벤트를 체크
			targetStage.addEventListener(MouseEvent.MOUSE_DOWN, HD_MouseDownCheck)
			targetStage.addEventListener(MouseEvent.MOUSE_UP, HD_MouseUpCheck)
		}
		
		
		/********************************************************************************/
		/** 매서드  **/
		/********************************************************************************/
		
		/**
		 * 사각형을 그릴 버퍼데이터를 생성한다.(공용입니다) 
		 * 
		 */	
		
		private function setBufferData():void{
			targetBufferData = new Red_BufferData( targetContext3d )
		}
		
		/**
		 * program3d를 생성합니다.(공용입니다) 
		 * 
		 */		
		private function setProgramData():void
		{
			targetProgramData = new Red_ProgramData( targetContext3d )
		}	
		
		/**
		 * Red_Scene 등록 
		 * @param $scene
		 * 
		 */		
		public function setScene( $scene:Red_Scene ):void{
			targetScene = $scene
			checkEnableContext3D()
		}
		
		/**
		 * Scene이 등록되는 시점에서 _targetContext3D 접근이 가능한지를 체크한다. 
		 * 
		 */		
		private function checkEnableContext3D():void {
			stage.addEventListener(Event.ENTER_FRAME, tempLoop );
		}
		
		/**
		 * _targetContext3D 실행준비가 되었는지 확인한다. 
		 * @param event
		 * 
		 */		
		private function tempLoop( $event:Event ):void {
			if ( _enableRed2D ) {
				if ( targetStage.stageWidth > 0 && targetStage.stageHeight > 0 ) {
					targetStage.removeEventListener( Event.ENTER_FRAME, tempLoop );
					setRender()				
				}
			}
		}
		
		/**
		 * targetScene을 렌더링합니다. 
		 * 
		 */		
		private function setRender():void
		{
			trace(":::::::::: Set New Scene ::::::::::")
			
			if(targetScene==null){
				throw new Error("target Scene을 입력해주세요")
			}
			
			targetScene.context3D = targetContext3d
			targetScene.stage = targetStage
			targetScene.setDesign()
				
			HD_Resize()
			
			if(hasEventListener(Event.ENTER_FRAME)){
				removeEventListener(Event.ENTER_FRAME, HD_TimeRender);	
			}
			addEventListener(Event.ENTER_FRAME, HD_TimeRender);		
		
			System.gc()
			// 타이머기준으로 렌더링을 재설정합니다.
			//	setTimer()
		}		
		
		/**
		 * 렌더타이머를 이용한 렌더설정   
		 * 현재는 사용하지않음
		 */		
		private function setTimer():void
		{
			if(_timer!=null){
				_timer.removeEventListener(TimerEvent.TIMER, HD_TimeRender)
				_timer=null
			}
			/*_timer = new Timer(1000/60)
			//TODO 1000개 이하 1100개 12000개 1300개 1400개 1500개 1600개 1700개 이상일때....구분하여 렌더링 주기를 설정합니다.
			_timer.start()
			_timer.addEventListener(TimerEvent.TIMER, HD_TimeRender)*/
			setInterval(HD_TimeRender,1000/60)
		}
		
		/********************************************************************************/
		/** 이벤트 핸들러 **/
		/********************************************************************************/	
		private function HD_TimeRender(event:Event=null):void
		{
			checkTime =  int((getTimer())/10%60)
			if(_prevNum != checkTime){			
				// * Context3d를 지움				
				targetContext3d.clear(_backgroundColor_Data[0],_backgroundColor_Data[1],_backgroundColor_Data[2])
				// * Context3D를 지우고 표시만하고 나머지 연산은 하위 개별 객체에게 맡긴다.
				// * 등록된 scene에  setRenderList명령을 실행함 				
				targetScene.setRenderList()	
				// * context3d를 표시함				
				_prevNum =  checkTime
				targetContext3d.present()	
			}		}
		
		/**
		 * red2D를 초기화 2단계 - context3D 활성화가 불가능할경우 핸들러
		 * @param event
		 * 
		 */		
		private function HD_context3D_Error(event:Event):void
		{
			trace(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")	
			trace(":::::::::: Context3D Test : Fail!! - Check Your wmode, set wmode=direct or gpu")		
			trace(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")	
		}
		
		
		/********************************************************************************/
		/** 이벤트 핸들러  **/
		/********************************************************************************/
		
		/**
		 * 리사이즈 
		 * @param event
		 * 
		 */		
		private function HD_Resize( $event:Event=null ):void
		{
			trace(":::::::::: Stage Resize!! reset configureBackBuffer ::::::::::")
			resetContext3D_property()	
			// 시점좌표계와 전역좌표계를 재설정합니다.
			targetScene.resetVcsAndWcs()
		}
		
		/**
		 * 마우스가 MouseDown상태일때를 체크
		 * @param event
		 * 
		 */		
		private function HD_MouseDownCheck(event:MouseEvent):void
		{
			currentMouseDown = true			
		}
		
		/**
		 * 마우스가 MouseUp상태일때를 체크 
		 * @param event
		 * 
		 */		
		private function HD_MouseUpCheck(event:MouseEvent):void
		{
			currentMouseDown = false			
		}
		
		/********************************************************************************/
		/** get / set  **/
		/********************************************************************************/
		
		/**
		 * 배경컬러값을 지정/반환합니다.
		 */
		public static function get backgroundColor():int
		{
			return _backgroundColor;
		}
		
		/**
		 * 배경컬러값을 지정/반환합니다.
		 */
		public static function set backgroundColor( $color:int):void
		{
			_backgroundColor_Data = RGB_separator.divide($color)
			_backgroundColor = $color;
		}
	}
}

