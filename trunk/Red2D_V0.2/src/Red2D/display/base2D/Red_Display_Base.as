package Red2D.display.base2D
{
	import Red2D.Material.IMaterial;
	
	import flash.display3D.Program3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;

	/**  
	 * 모든 Display의 기본이 되는 Class 모든 디스플레이 객체는 이 클래스를 확장해야함
	 * / Last update - May 31, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 * 
	 */  
	public class Red_Display_Base extends Red_Display_BaseProperty
	{

		private var _material:IMaterial;
		/*********************************************************************************/
		/** 매서드선언  ****/
		/*********************************************************************************/
		
		/**
		 * VertextBuffer 생성  
		 * @param $data
		 * @param $numVertices
		 * @param $startVertices
		 * @param $element
		 * 
		 */
		protected function setVertexBuffer( $data:Vector.<Number> , $numVertices:uint=3 ,$startVertices:uint=0 , $element:uint=3 ):void
		{
			// 버텍스버퍼를 생성한다.
			vertexBuffer3D = context3d.createVertexBuffer( $numVertices, $element)			
			vertexBuffer3D.uploadFromVector( $data , $startVertices , $numVertices )
		}
				
		/**
		 * IndexBuffer 생성  
		 * @param $data
		 * @param $numIndices
		 * @param $startOffset
		 * @param $count
		 * 
		 */	
		protected function setIndexBuffer( $data:Vector.<uint> , $numIndices:uint , $startOffset:uint , $count:uint):void
		{
			//인덱스 버퍼를 생성한다.
			indexBuffer3D = context3d.createIndexBuffer( $numIndices )			
			indexBuffer3D.uploadFromVector( $data , $startOffset , $count )			
		}		
		
		/**
		 * 텍스쳐 설정 
		 * @param $texture
		 * 
		 */		
		protected function setMaterial( $material:IMaterial ):void{
			_material = $material 
			if(_material != null){
				/** TODO:FS가 0번이 아니면 어떻게 할텐가? 어떻게 다변화를 받아들일것인가...고민이필요함 **/
				context3d.setTextureAt(0, _material.getTexture());
				
			}
		}
		

		/*********************************************************************************/
		/** 렌더관련 선언  ****/
		/*********************************************************************************/
		
		/**
		 * AGAL연산위한 준비단계로서 vertextBuffer와 indexBuffer를 생성하고 업로드 / 그리고 program3D를 설정한다.
		 * 
		 */		
		protected function initAGAL():void
		{
			throw new Error("override하여 AGAL 연산을 재구성하세요")
		}
		
		/**
		 * 렌더 설정 
		 * @param $program3D
		 * 
		 */		
		public function draw( $program3D:Program3D ):void{
			//trace($program3D)
			if( program3D == null){
				program3D = $program3D
				program3D.upload(vertexProgram.agalcode, fragmentProgram.agalcode)
			}
			render()
		}
		
		/**
		 * 엔터프레임을 통한 실제 렌더 연산이 진행되는 부분 
		 * @param event
		 * 
		 */		
		protected function render( $event:Event=null ):void
		{
			throw new Error("override하여 렌더링을 재구성하세요")			
		}	
		
	
		/**
		 * 화면상에서 정상적인(?) 출력을 위한 매트릭스 표준화작업(Away3D의 오소고날렌즈와 비슷)
		 * 폴리고날에서 이렇게 쓰더라구요 -_-
		 * @param $w
		 * @param $h
		 * @return 
		 * 
		 */		
		protected function makeOrthoProjection( $w:Number, $h:Number ):Matrix3D
		{
			// z는 무조건 1이며 z축 평행 이동 또한 없음..
			// 왜!!! z축까지 하기엔...내가넘 힘듬 -_-;;;;;;;;;;;;
			// 사실 이걸왜 stage크기값으로 계산해야되는지도 모르곘음 -_-;;
			// 걍 다들 이렇게 쓰니까 -0-;;;
			return new Matrix3D(Vector.<Number>
				([
					2/$w, 0  ,       0,        0,
					0  , 2/$h,       0,        0,
					0  , 0  ,       1,        1,
					0  , 0  ,       0,        1
				]));
		}
		
		/**
		 * 매트릭스 3d설정 
		 * 
		 */
		protected function setMatrix3D():void
		{			
			matrix3D.identity()
			// 회전은 제일 먼저해야하고..
			// 스케일과 평행이동은 원하는대로 설정... 다만 순서에따라 규칙이 달라짐으로 설계시 알아서들 구현...			
			matrix3D.appendRotation(rotation, Vector3D.Z_AXIS)
			matrix3D.appendScale(width * (scaleX/2), -height * (scaleY/2), 1);			
			matrix3D.appendTranslation(-stage.stageWidth/2+x, stage.stageHeight/2-y, 0);			
			matrix3D.append(makeOrthoProjection(stage.stageWidth,stage.stageHeight));
		}

		
	}
}