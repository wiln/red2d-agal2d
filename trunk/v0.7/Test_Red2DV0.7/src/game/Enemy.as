package game
{
	
	

	/** 
	 * Enemy/ Last update - Sep 23, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Enemy extends Unit
	{

		public function Enemy($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			super($width, $height, $x, $y);
	
		}
			
		
		public override  function update():void
		{
			vy = 2
			
			x+=_vx
			y+=_vy
			
			_vx *= 0.6
			_vy *= 0.6
			
		}		
		
		
	}
}

