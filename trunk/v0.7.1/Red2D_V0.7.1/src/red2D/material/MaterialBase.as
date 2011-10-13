package red2D.material
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix;
	
	import red2D.system.Red2D;
	import red2D.system.Red_ProgramData;
	import red2D.system.shaderType.ShaderType;

	/** 
	 * <p>MaterialBase - 재질 베이스 클래스</p>
	 * Last update - Oct 13, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class MaterialBase implements IMaterial
	{
		/**
		 * 텍스쳐 
		 */		
		protected var _texture:Texture
		/**
		 * 텍스쳐에 사용할  Bitmap 
		 */		
		protected var _bitmap:Bitmap
		/**
		 * 텍스쳐에 사용할 BitmapData 
		 */		
		protected var _bitmapData:BitmapData;
		
		/**
		 * 텍스쳐 가로크기 
		 */		
		protected var _width:Number;
		
		/**
		 * 텍스쳐 세로크기 
		 */		
		protected var _height:Number;
		
		
		/**
		 * 실제 비트맵데이터의 가로사이즈 
		 */			
		protected var _inputWidth:Number;
		
		/**
		 * 실제 비트맵데이터의  세로사이즈 
		 */		
		protected var _inputHeight:Number;
		
		protected var _sizeRatioWidth:Number;
		
		protected var _sizeRatioHeight:Number;	
		
		
		/**
		 * 현재 이용하고 있는 Context3D 
		 */		
		protected var _context3d:Context3D;
		
		/**
		 * 참조할  ProgramData 
		 */		
		protected var _programData:Red_ProgramData =Red2D.targetProgramData

		/**
		 * 쉐이더 타입 
		 */		
		protected var _shaderType:String =  ShaderType.NORMAL
			
		/**
		 * 실제맵과 생성맵크기비율 
		 */			
		protected var _mapRatioMatrix:Matrix = new Matrix()
		
			
		/**
		 * 시퀀스재질에서 사용할 getTimer() 결과값
		 */		
		public var checkTime:int=0
		
		/**
		 * checkTime이 기존과 동일한지를 비교하기 위한 변수
		 */			
		public var prevCheckTime:int;
			
		/********************************************************************************/
		/** 생성자  **/
		/********************************************************************************/	
			
		public function MaterialBase()
		{
			_context3d = Red2D.targetContext3d
		}
		
		/**
		 * program3D 설정 
		 * 
		 */		
		public function setProgram(  ):void{
			// 기존 프로그램3d와 현재 재질의 프로그램3D가 같은지 체크
			if(	_programData.currentShaderType != _shaderType){
				// 다를 경우 현재 프로그램으로 대체하고 상태를 갱신합니다.
				_programData.setShaderProgram3D(_shaderType)
				_context3d.setProgram(_programData.getShaderProgram3D())		
			}			
			_context3d.setTextureAt(0,_texture)			
		}

		/********************************************************************************/
		/** get/set **/
		/********************************************************************************/	
		
		/**
		 * 실제 비트맵데이터와 그려진 맵크기의 비율
		 * Red_Sprite에 적용할때 비율을 곱하여 프리맵사이즈 개념을 구현한다. 
		 */
		public function get sizeRatioWidth():Number
		{
			return _sizeRatioWidth;
		}

		/**
		 * @private
		 */
		public function set sizeRatioWidth(value:Number):void
		{
			_sizeRatioWidth = value;
		}

		/**
		 * 실제 비트맵데이터와 그려진 맵크기의 비율
		 * Red_Sprite에 적용할때 비율을 곱하여 프리맵사이즈 개념을 구현한다. 
		 */
		public function get sizeRatioHeight():Number
		{
			return _sizeRatioHeight;
		}

		/**
		 * @private
		 */
		public function set sizeRatioHeight(value:Number):void
		{
			_sizeRatioHeight = value;
		}


	}
}

