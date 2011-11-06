package red2D.system.shaderType
{
	import com.adobe.pixelBender3D.PBASMProgram;
	import com.adobe.pixelBender3D.RegisterMap;
	import com.adobe.pixelBender3D.utils.ProgramConstantsHelper;
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	import flash.utils.ByteArray;
	
	import red2D.system.Red2D;

	/** 
	 * 개발 테스트용입니다...향후 픽벤을 이용한 오브젝트가 생성될시 이 쉐이더클래스를 참고할 목적.
	 * 픽셀벤더3D - Nomal/ Last update - Sep 12, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Normal_PB3D
	{
		[Embed (source="./res/FragProgram.pb3dasm", mimeType="application/octet-stream")]
		private static const sampleFragmentProgram : Class;
		
		[Embed (source="./res/TestVertexProgram.pb3dasm", mimeType="application/octet-stream")]
		private static const materialVertexProgram : Class;
		
		[Embed (source="./res/VertexMatrixVectorMult.pb3dasm", mimeType="application/octet-stream")]
		private static const vertexMatrixMultProgram : Class;
		
		private var vertexRegisterMap_:RegisterMap;
		private var fragmentRegisterMap_:RegisterMap;
		private var _parameterBufferHelper:ProgramConstantsHelper;
		private var _shaderProgram:Program3D;
		
		/**
		 * 픽셀벤더3D - 기본 Program Shader 
		 * @param $context3d
		 * 
		 */		
		public function Normal_PB3D($context3d:Context3D)
		{
			var inputVertexProgram : PBASMProgram = new PBASMProgram( readFile( vertexMatrixMultProgram ) );
			
			var inputMaterialVertexProgram : PBASMProgram = new PBASMProgram( readFile( materialVertexProgram ) );
			var inputFragmentProgram : PBASMProgram = new PBASMProgram( readFile( sampleFragmentProgram ) );
			
			var programs : com.adobe.pixelBender3D.AGALProgramPair = com.adobe.pixelBender3D.PBASMCompiler.compile( inputVertexProgram, inputMaterialVertexProgram, inputFragmentProgram );
			
			var agalVertexBinary : ByteArray = programs.vertexProgram.byteCode;
			var agalFragmentBinary : ByteArray = programs.fragmentProgram.byteCode;
			
			vertexRegisterMap_ = programs.vertexProgram.registers;
			fragmentRegisterMap_ = programs.fragmentProgram.registers;
			
			_parameterBufferHelper = new ProgramConstantsHelper( $context3d, vertexRegisterMap_, fragmentRegisterMap_ );
			
			_shaderProgram = $context3d.createProgram();
			_shaderProgram.upload( agalVertexBinary, agalFragmentBinary );	
		}
		
		/********************************************************************************/
		/** readFile **/
		/********************************************************************************/	
		private function readFile( f : Class ) : String
		{
			var bytes:ByteArray;
			
			bytes = new f();
			return bytes.readUTFBytes( bytes.bytesAvailable );
		}

		/********************************************************************************/
		/** get / set  **/
		/********************************************************************************/	
		public function get parameterBufferHelper():ProgramConstantsHelper
		{
			return _parameterBufferHelper;
		}
		
		/**
		 * shaderProgram반환 
		 * @return 
		 * 
		 */		
		public function getShaderProgram():Program3D{
			return _shaderProgram
		}
	}
}

