package red2D.display.base
{
	import avmplus.getQualifiedClassName;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.IndexBuffer3D;
	import flash.geom.Matrix3D;
	
	import red2D.material.ColorMaterial;
	import red2D.system.Red2D;

	/** 
	 * <p>Red_Display의 기본객체이며 실제적인 기본사각형을 그리는 베이스 클래스</p>
	 * <p>Last update - Sep 11, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_DisplayObject extends Red_Display_BaseProperty implements IRed_Display
	{
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		/**
		 * 기본적으로 사용하게될 Context3D 
		 */		
		protected var _targetContext3D:Context3D
		/**
		 * 사각형을 그리는 순서를 지정할 IndexBuffer 
		 */		
		protected var _indexBuffer:IndexBuffer3D;
		/**
		 * 마우스 이벤트 체크에 사용할 매트릭스 
		 */		
		protected var _mouseCheckMatrix:Matrix3D;
	
		/********************************************************************************/
		/** 생성자 **/
		/********************************************************************************/	
		
		public function Red_DisplayObject()
		{
			var className:String = getQualifiedClassName(this);			
			//  클래스를 직접 생성하는지 확인 - 직접생성할 경우 에러
			if (className == "red2D.display.base::Red_DisplayObject")
			{
				throw new Error("Red_DisplayObject 생성자로 이용 할 수 없습니다")		
			}		
		}
		
		/********************************************************************************/
		/** 매서드 **/
		/********************************************************************************/	
		
		/**
		 * 초기화 
		 * 
		 */		
		public function InitBase():void
		{
			if(_material==null){
				_material = new ColorMaterial(0xffffff*Math.random())
			}	
			if(_targetContext3D==null){
				_targetContext3D = Red2D.targetContext3d
			}			
			if(_indexBuffer==null){
				_indexBuffer =Red2D.targetBufferData.indexBuffer
			}
		}		
		
		/**
		 * 실제객체그리기 
		 * 
		 */		
		public function drawObject():void
		{
			// 블렌딩모드설정
			setBlendMode(_blendMode)
						
			// 디스플레이 속성값에 변화가 있을경우 매트릭스를 재설정합니다
			setMatrix()			
			
			// 프로그램 설정(재질내에서 프로그램을 설정합니다)
			setProgram( targetFilters )
			
			// 매트릭스정보를 입력하고 컬러값과 알파값을 입력합니다.
			_targetContext3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _mvp , true);// 정점 정보
			
			// 알파값 연산이 필요할때만..알파값을 업로드한다.
			_targetContext3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0,  _alphaVector);	 // alpha
	
			// TODO TintColor 구현
			//_targetContext3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1,  _tintColorVector);	 // tintColor
			// TODO TintAlpha 구현
			//_targetContext3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2,  _tintAlphaVector);	 // tintAlpha	
			
			// 아래쪽은 헬퍼를 이용할떄 -픽벤을 이용할떄 아래 처럼 파라미터 헬퍼를 이용해 입력
			/*
			_programConstantsHelper.setMatrixParameterByName( Context3DProgramType.VERTEX, "objectToClipSpaceTransform", _mcs ,true)
			_programConstantsHelper.setNumberParameterByName( Context3DProgramType.FRAGMENT, "alpha", _alphaVector)
			_programConstantsHelper.update();
			*/

			// 삼각형을 그려요~
			_targetContext3D.drawTriangles( _indexBuffer,0,2 )
		}
		
		/**
		 * 재질설정 
		 * 
		 */		
		protected function setProgram( $filters:Array ):void
		{
			_material.setProgram( $filters )			
		}
		/**
		 * 모델좌표계와 전역좌표계화 화면좌표계를 반영합니다. (속성의 변화가 있을때만 변경합니다)
		 * 
		 */		
		protected function setMatrix():void
		{
			throw new Error("오버라이드하세요")
		}
		
		/**
		 * 블렌딩모드설정 
		 * @param _blendMode
		 * 
		 */		
		protected function setBlendMode( $blendMode:String ):void
		{
			// TODO BlendMode 재정리를 해야합니다.
			switch ($blendMode) {
				case Red_BlendMode.NORMAL:
					_targetContext3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
					break;
				case Red_BlendMode.ADD:
					_targetContext3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE);

					break;				
				default:
					throw new ArgumentError("Unsupported blend mode!");
			}		
		}
	}
}

