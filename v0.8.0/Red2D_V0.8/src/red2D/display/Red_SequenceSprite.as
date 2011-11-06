package red2D.display
{
	import flash.utils.getTimer;
	
	import red2D.display.base.Red_InteractiveObject;
	import red2D.material.ColorMaterial;
	
	/** 
	 * <p>SequenceMaterial을 재질로 이용하는 디스플레이객체</p>
	 * <p>Last update - Oct 06, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_SequenceSprite extends Red_InteractiveObject
	{
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
	
		
		/**
		 * 시퀀스 재질을 가져올 시퀀스 매니저 
		 */			
		private var _squenceManager:SequenceManager
		
		/**
		 * 현재 설정된 시퀀스 재질의 ID 
		 */		
		private var _currentId:String;
		
		/**
		 * 시퀀스전체가 플레이되는 주기 
		 */		
		private var _second:int
		/**
		 * 시퀀스를 구성하는 이미지갯수 
		 */		
		private var _count:int;
		
		
		private var _playNext:Boolean=true
		
		/********************************************************************************/
		/** 생성자 **/
		/********************************************************************************/	
		/**
		 * 생성자
		 * @param $width
		 * @param $height
		 * @param $x
		 * @param $y
		 * 
		 */		
		public function Red_SequenceSprite($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			width= $width
			height=$height
			x=$x
			y=$y

			InitBase()				
			_material = new ColorMaterial(0x00ffffff)
		}
		
		/**
		 * <p>Red_SequenceSprite에 SequenceMaterial을 지정한다.</p> 
		 * <p>시퀀스매니저등록된 시퀀스재질중 ID값과 일치하는 재질을 반환하여 재질로 설정합니다.</p>
		 * @param $id - 시퀀스매니저에서 가져올 재질의 고유 ID를 지정 
		 * @param $squenceManager - 시퀀스매니저를 가져옵니다
		 * 
		 */		
		public function setSequence(  $id:String, $squenceManager:SequenceManager):void{
			_currentId = $id
			_squenceManager = $squenceManager
				
			_material = _squenceManager.getSequenceMaterial(_currentId)
			_second = _squenceManager.getSecond(_currentId)
			_count = _squenceManager.getCount(_currentId)
			
			_prevCheckTime=0
			_firstTimer =getTimer()
				
			_playNext=true
		}
		
		/**
		 * 재질설정 
		 * 
		 */		
		protected override function setProgram( $filters:Array ):void
		{
			// 렌더링시 타임기준점을 잡는다.
			_checkTime =  int((getTimer()-_firstTimer)/_second%_count)			
				
			if(_prevCheckTime != _checkTime){
				_prevCheckTime =  _checkTime		
			}		
			
			_material.checkTime = _checkTime					
			_material.setProgram( $filters )
			_material.prevCheckTime = _prevCheckTime					
		}		
	}
}

