package particle_ex
{
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
	public class Test06_DemoView4 extends Red_Scene
	{
		[Embed( source = "../resource/particle/base3.png" )]
		private var MapTest:Class;
		
		[Embed( source = "../resource/particle/base2.png" )]
		private var MapTest2:Class;
		
		[Embed( source = "../resource/particle/bg04.jpg" )]
		private var Bg:Class;

		private var _emitter:ParticleEmitter;
		private var _bgMap:BitmapMaterial;
		private var _bg:Red_Sprite;
		private var _emitter2:ParticleEmitter;
		private var _emitter3:ParticleEmitter;
		public function Test06_DemoView4()
		{
			super();
		}		

		public override function setDesign():void{	
			_bgMap =  new BitmapMaterial(new Bg().bitmapData)
			_bg = new  Red_Sprite(1680,764,stage.stageWidth/2,764/2)
			_bg.material = _bgMap
			addChild(_bg)
			
			_emitter = new ParticleEmitter(new MapTest().bitmapData, Red_BlendMode.NORMAL)
			addChild(_emitter)
			
			var obj:Object = new Object();
			obj.particle_liftTime='2.67'
			obj.particle_angle='296.47'
			obj.maxParticleNum='40'
			obj.particle_moveSpeed='11.09'
			obj.emitterAreaWidth='20'
			obj.emitterAreaHeight='20'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='-255.39000000000001'
			obj.particle_randomAngleMax='-125.03'
			obj.particle_firstScale='0.5'
			obj.particle_lastScale='8'
			obj.particle_speedScale='0.07'
			obj.particle_firstAlpha='1'
			obj.particle_lastAlpha='0'
			obj.particle_speedAlpha='0.1'
			obj.particle_firstRotation='1'
			obj.particle_lastRotation='0'
			obj.particle_speedRotation='0.01'
			obj.particle_waveRotation='143.20000000000002'
			obj.particle_waveAmplitude='2.83'
			obj.particle_waveSpeed='6.28'
			obj.particle_randomAngle=true
			obj.gravity='0'
			
			_emitter.setProperty(obj)

						
			_emitter.x = 600
			_emitter.y=600
				
				
				
			_emitter2 = new ParticleEmitter(new MapTest2().bitmapData, Red_BlendMode.ADD)
			addChild(_emitter2)
			
			obj= new Object();
			obj.particle_liftTime='2.67'
			obj.particle_angle='296.47'
			obj.maxParticleNum='40'
			obj.particle_moveSpeed='11.09'
			obj.emitterAreaWidth='40'
			obj.emitterAreaHeight='50'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='-255.39000000000001'
			obj.particle_randomAngleMax='-125.03'
			obj.particle_firstScale='3'
			obj.particle_lastScale='8'
			obj.particle_speedScale='0.07'
			obj.particle_firstAlpha='0'
			obj.particle_lastAlpha='0.1'
			obj.particle_speedAlpha='0.1'
			obj.particle_firstRotation='1'
			obj.particle_lastRotation='0'
			obj.particle_speedRotation='0.01'
			obj.particle_waveRotation='143.20000000000002'
			obj.particle_waveAmplitude='2.83'
			obj.particle_waveSpeed='6.28'
			obj.particle_randomAngle=true
			obj.gravity='0'
			
			_emitter2.setProperty(obj)

			_emitter2.x = 600
			_emitter2.y=600
	
				
			_emitter3 = new ParticleEmitter(new MapTest2().bitmapData, Red_BlendMode.ADD)
			addChild(_emitter3)
			
			obj= new Object();
			obj.particle_liftTime='2.67'
			obj.particle_angle='296.47'
			obj.maxParticleNum='40'
			obj.particle_moveSpeed='11.09'
			obj.emitterAreaWidth='100'
			obj.emitterAreaHeight='400'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='-240'
			obj.particle_randomAngleMax='-160'
			obj.particle_firstScale='0'
			obj.particle_lastScale='10'
			obj.particle_speedScale='0.2'
			obj.particle_firstAlpha='1'
			obj.particle_lastAlpha='0'
			obj.particle_speedAlpha='0.2'
			obj.particle_firstRotation='1'
			obj.particle_lastRotation='0'
			obj.particle_speedRotation='0.01'
			obj.particle_waveRotation='143.20000000000002'
			obj.particle_waveAmplitude='2.83'
			obj.particle_waveSpeed='6.28'
			obj.particle_randomAngle=true
			obj.gravity='0'
			
			_emitter3.setProperty(obj)

			_emitter3.x =1730
			_emitter3.y=200
			

		}
		
	
		
		/**
		 * 업데이트 사항 기술 
		 * 
		 */		
		public override function update():void
		{			
			_emitter.update()
			_emitter2.update()
			_emitter3.update()
		}
	}
}

