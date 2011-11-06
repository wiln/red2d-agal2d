package filter_ex
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.filter.fragmentBasic.LightLevelFilter;
	import red2D.filter.fragmentUV.UV_ZoomFilter;
	import red2D.material.BitmapMaterial;
	import red2D.system.Red_Scene;
	
	/** 
	 * <p>멀티필터 적용예제</p>
	 * <p>Last update - Oct 23, 2011</p>
	 * @author 백선기(seon ki, paik) / http://redcamel-studio.tistory.com
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test02_MultiFilter extends Red_Scene
	{
		[Embed( source = "./resource/img.jpg" )]
		private var MapTest:Class;
		private var _target:Red_Sprite;

		public function Test02_MultiFilter()
		{
			//TODO 예제정리필요
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void{
			setInfo()
			
			var testMaterial:BitmapMaterial = new BitmapMaterial(new MapTest().bitmapData)
			_target = new Red_Sprite(1920,1200,stage.stageWidth/2,stage.stageHeight/2)
			_target.material = testMaterial
			addChild(_target)
			
			//순서를 바꾸셔도 정상적용됩니다.
			// fragmentColor기반의 필터는 순차 중복적용이 가능합니다.
			// UV기반 필터는 fragmentColor보다 무조건 우선적으로 적용됩니다.(Red2D에서 체크합니다.)
			_target.filters = [new LightLevelFilter,new UV_ZoomFilter(0.5,0.5,0.3)]
		}
		
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{
		}	

		/**
		 * 정보타이틀 출력 
		 * 
		 */		
		protected function setInfo():void{			
			var infoTitle:TextField = new TextField
			stage.addChild(infoTitle)				
			infoTitle.x=infoTitle.y=10			
			infoTitle.text = "Red2D "
			infoTitle.textColor=0x777777
			infoTitle.appendText("Filter Test02_MultiFilter")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/")			
			infoTitle.appendText("\nRed2D의 멀티필터 적용 예제입니다.")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000			
		}
	}
}

