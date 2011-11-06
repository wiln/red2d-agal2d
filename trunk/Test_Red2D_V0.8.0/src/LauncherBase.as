package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.hires.debug.Stats;
	
	/** 
	 * LauncherBase/ Last update - Oct 3, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class LauncherBase extends Sprite
	{
		private var stats:Stats;
		public function LauncherBase()
		{
			stats = new Stats()
			addChild(stats)

			stage.addEventListener(Event.RESIZE, HD_reLocationInfoTitle)
		}
		
		protected function HD_reLocationInfoTitle(event:Event=null):void
		{
			stats.x = stage.stageWidth - stats.width
			stats.y = stage.stageHeight - stats.height-100
		}
	}
}

