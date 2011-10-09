package red2D.display.base
{
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.getQualifiedClassName;
	
	import red2D.system.Red2D;

	/** 
	 * Red_Interactive_Property - 마우스 이벤트 관련 속성/ Last update - Sep 15, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_InteractiveObject extends Red_DisplayContainer
	{
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		/**
		 * 마우스 이벤트를 사용할것인가를 설정 
		 */		
		private var _mouseEnable:Boolean=false
		/**
		 * 마우스가 오버상태인가 
		 */		
		private var _mouseOverBoolean:Boolean = false
		/**
		 * 마우스가 다운상태인가 
		 */			
		private var _mouseDownBoolean:Boolean=false
			
		/********************************************************************************/
		/** 마우스이벤트관련 연산변수들  **/
		/********************************************************************************/	
		
		private var _targetRadian:Number;
		private var _targetCos:Number;
		private var _targetSin:Number;
		
		private var _currentMouseX:Number;
		private var _currentMouseY:Number;
		
		private var _checkX:Number;
		private var _checkY:Number;
		
		/********************************************************************************/
		/** 생성자  **/
		/********************************************************************************/	
		public function Red_InteractiveObject()
		{
			var className:String = getQualifiedClassName(this);
			//  클래스를 직접 생성하는지 확인 - 직접생성할 경우 에러
			if (className == "red2D.display.base::Red_InteractiveObject")
			{
				throw new Error("Red_InteractiveObject 생성자로 이용 할 수 없습니다")		
			}	
		}

		/**
		 * 마우스 이벤트를 체크하는 매서드 
		 * 
		 */		
		protected override function checkMouseEvent():void{
			if(_mouseEnable ){
				// TODO 마우스이벤트 체크 부모영향체크
				_currentMouseX = Red2D.targetStage.mouseX-_mouseCheckMatrix.position.x
				_currentMouseY =  Red2D.targetStage.mouseY-_mouseCheckMatrix.position.y
			
				// * 본인의 회전값과 부모의 회전값을 더한 전체 회전양을 구한다.
				_targetRadian = (-_rotation) * Math.PI/180
				_targetCos = Math.cos(_targetRadian)
				_targetSin = Math.sin(_targetRadian)
				
				_checkX = _currentMouseX*_targetCos -_currentMouseY* _targetSin
				_checkY = _currentMouseX*_targetSin + _currentMouseY*_targetCos
				
				_checkX = _checkX+_mouseCheckMatrix.position.x
				_checkY = _checkY+_mouseCheckMatrix.position.y		
					
				checkMouseLocation()
			}
		}
		
		/**
		 * 마우스가 현재 오브젝트위에 있는지를 판단
		 */		
		private function checkMouseLocation():void
		{
			if( (_mouseCheckMatrix.position.x-_width/2*_scaleX)<_checkX && _checkX< (_mouseCheckMatrix.position.x+_width/2*_scaleX )){
				if( (_mouseCheckMatrix.position.y-_height/2*_scaleY )<_checkY && _checkY< (_mouseCheckMatrix.position.y+_height/2*_scaleY)){					
					//trace("충돌감지성공이 되었을때!!")					
					if(!_mouseOverBoolean){
						setMouseOver()
					}
					_mouseOverBoolean=true
					
					// 마우스다운감지
					if(Red2D.currentMouseDown){
						setMouseDown()
					}else{
						_mouseDownBoolean =false
					}					
				}else{					
					setMouseOut()					
				}
			}else{				
				setMouseOut()
			}
		}
		
		/**
		 * MouseDown상태로 세팅 
		 * 
		 */		
		private function setMouseDown():void
		{
			if(_mouseDownBoolean ==false){
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN))
				_mouseDownBoolean = true
				//trace("마우스다운")
			}
		}
		/**
		 * MouseOver상태로 세팅 
		 * 
		 */		
		private function setMouseOver():void
		{
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER))
			Mouse.cursor = MouseCursor.HAND
			//trace("마우스오버")
		}
		/**
		 * MouseOut상태로 세팅 
		 * 
		 */		
		private function setMouseOut():void{
			if(_mouseOverBoolean){
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT))
				Mouse.cursor = MouseCursor.ARROW
			}
			//trace("마우스아웃")
			_mouseOverBoolean=false			
			_mouseDownBoolean = false
		}
	

		/*********************************************************************************/
		/** get / set ****/
		/*********************************************************************************/		
		/**
		 * 마우스 이벤트 활성화 여부 
		 */
		public function get mouseEnable():Boolean
		{
			return _mouseEnable;
		}
		
		/**
		 * @private
		 */
		public function set mouseEnable(value:Boolean):void
		{
			_mouseEnable = value;
		}
	}
}

