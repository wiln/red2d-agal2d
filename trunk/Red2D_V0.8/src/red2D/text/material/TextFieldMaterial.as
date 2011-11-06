package red2D.text.material
{
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import red2D.material.MaterialBase;
	import red2D.system.Red2D;
	import red2D.util.CheckPower;
	
	/**  
	 * <p>Red_TextField에서 사용하는  TextFieldMaterial입니다.(단독사용을 권장하지 않습니다.)</p>
	 * Last update - Oct 20, 2011
	 * 
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */ 
	public class TextFieldMaterial extends MaterialBase
	{
	
		private var _textField:TextField;
		
		private var _textFormat:TextFormat;		
		private var _matrix:Matrix=new Matrix;
		private var _size:Number;
		private var _align:String;
		private var _text:String;
		
		/**
		 * TextFieldMaterial 
		 * @param $text
		 * @param $size
		 * @param $textColor
		 * 
		 */
		public function TextFieldMaterial( $text:String = "Red_TextField" , $color:int = 0x666666 )
		{
			_context3d = Red2D.targetContext3d
			
			_textField = new TextField()
				
			_textField.type = TextFieldType.INPUT
			_textField.autoSize = "left"			
			_textField.text = $text		
			_textField.textColor = $color
			_textField.borderColor =0xffffff
			_textField.backgroundColor =0xffffff
				
			// 텍스트 포멧지정
			_textFormat = new TextFormat()
			_textFormat.size=12
			_textField.defaultTextFormat = _textFormat
				
		}

		/**
		 * 텍스트필드 상태업그레이드 
		 * @param $event
		 * 
		 */		
		private function textFiledTextureUpdate( $event:Event=null ):void
		{
			// 실제 사이즈 입력
			_inputWidth =_textField.width
			_inputHeight =_textField.height
			
			// 생성할 사이즈 리턴
			_width =  CheckPower.Check(_inputWidth)
			_height = CheckPower.Check(_inputHeight)
			
			// 실제사이즈와 생성사이즈 사이의 비율을 구함
			_sizeRatioWidth =  (_width/_inputWidth)
			_sizeRatioHeight =  (_height/_inputHeight)		
				
/*			trace("변환전 기본값",_inputWidth)
			trace("변환전 기본값",_inputHeight)
			
			trace("거듭제곱변환",_width)
			trace("거듭제곱변환",_height)
			
			trace("거듭제곱에 맞게 변환된 비율",_sizeRatioWidth)
			trace("거듭제곱에 맞게 변환된 비율",_sizeRatioHeight)*/
				
			setMatrix()
			
			// 텍스트 필드를 그리기위해 1차적으로 비트맵이미지에 복사
			var imsiTextFieldBitmapData:BitmapData = new BitmapData(_textField.width, _textField.height,true, 0x00ffffff)
			imsiTextFieldBitmapData.draw(_textField,null,null,null,null,true)
						
			// 복사한 이미지를 실제 비트맵 이미지로 비율변환하여 복사 (왜인지 그냥 복사하면 스케일 오류가남)
			_bitmapData = new BitmapData(_width,_height, true, 0x00ffffff)
			_bitmapData.draw(imsiTextFieldBitmapData,_matrix,null,null,null,true)
				
			_texture= _context3d.createTexture( _width ,_height , Context3DTextureFormat.BGRA ,false);		
			_texture.uploadFromBitmapData( _bitmapData );	

			_bitmapData.dispose()
		}		
		
		/**
		 * 매트릭스설정 
		 * 
		 */		
		private function setMatrix():void
		{
			_matrix.identity()		
			_matrix.scale(_sizeRatioWidth, _sizeRatioHeight)	
		}
		
		
		/**
		 * TextFiled를 반환합니다. 
		 * @return 
		 * 
		 */		
		public function getRealTextField():TextField{
			return _textField
		}		
		/**
		 * TextField의 사이즈를 반환합니다. 
		 * @return 
		 * 
		 */		
		public function getTextureSize():Object
		{				
			textFiledTextureUpdate()
			return {width:_textField.width , height:_textField.height}
		}
		
		/**
		 * 상태업데이트 
		 * 
		 */		
		public function update():void{
			// 무조건 오토사이즈는 왼쪽임
			_textField.setTextFormat(_textFormat)
			_textField.autoSize="left"
			_textField.x=0
			_textField.y=0			
			textFiledTextureUpdate()
		}
		
		/********************************************************************************/
		/** get / set   **/
		/********************************************************************************/		
		
		/**
		 * 사이즈 
		 * @return 
		 * 
		 */		
		public function get size():Number
		{
			return _size;
		}
		/**
		 * 사이즈 
		 * @param value
		 * 
		 */		
		public function set size(value:Number):void
		{
			_size = value;
			_textFormat .size= _size
			update()		
		}	
		
		/**
		 * 정렬 
		 * @return 
		 * 
		 */		
		public function get align():String
		{
			return _align;
		}
		
		/**
		 * 정렬 
		 * @param value
		 * 
		 */		
		public function set align(value:String):void
		{
			_align = value;
			_textFormat.align = _align
			update()
		}		
		
		/**
		 * 텍스트 포멧설정 
		 * @param $textFormat
		 * 
		 */		
		public function setTextFormat( $textFormat:TextFormat ):void{
			_textFormat = $textFormat
			update()
		}
		
		/**
		 * 텍스트 포멧 반환 
		 * @param $textFormat
		 * @return 
		 * 
		 */		
		public function getTextFormat():TextFormat{
			return _textFormat
		}
	}
}