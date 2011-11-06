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
	public class Test05_DemoView3 extends Red_Scene
	{
		[Embed( source = "../resource/particle/base2.png" )]
		private var MapTest:Class;
		
		[Embed( source = "../resource/particle/bg03.jpg" )]
		private var Bg:Class;

		private var _emitter:ParticleEmitter;
		private var _bgMap:BitmapMaterial;
		private var _bg:Red_Sprite;
		private var _emitter2:ParticleEmitter;
		public function Test05_DemoView3()
		{
			super();
		}		

		public override function setDesign():void{	
			_bgMap =  new BitmapMaterial(new Bg().bitmapData)
			_bg = new Red_Sprite(1280,1024,stage.stageWidth/2,stage.stageHeight/2)
			_bg.material = _bgMap
			addChild(_bg)
			
			_emitter = new ParticleEmitter(new MapTest().bitmapData, Red_BlendMode.ADD)
			addChild(_emitter)
			
			var obj:Object = new Object();
			obj.particle_liftTime='7'
			obj.particle_angle='68.82000000000001'
			obj.maxParticleNum='100'
			obj.particle_moveSpeed='2'
			obj.emitterAreaWidth='900'
			obj.emitterAreaHeight='0'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='-242.68'
			obj.particle_randomAngleMax='-301.8'
			obj.particle_firstScale='12'
			obj.particle_lastScale='0.1'
			obj.particle_speedScale='0.07'
			obj.particle_firstAlpha='1'
			obj.particle_lastAlpha='0'
			obj.particle_speedAlpha='0.03'
			obj.particle_firstRotation='1'
			obj.particle_lastRotation='360'
			obj.particle_speedRotation='0.03'
			obj.particle_waveRotation='21.88'
			obj.particle_waveAmplitude='2.2600000000000002'
			obj.particle_waveSpeed='0.52'
			obj.particle_randomAngle=true
			obj.gravity='0'


			
			_emitter.setProperty(obj)
				
				
		
			_emitter.x = stage.stageWidth/2
			_emitter.y=-300
				
	
		}
		/**
		 * 업데이트 사항 기술 
		 * 
		 */		
		public override function update():void
		{			
			_emitter.update()
			
		}
	}
}

