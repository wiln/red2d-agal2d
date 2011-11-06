package red2D_Particle.base
{
	import flash.display.BitmapData;
	
	import red2D.material.BitmapMaterial;
	
	/** 
	 * <p>기본 입자</p>
	 * <p>Last update - Oct 16, 2011</p>
	 * @author 백선기(seon ki, paik) / http://redcamel-studio.tistory.com
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Particle extends Particle_base
	{
		public function Particle($bitmpData:BitmapData, $x:Number=0, $y:Number=0)
		{
			super($bitmpData, $x, $y);
			if($bitmpData == null){
				throw new Error("입자를 표현할 기본 비트맵데이터를 등록해주세요")
			}
			material = new BitmapMaterial($bitmpData)		
		}
	}
}

