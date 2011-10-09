package red2D.system
{
	import com.adobe.pixelBender3D.PBASMProgram;
	import com.adobe.pixelBender3D.RegisterMap;
	import com.adobe.pixelBender3D.utils.ProgramConstantsHelper;
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	import flash.utils.ByteArray;
	
	import red2D.system.shaderType.Normal;
	import red2D.system.shaderType.ShaderType;
	

	/** 
	 * <p>재질표현에 사용할 Shader를 전체 관리하는 클래스 (일반 유저 사용빈도는 거의없습니다)</p> 
	 * Red_ProgramData/ Last update - Sep 11, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0  
	 */
	public class Red_ProgramData
	{
		/**
		 * 기본 쉐이더 
		 */		
		private var _normal:Normal;

		/**
		 * 현재 지정된 쉐이더 
		 */		
		private var _currentShaderType:String
		
		/**
		 * Program3D 
		 */		
		private var _shaderProgram:Program3D;

		/**
		 * 생성자 
		 * @param $context3d
		 * 
		 */			
		public function Red_ProgramData( $context3d:Context3D )
		{
			Init($context3d)
		}
		
		/**
		 * 쉐이더초기화 
		 * @param $context3d
		 * 
		 */		
		private function Init($context3d:Context3D):void
		{
			// 기본적으로 노말 쉐이더로 설정된다.
			_normal = new Normal($context3d)
		}
		
		/**
		 * 쉐이더 프로그램 리턴 
		 * @return 
		 * 
		 */		
		public function getShaderProgram3D():Program3D
		{
			return _shaderProgram;
		}
		
		/**
		 * 쉐이더 프로그램 지정 
		 * @param $shaderType
		 * 
		 */		
		public function setShaderProgram3D( $shaderType:String):void
		{
			// TODO  쉐이더가 다양해질경우 타입을 토대로 분기
			switch ($shaderType){
				case ShaderType.NORMAL :
					_shaderProgram = _normal.getShaderProgram()
					_currentShaderType = $shaderType
					break
			}
		}	
		
		/********************************************************************************/
		/** get / set  **/
		/********************************************************************************/	

		/**
		 * 현재 렌더링에 사용할 쉐이더 타입을 지정하거나 현재 지정된 쉐이더 타입을 반환합니다 
		 * @return 
		 * 
		 */		
		public function get currentShaderType():String
		{
			return _currentShaderType;
		}

		/**
		 * 현재 렌더링에 사용할 쉐이더 타입을 지정하거나 현재 지정된 쉐이더 타입을 반환합니다 
		 * @param value
		 * 
		 */		
		public function set currentShaderType(value:String):void
		{
			_currentShaderType = value;
		}

		

	}
}

