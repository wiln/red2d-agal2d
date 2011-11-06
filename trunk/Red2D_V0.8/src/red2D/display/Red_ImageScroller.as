package red2D.display
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import red2D.material.BitmapMaterial;
	import red2D.system.Red2D;
	
	/** 
	 * 한장의 이미지로 이미지 스크롤러를 자동 생성해주는 클래스 
	 * <p>Last update - Oct 6, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_ImageScroller extends Red_Sprite
	{
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		private var _speed:Number;
		
		private var _bg1:Red_Sprite;
		private var _bg2:Red_Sprite;
		
		private var _targetMaterial:BitmapMaterial;
		private var _sourceData:BitmapData;
		private var _rect:Rectangle;
		
		/**
		 * 화면에 맞추에 이미지를 자동으로 늘릴것인지 여부를 설정 
		 */		
		private var _scaleToScreen:Boolean;
		
		private var _targetStage:Stage;
		private var _direction:String = Red_ImageScroller_Direction.TOP_TO_BOTTOM;
		
		/**
		 * 생성자 
		 * @param $source 가로/세로의 크기가 가 반드시 2의 제곱인 크기로 입력
		 * @param $speed 이미지 스크롤 이동속도
		 * @param $scaleToScreen 화면에 맞추어 이미지를 자동으로 늘릴지를 여부를 결정
		 * 
		 */		
		public function Red_ImageScroller($source:BitmapData, $speed:Number=0, $scaleToScreen:Boolean=true, $direction:String = Red_ImageScroller_Direction.TOP_TO_BOTTOM)
		{
			_scaleToScreen = $scaleToScreen
			_speed =$speed
			_direction = $direction
			_sourceData = $source
			_rect = _sourceData.rect				
			_targetStage = Red2D.targetStage

			setDesign()
		}
		
		/**
		 * 이미지 배치 
		 * 
		 */
		private function setDesign():void
		{
			_targetMaterial  = new BitmapMaterial(_sourceData)
				
			setList()
			setSize()
			setMaterial()
			setLocation()
			addChilds()
			
			_targetStage.addEventListener(Event.RESIZE, HD_resize)
		}
		
		private function setSize():void
		{
			if(_scaleToScreen){
				_bg1.width=_targetStage.stageWidth
				_bg1.height=_targetStage.stageHeight
				_bg2.width=_targetStage.stageWidth
				_bg2.height=_targetStage.stageHeight
			}else{
				_bg1 = new Red_Sprite(_rect.width, _rect.height)
				_bg2 = new Red_Sprite(_rect.width, _rect.height)
			}		
		}		

		private function setList():void
		{
			if(_scaleToScreen){
				_bg1 = new Red_Sprite(_targetStage.stageWidth, _targetStage.stageHeight)
				_bg2 = new Red_Sprite(_targetStage.stageWidth, _targetStage.stageHeight)
			}else{
				_bg1 = new Red_Sprite(_rect.width, _rect.height)
				_bg2 = new Red_Sprite(_rect.width, _rect.height)
			}		

		}
		
		private function setLocation():void
		{
			if(_direction == Red_ImageScroller_Direction.TOP_TO_BOTTOM){
				if(_scaleToScreen){
					_bg1.x = _targetStage.stageWidth/2
					_bg1.y = _targetStage.stageHeight/2					
					_bg2.x = _targetStage.stageWidth/2
					_bg2.y = -_targetStage.stageHeight/2
				}else{						
					_bg1.x = _rect.width/2
					_bg1.y = _rect.height/2					
					_bg2.x = _rect.width/2
					_bg2.y = -_rect.height/2 
				}		
			}else{
				if(_scaleToScreen){
					_bg1.x = _targetStage.stageWidth/2
					_bg1.y = _targetStage.stageHeight/2					
					_bg2.x = _targetStage.stageWidth/2+_targetStage.stageWidth
					_bg2.y = _targetStage.stageHeight/2
				}else{						
					_bg1.x = _rect.width/2
					_bg1.y = _rect.height/2					
					_bg2.x = _rect.width/2+_rect.width
					_bg2.y = _rect.height/2 
				}	
			}
		}
		
		
		private function setMaterial():void
		{
			_bg1.material = _targetMaterial
			_bg2.material = _targetMaterial			
		}	
		
		private function addChilds():void
		{			
			addChild(_bg1)
			addChild(_bg2)
		}
		
		
		
		/**
		 * 리사이즈이벤트 핸들러 
		 * @param event
		 * 
		 */		
		protected function HD_resize(event:Event):void
		{
			setSize()
			setLocation()
		}
		
		/**
		 * 스크롤이동 진행(Step)매서드 
		 * 
		 */		
		public function update():void{
			
			// TODO 종스크롤인가 횡스크롤인가 판단하여 분기
		
			if(_direction == Red_ImageScroller_Direction.TOP_TO_BOTTOM){
				y += _speed
					
				if(_scaleToScreen){
					y = y %(_targetStage.stageHeight)
				}else{
					y = y %(_rect.height)
				}
			}else{
				x -= _speed
					
				if(_scaleToScreen){					
					x = x %(_targetStage.stageWidth)
				}else{
					x = x %(_rect.width)
				}
			}
			
		}		
		
		/********************************************************************************/
		/** get/set  **/
		/********************************************************************************/	
		/**
		 * 이동속도 
		 */
		public function get speed():Number
		{
			return _speed;
		}

		/**
		 * @private
		 */
		public function set speed(value:Number):void
		{
			_speed = value;
		}

		/**
		 * 이동방향 
		 */
		public function get direction():String
		{
			return _direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:String):void
		{
			_direction = value;
		}


	}
}

