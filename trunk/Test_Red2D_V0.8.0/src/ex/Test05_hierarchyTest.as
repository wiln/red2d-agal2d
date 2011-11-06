package ex
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.display.base.Red_InteractiveObject;
	import red2D.material.BitmapMaterial;
	import red2D.material.MaterialBase;
	import red2D.system.Red_Scene;
	
	/** 
	 * 하이라키구조 적용테스트
	 * Test05_TestDisplayContainer
	 * <p>Last update - Oct 22, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test05_hierarchyTest extends Red_Scene
	{
		
		[Embed( source = "./resource/flower.png" )]
		private var MapTest:Class;

		private var target:Red_InteractiveObject;		
		private var target2:Red_InteractiveObject;		
		private var target3:Red_InteractiveObject;

		
		
		public function Test05_hierarchyTest()
		{
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	
			//정보텍스트 출력
			setInfo()
			
			var testMaterial:MaterialBase = new BitmapMaterial(new MapTest().bitmapData)
			
			target = new Red_Sprite(128,128,stage.stageWidth*Math.random(),stage.stageHeight*Math.random())
			target.material =testMaterial				

			target2 = new Red_Sprite(100,100,64,64)
			target2.material =testMaterial

			target3 = new Red_Sprite(80,80,50,50)
			target3.material =testMaterial
			
			target3.alpha=0.5
			
			target.mouseEnable=true
			target2.mouseEnable=true
			target3.mouseEnable=true
			
			
			addChild(target)
			target.addChild(target2)
			target2.addChild(target3)
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,HD_Down)
				
			target.addEventListener(MouseEvent.MOUSE_OVER, HD_Over)
			target.addEventListener(MouseEvent.MOUSE_OUT, HD_Out)
			
			target2.addEventListener(MouseEvent.MOUSE_OVER, HD_Over)
			target2.addEventListener(MouseEvent.MOUSE_OUT, HD_Out)
				
			target3.addEventListener(MouseEvent.MOUSE_OVER, HD_Over)
			target3.addEventListener(MouseEvent.MOUSE_OUT, HD_Out)
				
				
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
		
		protected function HD_Out(event:Event):void
		{
			TweenMax.to(event.currentTarget,1,{scaleX:1 ,scaleY:1 ,alpha:1,ease:Quint.easeOut })
		}
		
		protected function HD_Over(event:Event):void
		{
			TweenMax.to(event.currentTarget,0.5,{alpha:0.5,ease:Quint.easeOut })
		}		
		
		public function HD_Down(event:MouseEvent=null):void
		{
			
			TweenMax.to(target,1,{
				rotation:Math.random()*360,
				x:Math.random()*stage.stageWidth,
				y:Math.random()*stage.stageHeight,
				ease:Quint.easeInOut })
			
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
			infoTitle.appendText("Test05_hierarchyTest")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.appendText("\nhttp://code.google.com/p/red2d-agal2d/\n")			
			infoTitle.appendText("\n기존의 하이라키구조 개념을 그대로 사용하실 수 있습니다.")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000			
		}
	}
}

