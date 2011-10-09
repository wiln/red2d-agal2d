package game
{
	import flash.display.Sprite;
	
	import red2D.material.BitmapMaterial;
	import red2D.material.ColorMaterial;

	/** 
	 * Bullet/ Last update - Oct 2, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Missile extends Unit
	{
		[Embed( source = "./resource/game/missile.png" )]
		private var Missiles:Class;
		
		public function Missile($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			super($width, $height, $x, $y);
			material = new BitmapMaterial(new Missiles().bitmapData,16,16)
		}
		
		public override function update():void
		{
			x+=0
			y+=-5
			

		}		
	}
}

