package red2D_Particle
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import red2D.display.Red_Sprite;
	import red2D.display.base.Red_BlendMode;
	
	import red2D_Particle.base.AEmitter;
	import red2D_Particle.base.Particle;
	
	/** 
	 * <p>입자 방출기</p>
	 * <p>Last update - Oct 16, 2011</p>
	 * @author 백선기(seon ki, paik) / http://redcamel-studio.tistory.com
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class ParticleEmitter extends AEmitter
	{
		/**
		 * 현재 시스템시간 
		 */
		private var _currentTime:int;
		/**
		 * 입자의 시점에서의 시간 
		 */
		private var _currnetParticleTime:int;
	//	private var _firstTimer:int;
	//	private var _prevCheckTime:int;	
		
		/**
		 * 생성자 
		 * @param $particleBitmap
		 * 
		 */		
		public function ParticleEmitter( $particleBitmap:BitmapData, $blendMode:String = Red_BlendMode.ADD )
		{		
			trace("Red2D_Particle은 현재 프로토타입버전입니다.")
			blendMode = $blendMode
			_bitmapData = $particleBitmap
			_particleContainer = new Red_Sprite(0,0,0,0)
			addChild(_particleContainer)	
			_firstTimer=getTimer()
		}	
		
		/**
		 * 입자 추가 매서드
		 * 
		 */		
		protected override function addParticle():void
		{
			if(_particleContainer.childNum>maxParticleNum){
				for(var i:Number=0; i<_particleContainer.childNum-maxParticleNum;++i){
					_particleContainer.removeChildAt(0)
				}				
			}
			
			var particle:Particle = new Particle(_bitmapData,emitterAreaWidth*Math.random()-emitterAreaWidth/2, emitterAreaHeight*Math.random()-emitterAreaHeight/2)
			particle.blendMode = blendMode
			// 기본값입력
			initParticle(particle)
			
			// 파티클컨테이너에 등록
			_particleContainer.addChild(particle)
		}
		
		/**
		 * 입자 속성 초기화 
		 * @param particle
		 * 
		 */		
		private function initParticle($particle:Particle):void
		{
			//생성시간기록을 통해 주기설정확보
			$particle.birthTime = getTimer()
			$particle.lifeTime = particle_liftTime
				
		
			if(particle_randomAngle){
				var angle:Number = Math.random()*(particle_randomAngleMax- particle_randomAngleMin)+particle_randomAngleMin
				$particle.angle = angle
			}else{
				$particle.angle =particle_angle
			}	
			
			// 기본이동속도
			$particle.moveSpeed= particle_moveSpeed
			
			// scale
			$particle.scaleX = $particle.scaleY =  particle_firstScale
			$particle.lastScale = particle_lastScale
			$particle.speedScale = particle_speedScale
			
			// alpha
			$particle.alpha = particle_firstAlpha
			$particle.lastAlpha = particle_lastAlpha
			$particle.speedAlpha = particle_speedAlpha
				
			// rotation
			$particle.rotation = particle_firstRotation
			$particle.lastRotation = particle_lastRotation
			$particle.speedRotation = particle_speedRotation
				
			$particle.waveRotation = particle_waveRotation
			$particle.waveAmplitude = particle_waveAmplitude
			$particle.waveSpeed = particle_waveSpeed
			
		}
		
		/**********************************************************************
		 * 렌더링 
		 **********************************************************************/		
		
		/**
		 * 입자시스템 업데이트 
		 * @param $event
		 * 
		 */		
		public function update():void
		{
		
			// 렌더링시 타임기준점을 잡는다.
			var _checkTime:int =  int((getTimer()-_firstTimer)/intervalTime%60)			
			
			if(_prevCheckTime != _checkTime){
				addParticle()
				_prevCheckTime =  _checkTime		
			}		
			
			_currentTime = getTimer()	
			
			var list:Array = _particleContainer.children
			var target:Particle 
			
			for (var i:int=0; i<_particleContainer.childNum; ++i){
				target = list[i]
				
				// 라이프 시간을 체크해서 삭제
				_currnetParticleTime = _currentTime-target.birthTime				
				if( _currnetParticleTime > target.lifeTime*1000 ){
					_particleContainer.removeChild(target)
					target=null
				} else {					
					// 변화되는 부분을 클래스 매서드로 빼서 다양하게 활용
					applyProperty( target )
					
					var moveDistance:Number=((_currentTime-target.birthTime) / 1000) * target.moveSpeed
					
					var dx:Number 
					var dy:Number 
					// 기본 생성 Angle & 이동속도반영
					dx = Math.cos( target.angle * Math.PI/180 ) * moveDistance;
					dy = Math.sin( target.angle * Math.PI/180 ) * moveDistance;
					
					if(particle_waveDirection == WaveDirection.HORIZON){
						dx += Math.cos( (target.waveRotation)*Math.PI/180  ) * target.waveAmplitude;
					}else{
						dy += Math.cos( (target.waveRotation)*Math.PI/180  ) * target.waveAmplitude;
					}
					
					
					target.x += dx
					target.y += dy+gravity;	
				}									
			}
		}
		
		/**
		 * 속성값 적용 
		 * @param $target
		 * 
		 */		
		protected function applyProperty( $target:Particle ):void{
			// 알파적용
			$target.alpha += ($target.lastAlpha-$target.alpha)*$target.speedAlpha*0.2
			
			// 스케일 적용
			$target.scaleX = $target.scaleY += ($target.lastScale-$target.scaleY)*$target.speedScale*0.1
				
			// 스케일 적용
			$target.rotation += ($target.lastRotation-$target.rotation)*$target.speedRotation*0.1
				
			// 웨이브 적용
			$target.waveRotation = $target.waveRotation+$target.waveSpeed
		}
		
		
		/**
		 * emitterProperty설정 
		 * @param $targetEmitter
		 * 
		 */		
		public function setProperty( $propertyObject:Object):void
		{
			
			var obj:Object = $propertyObject			
			
			for (var property:String in obj) {
			//	trace (property,  obj[property]);   //property값이 속성명
				this[property]= obj[property]
			}
		}	

	}
}

