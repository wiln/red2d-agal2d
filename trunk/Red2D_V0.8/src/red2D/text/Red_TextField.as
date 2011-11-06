package red2D.text
{
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import red2D.display.base.Red_DisplayContainer;
	import red2D.display.base.Red_InteractiveObject;
	import red2D.text.material.TextFieldMaterial;
	import red2D.text.Red_TextFieldAlign
	
		
	/** 
	 * <p>TextField와 동일한 개념.</p> 
	 * <p>Red_Sprite를 확장한 클래스이며 TextFieldMaterial을 기본재질로 가진다.</p>
	 * <p>Last update - Oct 20, 2011</p>
	 * @author 백선기(seon ki, Paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11 Beta 
	 */ 
	public class Red_TextField extends Red_InteractiveObject
	{		
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		/**
		 * 텍스트필드재질  
		 */		
		protected var textFiledMaterial:TextFieldMaterial;
		/**
		 * 텍스트필드재질의 현재 크기를 반환받는 변수 
		 */		
		protected var sizeObejct:Object;
		
		/**
		 * 실제생성된 텍스트필드 - 디스플레이 표현만 모힐을 사용합니다. 
		 */		
		protected var _targetTextField:TextField;
		
		/**
		 * 텍스트내용 
		 */		
		protected var _text:String
		/**
		 * 텍스트 컬러 
		 */		
		protected var _textColor:int;
		
		/**
		 * 배경색상 사용여부  
		 */		
		protected var _background:Boolean = false
			
		/**
		 * 배경색상 
		 */		
		protected var _backgroundColor:uint
		
		/**
		 * 테두리 사용여부 
		 */		
		protected var _border:Boolean = false
			
		/**
		 *테두리 색상 
		 */			
		protected var _borderColor:uint 
		
		/**
		 * 공백무시 사용여부 
		 */		
		protected var _condenseWhite:Boolean = false
			
		/**
		 * 기본 텍스트포멧 
		 */			
		protected var _defaultTextFormat:TextFormat
		
		/**
		 * 임베딩 폰트 사용여부 
		 */		
		protected var _embedFonts:Boolean = false
			
		/**
		 * htmlText 
		 */			
		protected var _htmlText:String
		
		/**
		 * 총글자수반환 
		 */		
		protected var _length:int
		
		/**
		 * 멀티라인 허용여부 
		 */		
		protected var _multiline:Boolean = false
			
		/**
		 * 텍스트 Size 
		 */		
		protected var _size:Number=12
			
		/**
		 * 텍스트 정렬 
		 */			
		protected var _align:String = Red_TextFieldAlign.LEFT
			
		/**
		 * 텍스트 포멧 
		 */			
		protected var _textFormat:TextFormat;
		
		/**
		 * 텍스트 재질이 이전크기와 어떻게 변화 되었는지를 감지하여 위치보정 
		 */		
		protected var _prevHeight:Number=0
			
		/**
		 * 텍스트 재질이 이전크기와 어떻게 변화 되었는지를 감지 위치보정 
		 */		
		protected var _prevWidth:Number=0
			
		/**
		 * 회전중심점 
		 */			
		protected var _rotationCenterPoint:String = Red_TextFieldRotationCenterPoint.CENTER
			
		/********************************************************************************/
		/** 생성자 **/
		/********************************************************************************/	
		
		public function Red_TextField()
		{			
			InitBase()		
			prepare()
			setToMaterialSize()
		}
		
		/********************************************************************************/
		/** 매서드 **/
		/********************************************************************************/	
		
		/**
		 * 텍스트필드 재질생성 
		 * 
		 */		
		protected function prepare():void
		{
			textFiledMaterial = new TextFieldMaterial()	
			material = textFiledMaterial
		}
				
		/**
		 * Red_TextField를 재질사이즈로 설정 ( 2의 배수로 만든 텍스쳐의 크기를 불러온다)
		 * 
		 */		
		protected function setToMaterialSize( $event:Event = null ):void
		{
			textFiledMaterial.update()
			sizeObejct = textFiledMaterial.getTextureSize()
			//	trace(sizeObejct.width , sizeObejct.height)			
					
	
			_width = sizeObejct.width
			_height = sizeObejct.height

			//trace(_width, _height,sizeObejct.width,sizeObejct.height,sizeObejct.width2,sizeObejct.height2,material.sizeRatioWidth,material.sizeRatioHeight)	
			// 왼쪽상단으로 정렬
/*			_pivotX = (sizeObejct.width2)/2
			_pivotY = (sizeObejct.height2)/2		*/	
				
			setRotaionPoint()
		}	
		
		/**
		 * 정렬설정 
		 * 
		 */		
		protected function setRotaionPoint():void
		{
			switch(_rotationCenterPoint){
				case Red_TextFieldRotationCenterPoint.LEFT :
					_pivotX=(sizeObejct.width)/2
					_pivotY=0
					break
				case Red_TextFieldRotationCenterPoint.CENTER :
					_pivotX=0
					_pivotY=0
					break
				case Red_TextFieldRotationCenterPoint.RIGHT :
					_pivotX=-(sizeObejct.width)/2
					_pivotY=0
					break
				
				case Red_TextFieldRotationCenterPoint.LEFT_TOP :
					_pivotX=(sizeObejct.width)/2
					_pivotY=(sizeObejct.height)/2
					break
				case Red_TextFieldRotationCenterPoint.LEFT_BOTTOM :
					_pivotX=(sizeObejct.width)/2
					_pivotY=-(sizeObejct.height)/2
					break
				case Red_TextFieldRotationCenterPoint.RIGHT_TOP :
					_pivotX=-(sizeObejct.width)/2
					_pivotY=(sizeObejct.height)/2
					break
				case Red_TextFieldRotationCenterPoint.RIGHT_BOTTOM :
					_pivotX=-(sizeObejct.width)/2
					_pivotY=-(sizeObejct.height)/2
					break
			}
		}
		
		/**
		 * 텍스트 포멧설정 
		 * @param $textFormat
		 * 
		 */		
		public function setTextFormat( $textFormat:TextFormat ):void{
			_textFormat = $textFormat
			textFiledMaterial.setTextFormat(_textFormat)
			setToMaterialSize()
		}
		
		/**
		 * 텍스트포멧 반환 
		 * @param $textFormat
		 * @return 
		 * 
		 */		
		public function getTextFormat( $textFormat:TextFormat ):TextFormat{
			return textFiledMaterial.getTextFormat()
		}
		
		
		/********************************************************************************/
		/** set  **/
		/** textFiled의 기본속성을 참조하기위하여...set만 설정 get도할까 -_-;;  **/
		/********************************************************************************/		
		
	
		/**
		 * @protected
		 */
		public override function set pivotX(value:Number):void
		{
			trace(":::::::::: Red_TextField...Can't set pivotX / pivotY property ::::::::::")
		}
		
		
		/**
		 * @protected
		 */
		public override function set pivotY(value:Number):void
		{
			trace(":::::::::: Red_TextField...Can't set pivotX / pivotY property ::::::::::")
		}
		
		/**
		 * @protected
		 */
		public override function set x(value:Number):void
		{
			_x = int(value);
			_changeProperty=true
		}
		
		
		/**
		 * @protected
		 */
		public override function set y(value:Number):void
		{
			_y = int(value);
			_changeProperty=true
		}
		
		
		/**
		 * Red_TextField의 현재 텍스트인 문자열입니다. 
		 * @param value
		 * 
		 */		
		public function set text( $text:String ):void
		{
			_text = $text
			textFiledMaterial.getRealTextField().text = _text		
			setToMaterialSize()
		}
		
		public function get text():String
		{
			return _text;
		}
				
		/**
		 * Red_TextField의 텍스트 필드의 16진수 형식 텍스트 색상입니다.
		 * @param value
		 * 
		 */		
		public function set textColor( value:int ):void
		{
			_textColor = value;
			textFiledMaterial.getRealTextField().textColor = _textColor
			setToMaterialSize()
		}
		
		public function get textColor():int
		{
			return _textColor;
		}		
		
		
		/**
		 * 텍스트 필드에 배경 칠이 있는지 여부를 지정합니다.
		 */
		public function get background():Boolean
		{
			return _background;
		}
		
		/**
		 * @protected
		 */
		public function set background(value:Boolean):void
		{
			_background = value;
			textFiledMaterial.getRealTextField().background	 = _background	
			setToMaterialSize()
		}
		
		/**
		 * 텍스트 필드의 배경색입니다.
		 */
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		
		/**
		 * @protected
		 */
		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
			textFiledMaterial.getRealTextField().backgroundColor = _backgroundColor	
			setToMaterialSize()
		}
		
		/**
		 * 텍스트 필드에 테두리가 있는지 여부를 지정합니다.
		 */
		public function get border():Boolean
		{
			return _border;
		}
		
		/**
		 * @protected
		 */
		public function set border(value:Boolean):void
		{
			_border = value;
			textFiledMaterial.getRealTextField().border = _border	
			setToMaterialSize()
		}
		
		/**
		 * 텍스트 필드의 테두리 색상입니다.
		 */
		public function get borderColor():uint
		{
			return _borderColor;
		}
		
		/**
		 * @protected
		 */
		public function set borderColor(value:uint):void
		{
			_borderColor = value;
			textFiledMaterial.getRealTextField().borderColor = _borderColor	
			setToMaterialSize()
		}
		
		/**
		 * HTML 텍스트가 있는 텍스트 필드에서 공백 문자, 줄 바꿈 등의 불필요한 공백을 제거할지 여부를 지정하는 부울 값입니다.
		 */
		public function get condenseWhite():Boolean
		{
			return _condenseWhite;
		}
		
		/**
		 * @protected
		 */
		public function set condenseWhite(value:Boolean):void
		{
			_condenseWhite = value;
			textFiledMaterial.getRealTextField().condenseWhite = _condenseWhite	

			setToMaterialSize()
		}
		
		/**
		 * 사용자가 입력한 텍스트 등 새로 삽입되는 텍스트에 적용할 서식을 지정합니다.
		 */
		public function get defaultTextFormat():TextFormat
		{
			return _defaultTextFormat;
		}
		
		/**
		 * @protected
		 */
		public function set defaultTextFormat(value:TextFormat):void
		{
			_defaultTextFormat = value;
			textFiledMaterial.getRealTextField().defaultTextFormat = _defaultTextFormat	

			setToMaterialSize()
		}
		
		/**
		 * 포함된 글꼴 외곽선을 사용하여 렌더링할지 여부를 지정합니다. 
		 */
		public function get embedFonts():Boolean
		{
			return _embedFonts;
		}
		
		/**
		 * @protected
		 */
		public function set embedFonts(value:Boolean):void
		{
			_embedFonts = value;
			textFiledMaterial.getRealTextField().embedFonts = _embedFonts	

			setToMaterialSize()
		}
		
		/**
		 * 텍스트 필드 내용의 HTML 표현이 들어 있습니다. 
		 */
		public function get htmlText():String
		{
			return _htmlText;
		}
		
		/**
		 * @protected
		 */
		public function set htmlText(value:String):void
		{
			_htmlText = value;
			textFiledMaterial.getRealTextField().htmlText = _htmlText	
			setToMaterialSize()
		}
		
		/**
		 * 텍스트 필드의 문자 수입니다. 
		 */
		public function get length():int
		{
			return _targetTextField.length
		}
		
		/**
		 *필드가 여러 행 텍스트 필드인지 여부를 나타냅니다. 
		 */
		public function get multiline():Boolean
		{
			return _multiline;
		}
		
		/**
		 * @protected
		 */
		public function set multiline(value:Boolean):void
		{
			_multiline = value;

			setToMaterialSize()
		}
		
		
		/**
		 * width값 
		 * @param value
		 * 
		 */		

		public override function set width(value:Number):void
		{
			//throw new Error(":::::::::: Red_TextField...Can't use width / height property ::::::::::")
			trace(":::::::::: Red_TextField...Can't set width / height property ::::::::::")
		}
		
	
		/**
		 * height값 
		 * @param value
		 * 
		 */		
		public override function set height(value:Number):void
		{
			//throw new Error(":::::::::: Red_TextField...Can't use width / height property ::::::::::")
			trace(":::::::::: Red_TextField...Can't set width / height property ::::::::::")
		}
		
		
		
		
		public function set size( $size:Number ):void{
			_size = $size
			textFiledMaterial.size = _size

			setToMaterialSize()
			changeProperty=true
		}
		
		public function get size( ):Number{
			return _size
		}
		
		/**
		 * 텍스트 정렬(Red_TextAlign사용을 권장합니다) 
		 * @return 
		 * 
		 */		
		public function get align():String
		{
			
			return _align;
		}
		
		public function set align(value:String):void
		{
			_align = value;
			textFiledMaterial.align = _align

			setToMaterialSize()
		}
		
		/*********************************************************************************************/
		/** 오버라이드 **/
		/*********************************************************************************************/	
		
		/**
		 * 모델좌표계와 전역좌표계화 화면좌표계를 반영합니다. (속성의 변화가 있을때만 변경합니다)
		 * 텍스트 필드는 무조건 재계산하기위해 오버라이드
		 */		
		protected override function setMatrix():void{			
			_mcs.identity()			
			_mcs.appendTranslation(_pivotX,_pivotY,1)					
			_mcs.appendRotation(_rotation, Vector3D.Z_AXIS);
			_mcs.appendTranslation(_x,_y,1)					
			
			_mvp.identity()
			_mvp.appendScale(_width*_scaleX,_height*_scaleY,1)		
			_mvp.append(_mcs)				
			
			// 부모좌표계 합산
			var parents:Red_DisplayContainer = this	
			var parentScaleX:Number = _scaleX
			var parentScaleY:Number = _scaleY		
			
			for (var i:int=0; i<1000; ++i){
				if(parents.parent !=null){			
					parents = parents.parent as Red_DisplayContainer
					_mvp.appendScale(parents.scaleX,parents.scaleY,1)
					_mvp.append(parents.mcs)				
				}else{
					break
				}
			}					
			// 마우스이벤트체크를 위해 매트릭스복사
			_mouseCheckMatrix = _mvp.clone()				
			// 화면좌표계로 변환
			_mvp.append(wcsAndvcs)		
		}

		/**
		 * 회원중심점 
		 */
		public function get rotationCenterPoint():String
		{
			return _rotationCenterPoint;
		}

		/**
		 * @protected
		 */
		public function set rotationCenterPoint( value:String):void
		{
			_rotationCenterPoint = value;
			setRotaionPoint()
		}

	}
}