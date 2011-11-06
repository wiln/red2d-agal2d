package red2D.system.shaderType
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	
	import red2D.filter.fragmentBasic.NeonSign;
	import red2D.filter.fragmentBasic.InvertFilter;
	import red2D.filter.fragmentBasic.MonoFilter;
	import red2D.filter.fragmentBasic.NightVisionFilter;

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
		private var _targetContext3D:Context3D;
		private var _totalFilterFragmentNum:int;
		
		/**
		 * 기본 Program Shader 
		 * @param $context3d
		 * 
		 */		
		public function Normal($context3d:Context3D)
		{
			_targetContext3D = $context3d
			_vertexAssembler = new AGALMiniAssembler();
			_fragmentAssembler = new AGALMiniAssembler();
		
			
			setVertextShader()
			setFragmentShader()
			_shaderProgram = $context3d.createProgram();
		
		}
		
		/**
		 * 프레그먼스 쉐이더 생성 매서드 
		 * 
		 */		
		private function setFragmentShader():void
		{

			// 기본 출력명령
			var fragmentStr:String = ""  
			fragmentStr += "tex ft1, v0, fs0 <2d,clamp,linear>\n"			
			fragmentStr += "mov ft0, ft1\n"
			fragmentStr += "div ft1.xyz, ft1.xyz, ft1.w\n" // TADAAAAA : divide by the alpha			
			fragmentStr += "mul ft1.w ,ft1.w,fc0.x\n"
			fragmentStr += "mov ft0, ft1\n"
				
			
			// 최종 쉐이ej코드 작성
			var fragmentShader:Array =
				[
					fragmentStr += "mov oc, ft0\n"
				];
	
			_fragmentAssembler.assemble(flash.display3D.Context3DProgramType.FRAGMENT, fragmentShader.join("\n"));
		}
		
		/**
		 * 버텍스 쉐이더 생성매서드 
		 * 
		 */		
		private function setVertextShader():void
		{
			//compile vertex shader
			var vertexShader:Array =
				[					
					"m44 op, va0, vc0\n" +		
					"mov v0, va1\n"					
				];
		
			_vertexAssembler.assemble(flash.display3D.Context3DProgramType.VERTEX, vertexShader.join("\n"));
		}
		
		/**
		 * shaderProgram반환 
		 * @return 
		 * 
		 */		
		public function getShaderProgram():Program3D{
			_shaderProgram.upload(_vertexAssembler.agalcode, _fragmentAssembler.agalcode);	
			return _shaderProgram
		}
	}
}

