package red2D.display.base
{
	import flash.events.EventDispatcher;
	
	import red2D.material.MaterialBase;

	/** 
	 * <p>기본 사각형이 가지는 속성 </p>
	 * <p>(Red2D는 기본적으로 사각형을 그려서 객체를 표현합니다)</p>
	 * Last update - Oct 13, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_Geometry_Property extends EventDispatcher
	{
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		/**
		 * 가로값 
		 */		
		protected var _width:Number=0.001
			
		/**
		 * 세로값 
		 */			
		protected var _height:Number=0.001			
			
		/**
		 * 실제 입력된 가로값  (맵비율과 곱해진다)
		 */		
		protected var _widthReal:Number=0.001
		
		/**
		 * 실제 입력된 세로값  (맵비율과 곱해진다)
		 */			
		protected var _heightReal:Number=0.001
			
		protected var _sizeRatioWidth:Number=1
		protected var _sizeRatioHeight:Number=1
						
		/**
		 * 재질
		 */			
		protected var _material:MaterialBase;
		
		/**
		 * 객체가 가지는 속성이 이전과 동일한지를 판단(현재 미적용상태이며 향후 적용예정) 
		 */		
		protected var _changeProperty:Boolean=true;

		/********************************************************************************/
		/** get / set **/
		/********************************************************************************/	
		
		/**
		 * 가로값 
		 */
		public function get width():Number
		{
			return _width;
		}

		/**
		 * @private
		 */
		public function set width(value:Number):void
		{
			_widthReal= value
			_width = _widthReal/_sizeRatioWidth
				
			if(_width ==0){
				_width = 0.01
			}
			_changeProperty=true
		}

		/**
		 * 세로값 
		 */
		public function get height():Number
		{
			return _height;
		}

		/**
		 * @private
		 */
		public function set height(value:Number):void
		{
			_heightReal=value
			_height = _heightReal/_sizeRatioHeight
				
			if(_height ==0){
				_height = 0.01		
			}
			_changeProperty=true
		}

		/**
		 * 재질
		 */
		public function get material():MaterialBase
		{
			return _material;
		}

		/**
		 * @private
		 */
		public function set material(value:MaterialBase):void
		{
			_material = value;
			_sizeRatioWidth = _material.sizeRatioWidth
			_sizeRatioHeight = _material.sizeRatioHeight
			
			width = _widthReal*_sizeRatioWidth
			height = _heightReal*_sizeRatioHeight
				
			_changeProperty = true
		}

		
		/**
		 * 객체가 가지는 속성이 이전과 동일한지를 판단(현재 미적용상태이며 향후 적용예정)  
		 * @return 
		 * 
		 */		
		public function get changeProperty():Boolean
		{
			return _changeProperty;
		}
		/**
		 * @private
		 */
		public function set changeProperty(value:Boolean):void
		{
			_changeProperty = value;
		}
	}
}

