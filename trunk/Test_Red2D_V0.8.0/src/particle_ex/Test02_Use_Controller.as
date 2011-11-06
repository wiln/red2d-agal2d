package particle_ex
{
	import flash.events.Event;
	
	import red2D.display.base.Red_BlendMode;
	import red2D.system.Red_Scene;
	
	import red2D_Particle.ParticleEmitter;
	
	/** 
	 * <p>Test01_basic</p>
	 * <p>Last update - Oct 17, 2011</p> 
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Test02_Use_Controller extends Red_Scene
	{
		[Embed( source = "../resource/particle/base.png" )]
		private var MapTest:Class;

		/**
		 * 입자방출기 
		 */		
		private var _emitter:ParticleEmitter;
		
		/**
		 * 속성설정을 쉽게 테스트해보기위한 컨트롤러 
		 */		
		private var _controller:Controller;
		
		public function Test02_Use_Controller()
		{
			super();
		}
		
	
		public override function setDesign():void{
			trace("성공")
			
			// 입자방출시 설치
			_emitter = new ParticleEmitter(new MapTest().bitmapData, Red_BlendMode.ADD)
			addChild(_emitter)
			
			// 컨트롤러에서 복사한 속성 오브젝트를 복사하여 속성 설정에 이용합니다.
			var obj:Object = new Object();
			obj.particle_liftTime='2.67'
			obj.particle_angle='90'
			obj.maxParticleNum='150'
			obj.particle_moveSpeed='5.48'
			obj.emitterAreaWidth='0'
			obj.emitterAreaHeight='0'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='70.73'
			obj.particle_randomAngleMax='114.25'
			obj.particle_firstScale='0'
			obj.particle_lastScale='4.01'
			obj.particle_speedScale='0.06'
			obj.particle_firstAlpha='1'
			obj.particle_lastAlpha='0'
			obj.particle_speedAlpha='0.09'
			obj.particle_firstRotation='62.57'
			obj.particle_lastRotation='0'
			obj.particle_speedRotation='0'
			obj.particle_waveRotation='0'
			obj.particle_waveAmplitude='0'
			obj.particle_waveSpeed='0'
			obj.particle_randomAngle=true
			obj.gravity='0'






		
			// 기본세팅 설정
			_emitter.setProperty(obj)
			
			_controller = new Controller(_emitter)			
			stage.addChild(_controller)
			
			_emitter.x = stage.stageWidth/2
			_emitter.y = stage.stageHeight/2
				
			

		}
		
	
		
		public override function update():void
		{
			
			_emitter.update()
		}
	}
}

