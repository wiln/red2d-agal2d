package game
{
	import com.greensock.TweenLite;
	import com.greensock.TweenNano;
	import com.greensock.easing.Quint;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	
	/** 
	 * Menu/ Last update - Oct 5, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Menu extends Red_Sprite
	{
		[Embed( source = "./resource/game/intro.png" )]
		private var Bg:Class;
		
		[Embed( source = "./resource/game/menu_title.png" )]
		private var BgTitle:Class;
		
		private var _bg:Red_Sprite;
		private var _bgMaterial:BitmapMaterial;
		private var _bgTitleMaterial:BitmapMaterial;
		private var _bgTitle:Red_Sprite;
		
		public function Menu($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			super($width, $height, $x, $y);
			setDesign()
		}
		
		private function setDesign():void
		{
		
			_bgMaterial = new BitmapMaterial(new Bg().bitmapData)
			_bg = new Red_Sprite(1024,512,0,0)
			_bg.material = _bgMaterial
			addChild(_bg)
			_bg.y = 0
				
			_bgTitleMaterial = new BitmapMaterial(new BgTitle().bitmapData)
			_bgTitle = new Red_Sprite(512,64,30,55)
			_bgTitle.material = _bgTitleMaterial
			_bgTitle.alpha=0.5
			_bgTitle.mouseEnable=true
			addChild(_bgTitle)
			
			_bgTitle.addEventListener(MouseEvent.MOUSE_OVER, HD_Over)
			_bgTitle.addEventListener(MouseEvent.MOUSE_OUT, HD_Out)
			_bgTitle.addEventListener(MouseEvent.MOUSE_DOWN, HD_Down)
		
		}
		
		protected function HD_Down(event:Event):void
		{
			dispatchEvent(new Event("Start"))
		}
		
		protected function HD_Out(event:MouseEvent):void
		{
			TweenLite.to(_bgTitle,0.5,{alpha:0.5, ease:Quint.easeOut})
		}
		
		protected function HD_Over(event:MouseEvent):void
		{
			TweenLite.to(_bgTitle,0.5,{alpha:1, ease:Quint.easeOut})
		}
		
		public function showIntro():void{
			TweenLite.to(this,2,{y:300,ease:Quint.easeInOut })
		}
		
		public function outOfIntro():void
		{
			TweenLite.to(this,1,{y:-600,ease:Quint.easeInOut })
		}
	}
}

