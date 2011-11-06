package filter_ex
{
	/** 
	 * by Paik seonki / redcamel
	 * webseon@hanmail.net	 
	 */
	import com.greensock.TweenNano;
	import com.greensock.easing.Quint;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.filter.fragmentBasic.InvertFilter;
	import red2D.filter.fragmentBasic.LightLevelFilter;
	import red2D.filter.fragmentBasic.NeonSign;
	import red2D.material.BitmapMaterial;
	import red2D.material.MaterialBase;
	import red2D.material.MovieClipMaterial;
	import red2D.system.Red2D;
	import red2D.system.Red_Scene;
	

	/**
	 * Test05_FilterStressTest
	 * <p>Last update - Oct 29, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */	
	public class Test05_FilterStressTest extends Red_Scene
	{
		// 맵핑 테스트를 위한 비트맵
		[Embed( source = "./resource/flower.png" )]
		private var MapTest:Class;
		private var _maxNum:Number =500
		private var _testFilter:LightLevelFilter;
		
		public function Test05_FilterStressTest()
		{
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	
			setInfo()
			Red2D.backgroundColor=0xffffff
			var testMaterial:BitmapMaterial = new BitmapMaterial(new MapTest().bitmapData)
			
			for(var i:int=0; i<_maxNum; ++i){
				var test:Red_Sprite = new Red_Sprite(128,128,stage.stageWidth*Math.random(),stage.stageHeight*Math.random())
					
				test.material = testMaterial
				test.filters = [new NeonSign(Math.random(),Math.random(),Math.random())]
				addChild(test)
			}

			stage.addEventListener(MouseEvent.MOUSE_DOWN, HD_Down)
		}
		
		protected function HD_Down(event:MouseEvent):void
		{
			// 트윈라이트를 적용해보자			
			for(var i:Number=0; i<childNum; ++i){
				var scale:Number = Math.random()
	
				TweenNano.to(children[i],1,{
					x:Math.random()*stage.stageWidth,
					y:Math.random()*stage.stageHeight,
					alpha:Math.random(),
					ease:Quint.easeInOut })
				
			}
		}
		
		public override function update():void
		{
			for(var i:int=0; i<childNum; ++i){
				var target:Red_Sprite = children[i]
					target.rotation++
			}
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
			infoTitle.appendText("Test05_FilterStressTest")
			infoTitle.appendText("\n128*128 BimapMaterial")
			infoTitle.appendText("\n128*128 Red_Sprite * 500!!!!")
			infoTitle.appendText("\nEnterFrame All Object Rotation++")
			infoTitle.appendText("\nNeonSign Filter!!!")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
	}

}

