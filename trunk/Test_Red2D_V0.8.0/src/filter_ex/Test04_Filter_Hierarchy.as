package filter_ex
{
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.filter.fragmentBasic.InvertFilter;
	import red2D.filter.fragmentBasic.LightLevelFilter;
	import red2D.filter.fragmentUV.UV_Wave;
	import red2D.material.BitmapMaterial;
	import red2D.material.MaterialBase;
	import red2D.system.Red_Scene;
	
	/** 
	 * <p>하이라키구조에 적용되는 필터</p>
	 * <p>Last update - Nov 4, 2011</p>
	 * @author 백선기(seon ki, paik) / http://redcamel-studio.tistory.com
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test04_Filter_Hierarchy extends Red_Scene
	{
		[Embed( source = "./resource/flower.png" )]
		private var MapTest:Class;
		
		private var target:Red_Sprite;		
		private var target2:Red_Sprite;		
		private var target3:Red_Sprite;
		


		
		public function Test04_Filter_Hierarchy()
		{
			//TODO 예제정리필요
			
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void{
			//정보텍스트 출력
			setInfo()
			
			var testMaterial:MaterialBase = new BitmapMaterial(new MapTest().bitmapData)
			
			target = new Red_Sprite(128,128,stage.stageWidth/2,stage.stageHeight/2)
			target.material =testMaterial				
			
			target2 = new Red_Sprite(100,100,64,64)
			target2.material =testMaterial
			
			target3 = new Red_Sprite(80,80,50,50)
			target3.material =testMaterial			

			addChild(target)
			target.addChild(target2)
			target2.addChild(target3)	
				
			applyFilter()
		}
		
		/**
		 * 필터를 적용해봅시다. 
		 * 
		 */		
		private function applyFilter():void
		{
			/////////////////////////////////////////////////////////////////
			// 하이라키 필터 연산은..CPU연산비용이 큰 작업입니다.
			// 하이라키 필터 연산을 할경우 가능한 중첩 필터 적용은 최소화 시키는 것이좋습니다.
			// 하이리키 구조체에 대한 필터연산 최적화는 다음 버전에 이루어질 예정입니다.
			////////////////////////////////////////////////////////////////
			
			
			////////////////////////////////////////////////////////////////
			// FRAGMENT_UV 타입의 필터는 하이라키 연산이 적용되지 않습니다.
			////////////////////////////////////////////////////////////////			
			
			target.filters = [new InvertFilter] 
			target3.filters = [new InvertFilter, new LightLevelFilter(1.5)] 
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
			infoTitle.appendText("Test04_Filter_Hierarchy")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/")			
			infoTitle.appendText("\nRed2D의 하이라키구조에 대한 필터 적용 예제입니다.")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000			
		}
	}
}

