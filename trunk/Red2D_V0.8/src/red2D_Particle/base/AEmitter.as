package red2D_Particle.base
{
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import red2D.display.Red_Sprite;
	
	import red2D_Particle.WaveDirection;
	
	/** 
	 * <p>입자방출기 추상크래스</p>
	 * <p>Last update - Oct 16, 2011</p>
	 * @author 백선기(seon ki, paik) / http://redcamel-studio.tistory.com
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class AEmitter extends Red_Sprite
	{
		protected var _particleContainer:Red_Sprite;	
		protected var _bitmapData:BitmapData;	
		
		/********************************************************************************/
		/** 입자방출기 환경변수 **/
		/********************************************************************************/	

		/**
		 * 입자 방출 영역 
		 */		
		protected var emitterArea:Rectangle = new Rectangle(0,0,0,0)		
		private var _emitterAreaWidth:Number = 0		
		private var _emitterAreaHeight:Number = 0
			
		/**
		 * 입자 최대갯수 
		 */			
		public var maxParticleNum:Number=100
			
		/**
		 * 중력 
		 */			
		public var gravity:Number=0

			
		private var _intervalTime:Number=100
		
		/**
		 * 입자방출 타이머 
		 */			
		private var timer:Timer;
		
		/********************************************************************************/
		/** 기타속성 관련  **/
		/********************************************************************************/	
		public var particle_moveSpeed:Number=3
		public var particle_angle:Number=3
			
		/********************************************************************************/
		/** angle 속성 관련  **/
		/********************************************************************************/	
		
		/**
		 * 생성 방향이 랜덤인가 설정 
		 */			
		public var particle_randomAngle:Boolean=true			
		
		/**
		 * 생성 방향이 랜덤일때 생성방향각도의 최소값 
		 */			
		public var particle_randomAngleMin:Number=0
		
		/**
		 * 생성 방향이 랜덤일때 생성방향각도의 최대값 
		 */
		public var particle_randomAngleMax:Number=360				
		
		/********************************************************************************/
		/** 생존 시간 관련  **/
		/********************************************************************************/	
		
		/**
		 * 생성 파티클 유지시간 
		 */		
		public var particle_liftTime:Number=3
		
		/********************************************************************************/
		/** Scale관련 변수 **/
		/********************************************************************************/	
		
		/**
		 * 초기 Scale
		 */			
		public var particle_firstScale:Number=0
		/**
		 * 최종 Scale
		 */			
		public var particle_lastScale:Number=3
		/**
		 * Scale 변화속도 
		 */			
		public var particle_speedScale:Number=0.01
		
		
		/********************************************************************************/
		/** Alpha 관련 변수 **/
		/********************************************************************************/	
		
		/**
		 * 초기 Alpha 
		 */			
		public var particle_firstAlpha:Number=1
		/**
		 * 최종 Alpha 
		 */			
		public var particle_lastAlpha:Number=0
		/**
		 * Alpha 변화속도 
		 */			
		public var particle_speedAlpha:Number=0.1
		
		/********************************************************************************/
		/** Rotation 관련 변수 **/
		/********************************************************************************/	
		
		/**
		 * 초기 Rotation
		 */			
		public var particle_firstRotation:Number=1
		/**
		 * 최종 Rotation
		 */			
		public var particle_lastRotation:Number=0
		/**
		 * Rotation 변화속도 
		 */			
		public var particle_speedRotation:Number=0.01
			
		
		/********************************************************************************/
		/** wave 관련 변수 **/
		/********************************************************************************/	
		
		/**
		 * particle_waveRotation
		 */		
		public var particle_waveRotation:Number=0
	
		/**
		 * particle_waveAmplitude
		 */			
		public var particle_waveAmplitude:Number=0
	
		/**
		 * particle_waveSpeed
		 */			
		public var particle_waveSpeed:Number=0.01
			
		/**
		 * particle_waveDirection
		 */
		public var particle_waveDirection:String = WaveDirection.VERTICAL
			
		/********************************************************************************/
		/** 매서드  **/
		/********************************************************************************/
				
		
		
		/**
		 * 입자 추가 매서드 
		 * 
		 */		
		protected function addParticle():void{
		}	

		/********************************************************************************/
		/** get / set  **/
		/********************************************************************************/
		
		
		/**
		 * 입자방출지역 가로지정 
		 */
		public function get emitterAreaWidth():Number
		{
			return _emitterAreaWidth;
		}
		
		/**
		 * @private
		 */
		public function set emitterAreaWidth(value:Number):void
		{
			emitterArea = new Rectangle(0,0,_emitterAreaWidth,_emitterAreaHeight)
			_emitterAreaWidth = value;
		}
		
		/**
		 * 입자방출지역 세로지정 
		 */
		public function get emitterAreaHeight():Number
		{
			return _emitterAreaHeight;
		}
		
		/**
		 * @private
		 */
		public function set emitterAreaHeight(value:Number):void
		{
			emitterArea = new Rectangle(0,0,_emitterAreaWidth,_emitterAreaHeight)
			_emitterAreaHeight = value;
		}

		/**
		 * 입자방출 시간간격 
		 */
		public function get intervalTime():Number
		{
			return _intervalTime;
		}

		/**
		 * @private
		 */
		public function set intervalTime(value:Number):void
		{
			_intervalTime = value;
		}

	}
}

