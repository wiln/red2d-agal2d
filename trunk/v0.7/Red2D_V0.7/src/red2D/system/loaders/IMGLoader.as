package red2D.system.loaders{
		import flash.display.DisplayObjectContainer;
		import flash.display.Loader;
		import flash.events.Event;
		import flash.events.EventDispatcher;
		import flash.events.IOErrorEvent;
		import flash.net.URLRequest;
		
		/**  
		 * 이미지 파일이나 SWF를 로드하는 Class
		 * / Last update - May 18, 2011
		 * @tag Tag text.
		 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 10 
		 * 
		 * 
		 */  
		
		public class IMGLoader extends EventDispatcher
		{
			/*********************************************************************************/
			/** 상수선언 **/
			/*********************************************************************************/	
			/**
			 * 이미지 로딩완료 
			 */		
			public static const IMG_LOADED:String = "IMG_LOADED";
			
			/*********************************************************************************/
			/** 변수선언 **/
			/*********************************************************************************/	
			private var _url:String;
			private var _urlVar:URLRequest;
			private var _loader:Loader;		
			
			/**
			 * 로드 결과를 trace 할 것 인지를 설정
			 */		
			private var _allowTrace:Boolean;
			
			/**
			 * 로드 완료시 처리할 함수
			 */		
			private var _completeFunction:Function;
			
			/*********************************************************************************/
			/** 매서드선언  ****/
			/*********************************************************************************/
			
			/**
			 * 파일을 로드하는 매서드 
			 * @param $urlPath 로드 할 파일의 경로
			 * @param $completeMethod 로딩완료시 체크할 메서드
			 * @param $useTrace 로드 결과를 trace 할 것 인지를 설정 / 최종 산출물에서는  false로 설정하는 것이 좋다.
			 * <pre><b>
			 * IMGLoader Event : open 발생 || 대상 : ./res/testImg.jpg
			 * IMGLoader Event : complete 발생 || 대상 : ./res/testImg.jpg</b></pre>
			 * 위와같은 trace값의 출력여부를 설정한다.
			 * @return 
			 * 
			 */
			
			public function loadFile ( $urlPath:String , $completeMethod:Function=null ,  $useTrace:Boolean=true ):*{
				_allowTrace = $useTrace
				_completeFunction = $completeMethod
				
				_url = $urlPath;
				_urlVar = new URLRequest( _url );
				_loader = new Loader  ;
				_loader.load ( _urlVar );
				
				// * addEvent
				addEventListeners()			
			}
			
			/**
			 * 로딩이 완료되기전 loader Proxy를 이용해 디스플레이 목록에 등록하고 위치를 설정 할 수 있다.
			 * @param $name 로더에 name값을 지정한다.
			 * @param $parent 로더가 등록될 Diaplaycontainer를 설정한다.
			 * @param $targetX parent를 기준으로 x,y값을 설정한다.
			 * @param $targetY parent를 기준으로 x,y값을 설정한다.
			 * 
			 */		
			public function proxyInit( $name:String , $parent:DisplayObjectContainer , $targetX:int , $targetY:int ):void{
				
				_loader.name = $name
				_loader.x = $targetX
				_loader.y = $targetY
				$parent.addChild(_loader)
			}
			
			/**
			 * 이벤트 등록 매서드 
			 * 
			 */		
			private function addEventListeners():void
			{
				_loader.contentLoaderInfo.addEventListener (Event.OPEN, HD_eventHandler);
				_loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, HD_eventHandler);
				_loader.contentLoaderInfo.addEventListener (Event.COMPLETE, HD_eventHandler);
			}	
			
			/**
			 * 이벤트 등록삭제 
			 * 
			 */		
			private function removeEventListeners():void
			{
				_loader.contentLoaderInfo.removeEventListener (Event.OPEN, HD_eventHandler);
				_loader.contentLoaderInfo.removeEventListener (IOErrorEvent.IO_ERROR, HD_eventHandler);
				_loader.contentLoaderInfo.removeEventListener (Event.COMPLETE, HD_eventHandler);
			}
			
			/**
			 * 로딩상태정보 출력 
			 * 
			 */		
			private function checkAllowTrace( $allowTrace:Boolean , $eventType:String , $targetURL:String ):void{
				if($allowTrace)
					trace ( "TxtLoader에서 " , $eventType , "발생" , "|| 대상 :" , $targetURL );
			}
			
			/*********************************************************************************/
			/** 이벤트 핸들러선언  **/
			/*********************************************************************************/
			/**
			 * 이벤트 핸들러 
			 * @param event
			 * 
			 */		
			private function HD_eventHandler( $event:Event ):void
			{
				switch ( $event.type )
				{
					case "complete" :
						checkAllowTrace(_allowTrace , $event.type , _url)
						dispatchEvent (new Event("IMG_LOADED"));
						removeEventListeners()
						
						// * 완료확인 매서드 실행
						if(_completeFunction !== null)
							_completeFunction()
						break;
					
					case "ioError" :
						checkAllowTrace(_allowTrace , $event.type , _url)
						removeEventListeners()
						break;
					
					default :
						checkAllowTrace(_allowTrace , $event.type , _url)
				}
			}
			
			/*********************************************************************************/
			/** get / set 매서드선언   **/
			/*********************************************************************************/
			/**
			 * 로더객체를 반환 - 로더 Proxy를 이용할 때 사용
			 * @return 
			 * 
			 */
			public function getObj():Loader{
				return _loader;
			}
			
			/**
			 * 로더 컨텐츠를 반환 - 실제 Content를 이용할 때 사용 
			 * @return 
			 * 
			 */	
			public function getContent ():* {
				return _loader.content;
			}
		}
		}