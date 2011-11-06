package red2D_Particle.base
{
	import flash.display.BitmapData;
	
	import red2D.display.Red_Sprite;
	
	/** 
	 * <p>기본입자속성</p>
	 * <p>Last update - Oct 15, 2011</p>
	 * @author 백선기(seon ki, paik) / http://redcamel-studio.tistory.com
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Particle_base extends Red_Sprite
	{
		
		/********************************************************************************/
		/** 기타 기본속성  **/
		/********************************************************************************/	
		
		/**
		 * 파티클 기본이동속도 
		 */		
		public var moveSpeed:Number
		
		/**
		 * 입자의 기본생성각도 
		 */		
		public var angle:Number
		
		
		/********************************************************************************/
		/** 생존주기관련  **/
		/********************************************************************************/	
		
		/**
		 * 생존주기 
		 */		
		public var lifeTime:Number
		/**
		 * 생성시기 
		 */		
		public var birthTime:Number
		
		/********************************************************************************/
		/** 스케일 관련 변수 **/
		/********************************************************************************/	

		/**
		 * 최종 스케일
		 */		
		public var lastScale:Number
		
		/**
		 * 스케일 변화 속도 
		 */			
		public var speedScale:Number
		
		/********************************************************************************/
		/** 알파값 관련 변수 **/
		/********************************************************************************/	
		
		/**
		 * 최종 알파값 
		 */		
		public var lastAlpha:Number
		
		/**
		 * 알파값 변화속도 
		 */		
		public var speedAlpha:Number
		
		/********************************************************************************/
		/** 회전값 관련 변수 **/
		/********************************************************************************/	
		
		/**
		 * 최종 회전값 
		 */		
		public var lastRotation:Number
		
		/**
		 * 회전값 변화속도 
		 */		
		public var speedRotation:Number
		
		/********************************************************************************/
		/** wave 관련 변수 **/
		/********************************************************************************/			
		
		/**
		 * particle_waveRotation
		 */		
		public var waveRotation:Number=0
		
		/**
		 * particle_waveAmplitude
		 */			
		public var waveAmplitude:Number=0
		
		/**
		 * particle_waveSpeed
		 */			
		public var waveSpeed:Number=0.01
			
		/**
		 * 생성자 
		 * @param $bitmpData
		 * @param $x
		 * @param $y
		 * 
		 */		
		public function Particle_base($bitmpData:BitmapData,$x:Number=0, $y:Number=0)
		{
			super($bitmpData.width, $bitmpData.height, $x, $y);	
		}	
	}
}

