package particle_ex
{
	import flash.events.Event;
	
	import red2D.display.Red_Sprite;
	import red2D.display.base.Red_BlendMode;
	import red2D.material.BitmapMaterial;
	import red2D.system.Red_Scene;
	
	import red2D_Particle.ParticleEmitter;
	
	/** 
	 * <p>Test01_basic</p>
	 * <p>Last update - Oct 17, 2011</p> 
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Test03_DemoView extends Red_Scene
	{
		[Embed( source = "../resource/particle/base.png" )]
		private var MapTest:Class;
		
		[Embed( source = "../resource/particle/bg01.jpg" )]
		private var Bg:Class;

		private var _emitter:ParticleEmitter;
		private var _bgMap:BitmapMaterial;
		private var _bg:Red_Sprite;
		private var _emitter2:ParticleEmitter;
		public function Test03_DemoView()
		{
			super();
		}		

		public override function setDesign():void{	
			_bgMap =  new BitmapMaterial(new Bg().bitmapData)
			_bg = new Red_Sprite(1022,598,1022/2,598/2)
			_bg.material = _bgMap
			addChild(_bg)
			
			_emitter = new ParticleEmitter(new MapTest().bitmapData, Red_BlendMode.ADD)
			addChild(_emitter)
			
			var obj:Object = new Object();
			obj.particle_liftTime='3.5'
			obj.particle_angle='0'
			obj.maxParticleNum='60'
			obj.particle_moveSpeed='7.3500000000000005'
			obj.emitterAreaWidth='0'
			obj.emitterAreaHeight='0'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='-94.45'
			obj.particle_randomAngleMax='0'
			obj.particle_firstScale='0'
			obj.particle_lastScale='4.46'
			obj.particle_speedScale='0.08'
			obj.particle_firstAlpha='1'
			obj.particle_lastAlpha='0'
			obj.particle_speedAlpha='0.4'
			obj.particle_firstRotation='0'
			obj.particle_lastRotation='0'
			obj.particle_speedRotation='0'
			obj.particle_waveRotation='37.69'
			obj.particle_waveAmplitude='1.1400000000000001'
			obj.particle_waveSpeed='6.8100000000000005'
			obj.particle_randomAngle=true
			obj.gravity='0'
			
			_emitter.setProperty(obj)
			_emitter.intervalTime=15
				
			_emitter2 = new ParticleEmitter(new MapTest().bitmapData, Red_BlendMode.ADD)
			addChild(_emitter2)
			
			obj= new Object();
			obj.particle_liftTime='2.67'
			obj.particle_angle='0'
			obj.maxParticleNum='34.69'
			obj.particle_moveSpeed='7.3500000000000005'
			obj.emitterAreaWidth='0'
			obj.emitterAreaHeight='0'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='-94.45'
			obj.particle_randomAngleMax='4.1'
			obj.particle_firstScale='0'
			obj.particle_lastScale='4.46'
			obj.particle_speedScale='0.09'
			obj.particle_firstAlpha='1'
			obj.particle_lastAlpha='0'
			obj.particle_speedAlpha='0.24'
			obj.particle_firstRotation='0'
			obj.particle_lastRotation='0'
			obj.particle_speedRotation='0'
			obj.particle_waveRotation='37.69'
			obj.particle_waveAmplitude='1.1400000000000001'
			obj.particle_waveSpeed='6.8100000000000005'
			obj.particle_randomAngle=true
			obj.gravity='0'
			_emitter2.setProperty(obj)
			
			_emitter.x = 190
			_emitter.y = 238
				
			_emitter2.x = 812
			_emitter2.y = 238
			_emitter2.intervalTime=30
			
			
		}
			
		/**
		 * 업데이트 사항 기술 
		 * 
		 */		
		public override function update():void
		{			
			_emitter.update()
			_emitter2.update()
		}
	}
}

