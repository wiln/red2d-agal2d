package game_ex
{
	/** 
	 * KeyBoardState/ Last update - Sep 5, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class KeyBoardState
	{
		private  var _rightKey:Boolean = false;
		private  var _leftKey:Boolean  = false;
		private  var _downKey:Boolean  = false;
		private  var _upKey:Boolean  = false;
		private  var _space:Boolean  = false;
		
		public function KeyBoardState()
		{
			
		}

		public function get rightKey():Boolean
		{
			return _rightKey;
		}

		public function set rightKey(value:Boolean):void
		{
			_rightKey = value;
		}

		public function get leftKey():Boolean
		{
			return _leftKey;
		}

		public function set leftKey(value:Boolean):void
		{
			_leftKey = value;
		}

		public function get downKey():Boolean
		{
			return _downKey;
		}

		public function set downKey(value:Boolean):void
		{
			_downKey = value;
		}

		public function get upKey():Boolean
		{
			return _upKey;
		}

		public function set upKey(value:Boolean):void
		{
			_upKey = value;
		}

		public function get space():Boolean
		{
			return _space;
		}

		public function set space(value:Boolean):void
		{
			_space = value;
		}


	}
}

