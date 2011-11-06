package game_ex
{
	import red2D.material.BitmapMaterial;

	/** 
	 * EnemyMissile/ Last update - Oct 4, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class EnemyMissile extends Unit
	{
		[Embed( source = "./resource/game/missile2.png" )]
		private var Missiles:Class;
		
		private var _tx:Number;
		private var _ty:Number;
		
		public function EnemyMissile($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			super($width, $height, $x, $y);
			_vx =  10*Math.random()-5
			_vy = 3
			material = new BitmapMaterial(new Missiles().bitmapData)
		}
		
		public override function update():void
		{

				
			x+= _vx
			y+= _vy		
		}		
	}
}

