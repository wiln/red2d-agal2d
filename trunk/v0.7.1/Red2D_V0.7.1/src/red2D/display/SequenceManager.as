package red2D.display
{
	import red2D.material.SequenceMaterial;

	/** 
	 * <p>SequenceMaterial을 통합관리하는 매니저</p>
	 * <p>Red_SequenceSprite</p>
	 * <p>Last update - Sep 21, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class SequenceManager
	{
		/**
		 * 등록된 시퀀스 재질 리스트들 
		 */		
		private var _sequenceMaterialList:Vector.<SID> = new Vector.<SID>

		/**
		 * 생성자 
		 * 
		 */			
		public function SequenceManager()
		{
		}
		
		/**
		 * 시퀀스재질을 등록 
		 * @param $id - 매니저에 재질을 등록할때 입력할 고유 ID
		 * @param $Sequence - 등록할 SequenceMaterial
		 * 
		 */		
		public function addSequenceMaterial( $id:String, $Sequence:SequenceMaterial ):void{
			_sequenceMaterialList.push(new SID( $id, $Sequence ))
		}
		
		/**
		 * id값과 일치하는 SequenceMaterial 반환 
		 * @param $id - 검색할 ID값
		 * @return 
		 * 
		 */		
		public function getSequenceMaterial( $id:String ):SequenceMaterial{
			var returnMaterial:SequenceMaterial
			for each (var sid:SID in _sequenceMaterialList) 
			{
				if( sid.name==$id ){
					returnMaterial= sid.Sequence
				}
			}
			return returnMaterial;
		}		
		
		/**
		 * ID값과 일치하는 SequenceMaterial의 주기를 반환 
		 * @param _currentId
		 * @return 
		 * 
		 */		
		public function getSecond(_currentId:String):int
		{

			return getSequenceMaterial(_currentId).second
		}
		
		/**
		 * ID값과 일치하는 SequenceMaterial를 구성하는 이미지갯수 반환
		 * @param _currentId
		 * @return 
		 * 
		 */	
		public function getCount(_currentId:String):int
		{
			return getSequenceMaterial(_currentId).count
		}
	}
}
import red2D.material.SequenceMaterial;
/**
 * SID생성 
 * @author redcamel
 * 
 */
class SID
{
	public  var name:String
	public  var Sequence:SequenceMaterial
	public function SID( $id:String, $Sequence:SequenceMaterial )
	{
		name = $id
		Sequence = $Sequence
	}
}
