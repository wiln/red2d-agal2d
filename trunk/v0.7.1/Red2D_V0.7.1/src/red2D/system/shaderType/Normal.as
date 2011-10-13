package red2D.system.shaderType
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	
	import red2D.system.Red2D;

	/** 
	 * <p>Normal 쉐이더</p> 
	 * Last update - Sep 12, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Normal
	{
		/**
		 * vertext 어셈블러 
		 */		
		private var _vertexAssembler:AGALMiniAssembler;
		/**
		 * fragment 어셈블러 
		 */		
		private var _fragmentAssembler:AGALMiniAssembler;
		
		/**
		 * Program3D 
		 */		
		private var _shaderProgram:Program3D;
		
		/**
		 * 기본 Program Shader 
		 * @param $context3d
		 * 
		 */		
		public function Normal($context3d:Context3D)
		{
			
			//compile vertex shader
			var vertexShader:Array =
				[					
					"m44 op, va0, vc0\n" +		
					"mov v0, va1\n"					
				];
			_vertexAssembler = new AGALMiniAssembler();
			_vertexAssembler.assemble(flash.display3D.Context3DProgramType.VERTEX, vertexShader.join("\n"));
			
			//compile fragment shader
			var fragmentShader:Array =
				[
					//"tex ft1, v0, fs0 <2d,nearest,clamp,nomip>\n"+ 
					"tex ft1, v0, fs0 <2d,clamp,linear>\n"+ 				
					
					// 알파값테두리 보정
					"div ft1.xyz, ft1.xyz, ft1.w\n" + // TADAAAAA : divide by the alpha			
					"mul ft1.w ,ft1.w,fc0.x\n"+	
					//"mov ft2 ,fc1\n"+  tintColor
					
					//	"mul ft1 ,ft1,ft2\n"+
					//"mul ft3, ft2, ft1\n"+
					
					"mov oc, ft1\n"
				];
			
			_fragmentAssembler = new AGALMiniAssembler();
			_fragmentAssembler.assemble(flash.display3D.Context3DProgramType.FRAGMENT, fragmentShader.join("\n"));
			
			_shaderProgram = $context3d.createProgram();
			_shaderProgram.upload(_vertexAssembler.agalcode, _fragmentAssembler.agalcode);	
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

