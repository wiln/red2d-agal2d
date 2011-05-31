package Red2D.display.base2D
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix3D;
	
	/**  
	 * Red_Base2D의 기본이되는 속성들을 한다.
	 * <p></p>
	 * 현재 z축관련과 rotaion3D를 구현하고 있지 않습니다. z축이 필요해 질것 같기는 합니다만..
	 * 지금 이것만으로도 힘듬 -_-
	 * <p></p>Last update - May 31, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 * 
	 */  
	public class Red_Display_BaseProperty
	{
		/*********************************************************************************/
		/** 변수선언 **/
		/*********************************************************************************/
		// 2D객체의 기본이 되는 속성들을 구성합니다.
		
		/** TODO : 마우스이벤트 개념 구축하기..**/
		public var mouseEnabled:Boolean = true;
		
		private var _stage:Stage;
		private var _width:Number = 100
		private var _height:Number = 100
		private var _rotation:Number = 0
		private var _x:Number = 0
		private var _y:Number = 0
		private var _scaleX:Number = 1
		private var _scaleY:Number = 1
		
		/** TODO : 3d 속성값추가..**/
			
			
		/** AGAL관련속성  **/	
		private var _matrix3D:Matrix3D = new Matrix3D;
		
		private var _context3D:Context3D;
		
		private var _vertexBuffer3D:VertexBuffer3D;
		private var _indexBuffer3D:IndexBuffer3D;
		
		private var _program3D:Program3D;
		private var _vertexProgram:AGALMiniAssembler;
		private var _fragmentProgram:AGALMiniAssembler;
		

		
		/*********************************************************************************/
		/** get / set 매서드선언   **/
		/*********************************************************************************/

		/**
		 * matrix3D 
		 * @return 
		 * 
		 */
		public function get matrix3D():Matrix3D
		{
			return _matrix3D;
		}

		/**
		 * matrix3D 
		 * @param value
		 * 
		 */
		public function set matrix3D(value:Matrix3D):void
		{
			_matrix3D = value;
		}

		/**
		 * fragment를 처리 할 Program 
		 * @return 
		 * 
		 */
		public function get fragmentProgram():AGALMiniAssembler
		{
			return _fragmentProgram;
		}

		/**
		 * fragment를 처리할 Program  
		 * @param value
		 */
		public function set fragmentProgram(value:AGALMiniAssembler):void
		{
			_fragmentProgram = value;
		}

		/**
		 * vertext를 처리할 Program 
		 * @return 
		 * 
		 */
		public function get vertexProgram():AGALMiniAssembler
		{
			return _vertexProgram;
		}

		/**
		 * vertext를 처리할 Program 
		 * @param value
		 */
		public function set vertexProgram(value:AGALMiniAssembler):void
		{
			_vertexProgram = value;
		}

		/**
		 * vertexProgram과 fragmentProgram을 처리하는 program3D 
		 * @return 
		 * 
		 */
		public function get program3D():Program3D
		{
			return _program3D;
		}

		/**
		 * vertexProgram과 fragmentProgram을 처리하는 program3D 
		 * @param value
		 */
		public function set program3D(value:Program3D):void
		{
			_program3D = value;
		}

		/**
		 * indexBuffer3D 
		 * @return 
		 * 
		 */		
		public function get indexBuffer3D():IndexBuffer3D
		{
			return _indexBuffer3D;
		}

		/**
		 * indexBuffer3D 
		 * @param value
		 * 
		 */
		public function set indexBuffer3D(value:IndexBuffer3D):void
		{
			_indexBuffer3D = value;
		}

		/**
		 * vertexBuffer3D 
		 * @return 
		 * 
		 */
		public function get vertexBuffer3D():VertexBuffer3D
		{
			return _vertexBuffer3D;
		}

		/**
		 * vertexBuffer3D 
		 * @param value
		 * 
		 */
		public function set vertexBuffer3D(value:VertexBuffer3D):void
		{
			_vertexBuffer3D = value;
		}

		/**
		 * context3d 
		 * @return 
		 * 
		 */
		public function get context3d():Context3D
		{
			return _context3D;
		}

		/**
		 * context3d
		 * @param value
		 * 
		 */		
		public function set context3d(value:Context3D):void
		{
			_context3D = value;
		}

		/**
		 * 기본 stage 
		 */
		public function get stage():Stage
		{
			return _stage;
		}

		/**
		 * 기본 stage
		 * @param value
		 * 
		 */
		public function set stage(value:Stage):void
		{
			_stage = value;
		}

		/**
		 * 스케일 Y 
		 * @return 
		 * 
		 */		
		public function get scaleY():Number
		{
			return _scaleY;
		}
		
		/**
		 * 스케일 Y 
		 * @param value
		 * 
		 */		
		public function set scaleY(value:Number):void
		{
			_scaleY = value;
		}
		
		/**
		 * 스케일 X  
		 * @return 
		 * 
		 */		
		public function get scaleX():Number
		{
			return _scaleX;
		}
		
		/**
		 * 스케일 X 
		 * @param value
		 * 
		 */		
		public function set scaleX(value:Number):void
		{
			_scaleX = value;
		}
		
		/**
		 * Y 
		 * @return 
		 * 
		 */		
		public function get y():Number
		{
			return _y;
		}
		
		/**
		 * Y  
		 * @param value
		 * 
		 */		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		/**
		 * X 
		 * @return 
		 * 
		 */		
		public function get x():Number
		{
			return _x;
		}
		
		/**
		 * X  
		 * @param value
		 * 
		 */		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		/**
		 * rotation 
		 * @return 
		 * 
		 */		
		public function get rotation():Number
		{
			return _rotation;
		}
		
		/**
		 * rotation  
		 * @param value
		 * 
		 */		
		public function set rotation(value:Number):void
		{
			_rotation = value;
		}
		
		/**
		 * height 
		 * @return 
		 * 
		 */		
		public function get height():Number
		{
			return _height;
		}
		
		/**
		 * height  
		 * @param value
		 * 
		 */		
		public function set height(value:Number):void
		{
			_height = value;
		}
		
		/**
		 * width 
		 * @return 
		 * 
		 */		
		public function get width():Number
		{
			return _width;
		}
		
		/**
		 * width  
		 * @param value
		 * 
		 */		
		public function set width(value:Number):void
		{
			_width = value;
		}
	}
}