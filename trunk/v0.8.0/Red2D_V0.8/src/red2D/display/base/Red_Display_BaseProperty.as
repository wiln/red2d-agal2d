package red2D.display.base
{
	import flash.geom.Matrix3D;
	
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/** 
	 * <p>기본 디스플레이 속성</p>
	 * Last update - Sep 11, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_Display_BaseProperty extends Red_Geometry_Property 
	{
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		/**
		 * x 좌표 
		 */		
		protected var _x:Number=0
		/**
		 * y 좌표 
		 */			
		protected var _y:Number=0
		
		/**
		 * pivotX 
		 */			
		protected var _pivotX:Number=0
			
		/**
		 * pivotY
		 */			
		protected var _pivotY:Number=0
			
		/**
		 * 회전값 
		 */			
		protected var _rotation:Number=0
		
		/**
		 * 가로스케일 
		 */			
		protected var _scaleX:Number=1
		/**
		 * 세로스케일
		 */			
		protected var _scaleY:Number=1
			
		/**
		 * 모델좌표계 
		 */			
		protected var _mcs:Matrix3D =  new Matrix3D()
		/**
		 * 월드좌표와뷰좌표계
		 */			
		protected var _wcsAndvcs:Matrix3D =  new Matrix3D()
			
		/**
		 * 모델이 가지는 최종좌표계 
		 */			
		protected var _mvp:Matrix3D = new Matrix3D()
		
		/**
		 * 고유이름값 
		 */			
		protected var _name:String
		
		/**
		 * alpha값 
		 */		
		protected var _alpha:Number=1
			
		/**
		 * GPU연산 입력에 사용할 알파값 벡터 
		 */		
		protected var _alphaVector:Vector.<Number>;
		
/*		protected var _tintColor:Number// tintColor라고 해야하는건가..
		protected var _tintAlpha:Number=0

		protected var _tintColorVector:Vector.<Number>;*/

/*		protected var _tintAlphaVector:Vector.<Number>;*/
		
		protected var _blendMode:String=Red_BlendMode.NORMAL


		protected var _filters:Array = []
		public var targetFilters:Array = []
			
			
		/**
		 * 현재 객체의 초기 기준시간을 설정 
		 */		
		protected var _firstTimer:int;
		
		/**
		 * 기준시간을 근거로 현재 시점체크 
		 */		
		protected var _checkTime:int=0
		/**
		 * _checkTime과 비교할 이전 _checkTime
		 */			
		protected var _prevCheckTime:int=0
			
		/********************************************************************************/
		/** get / set **/
		/********************************************************************************/	
		
		/**
		 * x축상의 위치 
		 */
		public function get x():Number
		{
			return _x;
		}

		/**
		 * @private
		 */
		public function set x(value:Number):void
		{
			_x = value;
			_changeProperty=true
		}

		/**
		 * y축상의 위치 
		 */
		public function get y():Number
		{
			return _y;
		}

		/**
		 * @private
		 */
		public function set y(value:Number):void
		{
			_y = value;
			_changeProperty=true
		}

		/**
		 * 회전값 
		 */
		public function get rotation():Number
		{
			return _rotation;
		}

		/**
		 * @private
		 */
		public function set rotation(value:Number):void
		{
			_rotation = value;
			if(_rotation>360){
				_rotation=0
			}
			_changeProperty=true
		}

		/**
		 * 가로비율 
		 */
		public function get scaleX():Number
		{
			return _scaleX;
		}

		/**
		 * @private
		 */
		public function set scaleX(value:Number):void
		{
			if(value==0){
				value=0.0001
			}
			_scaleX = value;
			_changeProperty=true
		}

		/**
		 * 세로비율 
		 */
		public function get scaleY():Number
		{
			return _scaleY;
		}

		/**
		 * @private
		 */
		public function set scaleY(value:Number):void
		{
			if(value==0){
				value=0.0001
			}
			_scaleY = value;
			_changeProperty=true
		}

		
		/**
		 * alpha값 
		 * @return 
		 * 
		 */		
		public function get alpha():Number
		{
			return _alpha;
		}
		
		/**
		 * alpha값 
		 * @param value
		 * 
		 */
		public function set alpha(value:Number):void
		{
			_alpha = value;
			_alphaVector=Vector.<Number>([_alpha,_alpha,_alpha,_alpha])
			_changeProperty=true
	
		}
		
		/**
		 * color값(향후지원)
		 * @return 
		 * 
		 */		
/*		public function get tintColor():Number
		{
			return _tintColor;
		}*/
		/**
		 * tintColor값(향후지원)
		 * @param value
		 * 
		 */		
/*		public function set tintColor(value:Number):void
		{
			_tintColor = value
			var imsiArray:Array = RGB_separator.divide(_tintColor)
			_tintColorVector = Vector.<Number>([imsiArray[0],imsiArray[1],imsiArray[2],1])

		}*/

		/**
		 * tintColor Alpha값(향후지원)
		 */
/*		public function get tintAlpha():Number
		{
			return _tintAlpha;
		}*/

		/**
		 * tintColor Alpha값(향후지원)
		 */
/*		public function set tintAlpha(value:Number):void
		{
			_tintAlpha = value;
			_tintAlphaVector= Vector.<Number>([_tintAlpha,_tintAlpha,_tintAlpha,_tintAlpha]) 
		}*/
		
		public function set name( $name:String):void
		{
			_name = $name;
		}
		
		/**
		 * 고유 이름값 
		 * @return 
		 * 
		 */		
		public function get name():String
		{
			return _name;
		}

		/**
		 * BlendMode 
		 */
		public function get blendMode():String
		{
			return _blendMode;
		}

		/**
		 * @private
		 */
		public function set blendMode(value:String):void
		{
			_blendMode = value;
			_changeProperty=true
		}

		/**
		 * 모델좌표계 
		 */
		public function get mcs():Matrix3D
		{
			return _mcs;
		}

		/**
		 * @private
		 */
		public function set mcs(value:Matrix3D):void
		{
			_mcs = value;
			_changeProperty=true
		}

		/**
		 * 모델이 가지는 최종좌표계 
		 */
		public function get mvp():Matrix3D
		{
			return _mvp;
		}

		/**
		 * @private
		 */
		public function set mvp(value:Matrix3D):void
		{
			_mvp = value;
			_changeProperty=true
		}

		/**
		 * 월드좌표와뷰좌표계
		 * @return 
		 * 
		 */		
		public function get wcsAndvcs():Matrix3D
		{
			return _wcsAndvcs;
		}

		public function set wcsAndvcs(value:Matrix3D):void
		{
			_wcsAndvcs = value;
			_changeProperty=true
		}

		/**
		 * 피봇X 
		 */
		public function get pivotX():Number
		{
			return _pivotX;
		}

		/**
		 * @private
		 */
		public function set pivotX(value:Number):void
		{
			_pivotX = value;
		}

		/**
		 * 피봇Y 
		 */
		public function get pivotY():Number
		{
			return _pivotY;
		}

		/**
		 * @private
		 */
		public function set pivotY(value:Number):void
		{
			_pivotY = value;
		}

		/**
		 * 필터리스트 
		 */
		public function get filters():Array
		{
			return _filters;
		}

		/**
		 * @private
		 */
		public function set filters(value:Array):void
		{
			_filters = separatorAndSortFilter(value);
			targetFilters=_filters
		}
		
		/**
		 * 필터적용 우선순위를 결정합니다.
		 * uv조작관련 필터를 먼저설정합니다. 
		 * @param $checkFilters
		 * @return 
		 * 
		 */		
		private function separatorAndSortFilter($checkFilters:Array):Array
		{
			for ( var i:int=0; i<$checkFilters.length ; ++i){
				if($checkFilters[i].type == FilterType.FRAGMENT_UV){
					var target:AFilterBase = $checkFilters[i]
					$checkFilters.splice($checkFilters.indexOf(target),1)
					$checkFilters.reverse()
					$checkFilters.push(target)
					$checkFilters.reverse()	
				}
				
			}
			return $checkFilters
		}

	}
}

