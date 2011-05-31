package Red2D.display
{
	import Red2D.Material.IMaterial;
	import Red2D.display.base2D.Red_Display_Base;
	
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.events.Event;
	
	/**  
	 * AS3의 Sprite와 비슷한 개념의 디스플레이 오브젝트이다.
	 * <p>마우스이벤트 관련은 현재 적용되지 않았습니다.</p>	
	 * <p>Last update - May 31, 2011</p>
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 * 
	 */  
	public class Red_DisplayObject extends Red_Display_Base
	{			
		
		/**
		 * 재질값 
		 */		
		private var _material:IMaterial;		
		
		
		/*********************************************************************************/
		/** 초기화  ****/
		/*********************************************************************************/
		/**
		 * Red_Sprite생성자입니다.
		 * 
		 * @param $stage
		 * @param $context
		 * @param $width
		 * @param $height
		 * @param $material
		 * @param $x
		 * @param $y
		 * 
		 */		
		public function Red_DisplayObject( $stage:Stage , $context:Context3D,  $width:Number=100 , $height:Number=100 , $material:IMaterial=null , $x:Number=0 , $y:Number=0)
		{
			// * 속성값을 우선 적용하고 diplay를 위한 setupDisplay을 실행합니다.
			// * stage를 가져오는 이유는 matrix3D 설정을 위한 기준값들을 stage로 부터 가져오기때문에 항상 값을 받습니다.
			stage = $stage
				
			// * context3d는 Red World에서 구성된 Context3D를 이용하기위해서 받아옵니다.
			context3d = $context
			
			// * 텍스쳐 구현을 하기위함
			_material = $material
			
			// * 속성설정
			width = $width
			height = $height				
			x = $x
			y = $y
			
			// * 초기화
			setupDisplay()
		}
		
		/**
		 * 초기화 
		 * @param event
		 * 
		 */		
		private function setupDisplay():void
		{
			var data:Vector.<Number> = Vector.<Number>([
				/* 왼쪽 상단이 중점일때				
				0, 0, 0,	
				0, 1, 0,
				1, 1, 0,							
				1, 0, 0		
				*/		
				
				// * 사각형 중심을 0.0으로 작성하는 이유는 매트릭스 설정을 위해서임...
				// * 회전구현시에 이렇게 구성하는게 더 계산하기 편합니다.
				// * 포인트, 포인트, 포인트, UV 포인트 , UV 포인트로 작성했습니다.
				// * 컬러값은 material로 처리하기위해 아래쪽에서 따로 벡터를 받습니다.
				
				-1 , -1, 0,0,1,
				-1 ,  1, 0,0,0,
				 1 ,  1, 0,1,0,
				 1 , -1, 0,1,1				
			])				
			
			var iData:Vector.<uint> = Vector.<uint>([0,1,2,0,2,3])
			
			// * vertext와 index 버퍼 설정
			// * Sprite인 관계로 무조건 사각형을 드로잉하도록 한다.
			setVertexBuffer( data , 4 , 0 , 5 )
			setIndexBuffer( iData , 6 , 0 , 6)
			
			initAGAL()
		}
		
		
		
		
		/*********************************************************************************/
		/** 매서드선언  ****/
		/*********************************************************************************/

		/**
		 * AGAL연산준비(초기화라고 볼 수 있을것 같다....그래서 init를 붙임...set이라고 붙이는게 더맞으려나...)
		 * <p>AGAL연산은 Display객체를 구성 할 때 한번만 설정하면된다... 연속하면 자원 낭비고..
		 * 재질만 꾸준히 갱신하고...삼각형 연만 죽어라 랜더하면되는것 같다.</p> 
		 * 
		 */
		protected override function initAGAL():void
		{			
			// vertex 연산
			vertexProgram = new AGALMiniAssembler()			
			vertexProgram.assemble(Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n"+
				"mov v0, va1\n"
			)
			
			// fragment 연산
			fragmentProgram = new AGALMiniAssembler()
			fragmentProgram.assemble(Context3DProgramType.FRAGMENT,
				"mov ft0, v0\n"+
				"tex ft1, v0, fs0 <2d,nomip,linear>\n"+ //sample texture 0		
				"mov oc, ft1\n"
				//"mov oc, v0\n"
			)
				
			// * 프로그램3D설정
			context3d.setProgram( program3D )
			// * 기본 버텍스 설정
			context3d.setVertexBufferAt( 0 ,vertexBuffer3D, 0 , Context3DVertexBufferFormat.FLOAT_3 )
			// * UV 설정
			context3d.setVertexBufferAt( 1 ,vertexBuffer3D, 3 , Context3DVertexBufferFormat.FLOAT_2 )
		}
		
		
		/*********************************************************************************/
		/** 렌더관련 선언  ****/
		/*********************************************************************************/
		
		/**
		 * 렌더 연산 
		 * @param event
		 * 
		 */		
		protected override function render( $event:Event=null ):void
		{
			// * 매트릭스를 계산합니다.
			// * TODO:향후 Matrix3D는 AGAL로 계산 떄려봅시다...방법이 있곘지...무식이 죄지 -_-;;
			setMatrix3D()
			
			setMaterial(_material) // <-- 이늠이 엄한테 있었음 -_-;;
			
			context3d.setProgramConstantsFromMatrix( Context3DProgramType.VERTEX , 0 , matrix3D , true )
			
			// * 무조건 사각형만 그리겠습니다 -_-;; 
			// * why? : 가만히 생각해 보면... 화면상에 그려지는 2D는 결국  사각형일뿐....직사각형이냐 정사각형이냐의 문제일뿐.... 삼각형이 될 필요가 없다.
			context3d.drawTriangles( indexBuffer3D , 0 , 2 )
			
			
		}			
	}
}