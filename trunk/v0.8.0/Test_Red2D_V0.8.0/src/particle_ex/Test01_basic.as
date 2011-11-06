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
	public class Test01_basic extends Red_Scene
	{
		[Embed( source = "../resource/particle/base.png" )]
		private var MapTest:Class;

		private var _emitter:ParticleEmitter;
		public function Test01_basic()
		{
			super();
		}		

		public override function setDesign():void{			
			_emitter = new ParticleEmitter(new MapTest().bitmapData, Red_BlendMode.ADD)
			addChild(_emitter)
			
			_emitter.x = stage.stageWidth/2
			_emitter.y = stage.stageHeight/2		
			
		}
		
		public override function update():void
		{			
			_emitter.update()
		}
	}
}

