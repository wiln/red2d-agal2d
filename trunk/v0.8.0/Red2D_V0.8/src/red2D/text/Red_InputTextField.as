package red2D.text
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import red2D.display.Red_Sprite;
	import red2D.system.Red2D;
	
	
	/** 
	 * <p>Red_InputTextField</p> 
	 * <p>Red_Sprite를 확장한 클래스이며 TextFieldMaterial을 기본재질로 가진다.</p>
	 * <p>Last update - Oct 31, 2011</p>
	 * @author 백선기(seon ki, Paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11 Beta 
	 */ 
	public class Red_InputTextField extends Red_TextField
	{		
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		
		private var _area:Red_Sprite;		
		private var _checkTextfield:TextField;		
		private var _checkTimer:Timer;
		
		/********************************************************************************/
		/** 생성자 **/
		/********************************************************************************/	
		
		public function Red_InputTextField()
		{			
			InitBase()
			prepare()
			textFiledMaterial.getRealTextField().multiline=true
			setBtArea()
			setToMaterialSize()			
			setEvent()
		}
		
		private function setBtArea():void
		{
			_area = new Red_Sprite(1,1)
			_area.alpha=0
			_area.mouseEnable=true
			addChild(_area)
		}
		
		private function setEvent():void
		{
			_area.addEventListener(MouseEvent.MOUSE_DOWN, HD_DOWN)
			
		}
		
		protected function HD_DOWN(event:Event):void
		{
			//trace("포커스들어옴")
			_checkTextfield = textFiledMaterial.getRealTextField()
			Red2D.targetStage.focus = _checkTextfield
			
			_checkTextfield.addEventListener(FocusEvent.FOCUS_OUT, HD_endKeyCheck)		
			_checkTextfield.setSelection(_checkTextfield.length,_checkTextfield.length)
			setToMaterialSize()
			
			setCheckInterval()
			
		}
		
		/**
		 * 점자표시를 위해 text삭제 
		 * 
		 */		
		private function setCheckInterval():void
		{
			_checkTimer = new Timer(10)
			_checkTimer.start()
			_checkTimer.addEventListener(TimerEvent.TIMER, HD_checkTextField)
		}
		
		protected function HD_checkTextField(event:TimerEvent):void
		{
			setToMaterialSize()
		}
		
		/**
		 * 키보드입력을 감시 
		 * @param event
		 * 
		 */		
		protected function HD_endKeyCheck(event:FocusEvent):void
		{
			//trace("키이벤트감시종료")
			_checkTimer.stop()
			_checkTimer.removeEventListener(TimerEvent.TIMER, HD_checkTextField)
			_checkTimer=null
			
			_checkTextfield.removeEventListener(FocusEvent.FOCUS_OUT, HD_endKeyCheck)
			_checkTextfield=null
			
			setToMaterialSize()
		}
		
		/********************************************************************************/
		/** 매서드 **/
		/********************************************************************************/	
		
				
		/**
		 * Red_TextField를 재질사이즈로 설정 ( 2의 배수로 만든 텍스쳐의 크기를 불러온다)
		 * 
		 */		
		protected override function setToMaterialSize( $event:Event = null ):void
		{
			textFiledMaterial.update()
			sizeObejct = textFiledMaterial.getTextureSize()
			//	trace(sizeObejct.width , sizeObejct.height)			
			
			
			_width = sizeObejct.width
			_height = sizeObejct.height
			
			if(_area !=null ){
				_area.width = _width
				_area.height =  _height	
			}	
			
			
			//trace(_width, _height,sizeObejct.width,sizeObejct.height,sizeObejct.width2,sizeObejct.height2,material.sizeRatioWidth,material.sizeRatioHeight)	
			// 왼쪽상단으로 정렬
			/*			_pivotX = (sizeObejct.width2)/2
			_pivotY = (sizeObejct.height2)/2		*/	
			
			setRotaionPoint()
		}	
		
		
		
		/********************************************************************************/
		/** set  **/
		/** textFiled의 기본속성을 참조하기위하여...set만 설정 get도할까 -_-;;  **/
		/********************************************************************************/		

		
	}
}