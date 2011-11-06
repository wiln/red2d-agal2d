package red2D.system
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;

	/** 
	 * <p>공용으로 사용할 사각형 정점버퍼와 인덱스 버퍼를 생성합니다(Red2D는 사각형을 기준으로 디스플레이 객체를 생성합니다)</p> 
	 * Last update - Sep 11, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0  
	 */
	public class Red_BufferData
	{
		/**
		 * vertextBuffer 
		 */		
		private var _vertexbuffer:VertexBuffer3D;
		
		/**
		 * indexBuffer 
		 */		
		private var _indexBuffer:IndexBuffer3D;
	
		/**
		 * 생성자 
		 * @param $context3d
		 * 
		 */		
		public function Red_BufferData( $context3d:Context3D)
		{
			setBuffers( $context3d )
		}
		
		/**
		 * _vertexbuffer와 _indexBuffer를 설정합니다.
		 * @param $context3d
		 * 
		 */		
		private  function setBuffers( $context3d:Context3D ):void
		{
			var scale:Number = 0.5	
			_vertexbuffer  = $context3d.createVertexBuffer(4, 5); //x, y, z
			_vertexbuffer.uploadFromVector(Vector.<Number>
				([
					-scale ,  scale , 	0,		0 ,	1,     	
					-scale , -scale , 	0,		0 ,	0,			
					scale , -scale , 	0,		1 ,	0,			
					scale ,  scale , 	0,		1 ,	1 	
				]), 0, 4);			
			
			
			_indexBuffer = $context3d.createIndexBuffer(6);
			_indexBuffer.uploadFromVector(Vector.<uint>([0, 1, 2, 0, 2, 3]), 0, 6);
			
			$context3d.setVertexBufferAt(0, _vertexbuffer, 0, Context3DVertexBufferFormat.FLOAT_3); //xyz		
			$context3d.setVertexBufferAt(1, _vertexbuffer, 3, Context3DVertexBufferFormat.FLOAT_2); //uv 
		}

		/**
		 * indexBuffer를 반환합니다.
		 */
		public function get indexBuffer():IndexBuffer3D
		{
			return _indexBuffer;
		}

	}
}

