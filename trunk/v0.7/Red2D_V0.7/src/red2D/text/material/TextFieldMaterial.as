package red2D.text.material
{
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import red2D.system.Red2D;
	import red2D.material.MaterialBase;
	
	/**  
	 * TextFiledMaterial의 직접사용보다 Red_TextFiled를 사용하시는것을 권장합니다
	 * <p>TextFiledMaterial - TextFiled을 재질로 지정하는 Class</p>
	 * <p>실제로 TextFiled를 생성하고 디스플레이 표현만 StageAPI(Molehill)을 이용한다</p>
	 * <p>이벤트 관련 부분과 width,height 속성을 제외하고는 일반 TextField와 거의 동일하게 사용 할 수있다</p>
	 * Last update - August 21, 2011
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
			_textField.type = TextFieldType.DYNAMIC
			_textField.autoSize = "left"
			
			_textField.text = $text		
			_textField.textColor = $color
			_textField.borderColor =0xffffff
			_textField.backgroundColor =0xffffff
				
			_textFormat = new TextFormat()
			_textField.defaultTextFormat = _textFormat
				
		}

		/**
		 * 텍스트필드 상태업그레이드 
		 * @param $event
		 * 
		 */		
		private function textFiledTextureUpdate( $event:Event=null ):void
		{
			_textField.x=0
			_textField.y=0
			_width =  checkSize(_textField.width)
			_height = checkSize(_textField.height)
			
				
			setMatrix()

			_bitmapData = new BitmapData(_width,_height, true, 0x00ffffff)
			_bitmapData.draw(_textField,null,null,null,null,true)
			
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
			_matrix.translate(int((_width-_textField.width)/2),int((_height-_textField.height)/2))				
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
			return {width:_width , height:_height, mx:_textField.width, my:_textField.height}
		}
		
		/**
		 * 상태업데이트 
		 * 
		 */		
		public function update():void{
			// 무조건 오토사이즈는 왼쪽임
			_textField.autoSize="left"
			_textField.x=0
			_textField.y=0
			_textField.setTextFormat(_textFormat)
			textFiledTextureUpdate()
		}
		/********************************************************************************/
		/** get / set   **/
		/********************************************************************************/		
		public function get size():Number
		{
			return _size;
		}
		
		public function set size(value:Number):void
		{
			_size = value;
			_textFormat .size= _size
			update()		
		}	
		
		public function get align():String
		{
			return _align;
		}
		
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
		
		/**
		 * 가장 가까운 거듭제곱을 찾습니다. 
		 * @param $targetNumber
		 * @return 
		 * 
		 */		
		private function checkSize( $targetNumber:Number ):Number{
			var checkNum:Number = 1
			for( var i:Number=0 ; i < 100 ; i++){
				if( $targetNumber <= checkNum ){
					break
				}					
				checkNum = checkNum*2
			}			
			return checkNum			
		}
	}
}