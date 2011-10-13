package ex
{
	/** 
	 * by Paik seonki / redcamel
	 * webseon@hanmail.net	 
	 */
	import com.bit101.components.ComboBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.Style;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	import red2D.material.ColorMaterial;
	import red2D.material.MovieClipMaterial;
	import red2D.system.Red_Scene;
	

	/**
	 * 04 Red2D_Sprite의 기본속성알아보기
	 * <p>Last update - Oct 3, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */	
	public class Test06_Red_Sprite_Property extends Red_Scene
	{
		// 맵핑 테스트를 위한 비트맵
		[Embed( source = "./resource/testImg3.jpg" )]
		private static var MapTest1:Class;

		
		
		private var testBox:Red_Sprite;

		private var huiSlider:HUISlider;
		private var huiSlider_X:HUISlider;
		private var huiSlider_Y:HUISlider;
		private var huiSlider_Rotation:HUISlider;
		private var huiSlider_Alpha:HUISlider;
		private var huiSlider_ScaleX:HUISlider;
		private var huiSlider_scaleY:HUISlider;
		private var huiSlider_Width:HUISlider;
		private var huiSlider_Height:HUISlider;
		private var huiSelecter:ComboBox;
		private var materialTitle:Label;
		private var guiTitle:Label;

		private var movieClipMaterial:MovieClipMaterial;

		public function Test06_Red_Sprite_Property()
		{

		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void{
					
			// 테스트정보출력
			setInfo()
			
			// * 테스트로 박스를 생성하고 크기와 위치를 설정해 보겠습니다.			
				testBox = new Red_Sprite(200,200,stage.stageWidth/2,stage.stageHeight/2)
				addChild(testBox)
						

				setSimpelGUI()
		}
		
		private function setSimpelGUI():void
		{	
			var gui:Sprite = new Sprite

			stage.addChild(gui)
			gui.x=10
			gui.y=10
			Style.setStyle(Style.DARK);
			
			

			huiSlider_X=new HUISlider(gui,0,40,"x",setValue)
			huiSlider_X.setSliderParams(0,stage.stageWidth,stage.stageWidth/2)
			
			huiSlider_Y=new HUISlider(gui,0,60,"y",setValue)
			huiSlider_Y.setSliderParams(0,stage.stageHeight,stage.stageHeight/2)
				
			huiSlider_Rotation=new HUISlider(gui,0,80,"rotation",setValue)
			huiSlider_Rotation.setSliderParams(0,360,0)
				
			huiSlider_Alpha=new HUISlider(gui,0,100,"alpha",setValue)
			huiSlider_Alpha.setSliderParams(0,1,1)
				
			huiSlider_ScaleX=new HUISlider(gui,0,120,"scaleX",setValue)
			huiSlider_ScaleX.setSliderParams(0,1,1)
				
			huiSlider_scaleY=new HUISlider(gui,0,140,"scaleY",setValue)
			huiSlider_scaleY.setSliderParams(0,1,1)
				
			huiSlider_Width=new HUISlider(gui,0,160,"width",setValue)
			huiSlider_Width.setSliderParams(0,200,200)
				
			huiSlider_Height=new HUISlider(gui,0,180,"height",setValue)
			huiSlider_Height.setSliderParams(0,200,200)
				
			materialTitle = new Label(gui,0,200,"Material Change")
			
			huiSelecter = new ComboBox(gui,0,220,"colorMaterial",["colorMaterial","bitmapMaterial","movieClipMaterial"])
			huiSelecter.width = 190
			huiSelecter.addEventListener(Event.SELECT, HD_combo);
			
			
		}
		
		protected function HD_combo(event:Event):void
		{
			trace(huiSelecter.selectedIndex)
			switch(huiSelecter.selectedIndex){
				case 0:
					testBox.material = new ColorMaterial()
					break
				case 1:
					testBox.material = new BitmapMaterial(new MapTest1().bitmapData)
					break
				case 2:
					movieClipMaterial = new MovieClipMaterial(new SWC_TestAir)
					movieClipMaterial.useAnimation=true
					testBox.material = movieClipMaterial					
					break				
			}		
		}
		
		private function setValue($e:Event=null):void
		{
			testBox[$e.currentTarget.label] = $e.currentTarget.value
			
		}
		private function onNumberChanged():void{
			
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
			infoTitle.appendText("Test06_Red_Sprite_Property")
			infoTitle.appendText("\nhttp://redcamel-studio.tistory.com")
			infoTitle.autoSize="left"
			infoTitle.background=true
			infoTitle.backgroundColor=0x000000
			
		}
	
	}
}