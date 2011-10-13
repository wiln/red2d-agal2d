package red2D.display
{
	import red2D.display.base.Red_InteractiveObject;
	
	/** 
	 * <p>기본 디스플레이 오브젝트</p>
	 * <p>Sprite와 같은 개념을 가진 Red2D의 기본 표시 목록을 구성하는 단위입니다, 그래픽을 표시할 수 있고 자식도 포함할 수 있는 표시 목록 노드입니다.</p>
	 * <p>Last update - Sep 19, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_Sprite extends Red_InteractiveObject
	{
		/**
		 * 생성자 ( width와 height를 0으로 설정하면 비어있는 컨테이너로 사용할 수 있습니다) 
		 * @param $width
		 * @param $height
		 * @param $x
		 * @param $y
		 * 
		 */		
		public function Red_Sprite($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			width= $width
			height=$height
			x=$x
			y=$y	
			InitBase()		
		}
	}
}

