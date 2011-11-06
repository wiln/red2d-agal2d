package red2D.system.shaderType
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	
	import red2D.filter.base.AFilterBase;
	import red2D.filter.base.FilterType;

	/** 
	 * <p>Filter 쉐이더</p> 
	 * Last update - Sep 12, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Filter
	{
		
		/**
		 * 필터리스트 
		 */		
		public var filters:Array = []
		
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

		
		/********************************************************************************/
		/** vertex 관련 변수  **/
		/********************************************************************************/	

		/**
		 * Vertex 상수벡터의 개수 
		 */		
		private var _totalVertexConstVectorNum:int=0
		
		/**
		 * Vertex AGAL의 기본코드 
		 */		
		private var _baseVertexCode:String 
		
		/**
		 * 이전에 사용한 Vertex AGAL코드 
		 */		
		private var _prevVertexShaderStr:String=""
		
		/**
		 * 새롭게 적용할 Vertex AGAL코드 
		 */			
		private var _vertexShaderStr:String =""	
			

		/********************************************************************************/
		/** fragment관련 변수  **/
		/********************************************************************************/	
		
		/**
		 * fragment 상수벡터의 개수 
		 */		
		private var _totalFragmentConstVectorNum:int=0
			
		/**
		 * fragment AGAL의 기본코드 
		 */		
		private var _baseFragmentCode:String 
		
		/**
		 * 이전에 사용한 fragment AGAL코드 
		 */		
		private var _prevFragmentShaderStr:String=""
			
		/**
		 * 새롭게 적용할 fragment AGAL코드 
		 */			
		private var _fragmentShaderStr:String =""		
					
		/********************************************************************************/
		/** 생성자  **/
		/********************************************************************************/	
		
		/**
		 * Filter Program Shader 
		 * @param $context3d
		 * 
		 */		
		public function Filter($context3d:Context3D)
		{
			_targetContext3D = $context3d
			_vertexAssembler = new AGALMiniAssembler();
			_fragmentAssembler = new AGALMiniAssembler();		
			setVertextShader()
			_shaderProgram = $context3d.createProgram();
			
			_baseVertexCode = ""			
			_baseFragmentCode = ""  
			
			// 픽셀쉐이더에서 이용할 최종  uv 무조건 ft7에서 받는다.
			_baseFragmentCode += "mov ft7, v0\n"
			
			_baseFragmentCode += "tex ft1, v0, fs0 <2d,clamp,linear>\n"			
			_baseFragmentCode += "div ft1.xyz, ft1.xyz, ft1.w\n" 

			
			// 최종결과값 반환 무조건 ft0
			_baseFragmentCode += "mov ft0, ft1\n" 
		}
		
		/**
		 * 프레그먼스 쉐이더 생성 매서드 
		 * 
		 */		
		private function setFragmentShader( $filters:Array ):void
		{

			// fragment 기본출력명령
			_fragmentShaderStr = _baseFragmentCode
				
			// 사용하는 프레그먼스 상수의 갯수를 구합니다.
			_totalFragmentConstVectorNum = 0
			
			// 필터를 분석하고 상수벡터를 입력합니다.
			var checkFilters:Array = []	
			checkFilters = $filters
			
			var target:AFilterBase					
			
			// 필터갯수를 찾고 AGAL코드를 합성할 횟수를 구한다.
			for ( var i:int=0; i<checkFilters.length ; ++i){				
				target = checkFilters[i]
					
				// 필터로 이용할 상수는 1번부터 값을 할당한다..0번은 알파값벡터로 활용하고 있으므로
				for ( var j:int=0; j<target.constVectorNum ; ++j){	
					_totalFragmentConstVectorNum++
					//trace(_totalFragmentConstVectorNum,"constVector"+(j+1) )
					_targetContext3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, _totalFragmentConstVectorNum,  target["constVector"+(j+1)]);	
				}
					
				/*
				// 프레그먼트 필터일때만 선별해서 업로드
				if(target.type == FilterType.FRAGMENT_ONLY){
					// 필터로 이용할 상수는 1번부터 값을 할당한다..0번은 알파값벡터로 활용하고 있으므로
					for ( var j:int=0; j<target.constVectorNum ; ++j){	
						_totalFragmentConstVectorNum++
						//trace(_totalFragmentConstVectorNum,"constVector"+(j+1) )
						_targetContext3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, _totalFragmentConstVectorNum,  target["constVector"+(j+1)]);	
					}
				}
				*/
				
				// 필터를 통해서 적용되는 AGAL 코드합성
				_fragmentShaderStr +=  target.make_AGAL_code(i+1)
			}
			
			// 최종 쉐이더코드 작성+
			// 알파값보정	
			_fragmentShaderStr += "mul ft0.w ,ft0.w,fc0.x\n"
			_fragmentShaderStr += "mov oc, ft0\n"
				
			//throw new Error("어떻게 조합할껀데!!!!!!!!!!!!")			
			// 필터에서 추출해야될것은? 1. 필터에서 사용하는 상수벡터 / 2. 상수벡터 갯수
			// 상수벡터를 받았다면 변수번호를 어떻게 할당할 수있는가? 그리고 변수 할당의 최대갯수는 몇개인가?(fc할당갯수는 28개란다..많네 -_-)
			// 28된다는건 그정도는 처리해주겠다는 의지표명아니겠는가!!!!!	
		}
		
		

		
		/**
		 * 버텍스 쉐이더 생성매서드 
		 * 
		 */		
		private function setVertextShader():void
		{
			_vertexShaderStr =
					"m44 op, va0, vc0\n" +		
					"mov v0, va1\n"					
		}
		
		/**
		 * shaderProgram반환 
		 * @return 
		 * 
		 */		
		public function getShaderProgram():Program3D{
			// 쉐이더 코드가 다를 경우에만 업로드한다..
			// 업로드비용이 가장 큰 비용입니다
			setFragmentShader(filters)
			if( _fragmentShaderStr !=_prevFragmentShaderStr ){
				
				_vertexAssembler.assemble(flash.display3D.Context3DProgramType.VERTEX, _vertexShaderStr);
				_fragmentAssembler.assemble(flash.display3D.Context3DProgramType.FRAGMENT, _fragmentShaderStr);
				_shaderProgram.upload(_vertexAssembler.agalcode, _fragmentAssembler.agalcode);	
				// 이전쉐이더 정보 기록
				_prevFragmentShaderStr = _fragmentShaderStr	
			}
			
			
			return _shaderProgram
		}
	}
}
