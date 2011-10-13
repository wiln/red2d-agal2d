package ex
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.Text;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import red2D.text.Red_TextField;
	import red2D.system.Red_Scene;
	
	/** 
	 * Test06_Red_TextField_Property
	 * <p>Last update - Oct 3, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Test07_Red_TextField_Property extends Red_Scene
	{
		private var red_TextField:Red_TextField;
		
		private var text_property:TextField;
		public function Test07_Red_TextField_Property()
		{
		}
		
		/**
		 * 실제 화면구성은 setDesign매서드를 오버라이드 하여 사용합니다.
		 * 
		 */		
		public override function setDesign():void{
			
			// * 테스트로 박스를 생성하고 크기와 위치를 설정해 보겠습니다.			
			setRed_TextField()
			
			
			setSimpelGUI()
		}
		
		private function setRed_TextField():void
		{
			red_TextField = new Red_TextField()	
			
			addChild(red_TextField)
			
			red_TextField.text="This is Red_TextField Test!!!\ntest multiline"
			
			red_TextField.x = stage.stageWidth/2
			red_TextField.y = stage.stageHeight/2
			red_TextField.align="right"
			red_TextField.mouseEnable = true
			red_TextField.addEventListener(MouseEvent.MOUSE_OVER, HD_Over)
			red_TextField.addEventListener(MouseEvent.MOUSE_OUT, HD_Out)
			
			//red_TextField.width=200
			
			//trace(red_TextField.width)
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, HD_down)
		}
		
		protected function HD_Out(event:Event):void
		{
			event.currentTarget.alpha=1
			
		}
		
		protected function HD_Over(event:Event):void
		{
			event.currentTarget.alpha=0.5
			
		}
		
		protected function HD_down(event:Event):void
		{
			//TweenLite.to(red_TextField,1,{ease:Quint.easeInOut,x:Math.random()*stage.stageWidth, y:Math.random()*stage.stageHeight})
		}
		
		private function setSimpelGUI():void
		{	
			var gui:Sprite = new Sprite
			
			stage.addChild(gui)
			gui.x=10
			gui.y=10
			Style.setStyle(Style.DARK);
			
			
			var guiTitle:Label = new Label(gui,0,0,"Red2D Test\nRed_TextFieldProperty ")				
			
			var huiSlider_X:HUISlider=new HUISlider(gui,0,40,"x",setValue)
			huiSlider_X.setSliderParams(5,stage.stageWidth-5,stage.stageWidth/2)
			
			
			var huiSlider_Y:HUISlider=new HUISlider(gui,0,60,"y",setValue)
			huiSlider_Y.setSliderParams(5,stage.stageHeight-5,stage.stageHeight/2)
			
			var huiSlider_Rotation:HUISlider=new HUISlider(gui,0,80,"rotation",setValue)
			huiSlider_Rotation.setSliderParams(0,360,0)
			
			var huiSlider_Alpha:HUISlider=new HUISlider(gui,0,100,"alpha",setValue)
			huiSlider_Alpha.setSliderParams(0,1,1)
			
			var huiSlider_ScaleX:HUISlider=new HUISlider(gui,0,120,"scaleX",setValue)
			huiSlider_ScaleX.setSliderParams(0,1,1)
			
			var huiSlider_scaleY:HUISlider=new HUISlider(gui,0,140,"scaleY",setValue)
			huiSlider_scaleY.setSliderParams(0,1,1)
			
			var widthHeight:Label = new Label(gui,0,160,"you do not use width, height property when using Red_Textfield.\nbecause of Mapsize, width and height property is not correct\nuse ScaleX and ScaleY!!")			
			
			var text_propertyBt:PushButton = new PushButton(gui,0,230,"text_propertyBt", HD_text_propertyBt)
			text_property = new TextField()
			gui.addChild(text_property)
			text_property.type = TextFieldType.INPUT
			text_property.x= 110
			text_property.y=230
			text_property.background=true
			text_property.backgroundColor=0x666666
			text_property.text ="insert Text and click text_propertyBt"
			text_property.width = 250
			text_property.height = 20
			text_property.addEventListener(FocusEvent.FOCUS_IN, resetTxt)
			
			var label_textColor:Label = new Label(gui,0,260,"textColor")			
			var huiSlider_textColor:ColorChooser = new ColorChooser(gui,75,260,0x666666,setColor)
			huiSlider_textColor.name ="textColor"
			
			
			var label_backgroundColor:Label = new Label(gui,0,283,"backgroundColor")	
			var choose_backgroundColor:ColorChooser = new ColorChooser(gui,75,286,0xffffff,setColor)
			choose_backgroundColor.name ="backgroundColor"
			
			var select_background:ComboBox = new ComboBox(gui,145,283,"Use background",[true,false])
			select_background.width = 100
			select_background.addEventListener(Event.SELECT, HD_select_background);
			
			
			var select_border:ComboBox = new ComboBox(gui,145,310,"Use border",[true,false])
			select_border.width = 100
			select_border.addEventListener(Event.SELECT, HD_select_border);
			
			var label_borderColor:Label = new Label(gui,0,310,"borderColor")	
			var choose_borderColor:ColorChooser = new ColorChooser(gui,75,313,0xffffff,setColor)
			choose_borderColor.name ="borderColor"
			
			var exField:Text = new Text(gui,0,350,"exField")
			exField.width=250
			exField.text = "Property List(More infomation? read AsDoc)\n_text,_textColor,_background,_backgroundColor,_border,_borderColor,_condenseWhite,_defaultTextFormat,_embedFonts,_htmlText,_multiline,_length"
			
			
			var label_backgroundColor2:Label = new Label(gui,0,460,"size")	
			var select_background2:ComboBox = new ComboBox(gui,145,460,"size",[10,20,30,40,50,60])
			select_background2.width = 100
			select_background2.addEventListener(Event.SELECT, HD_select_size);
			//var textFormat:Label = new Label(gui,0,220,"TextFormat")			
			
			var label_backgroundColor3:Label = new Label(gui,0,490,"align")	
			var select_background3:ComboBox = new ComboBox(gui,145,490,"align",["left","right","center"])
			select_background3.width = 100
			select_background3.addEventListener(Event.SELECT, HD_select_align);
			//var textFormat:Label = new Label(gui,0,220,"TextFormat")			
			
		}
		
		protected function HD_select_align($event:Event):void
		{
			switch($event.currentTarget.selectedIndex){
				case 0:
					red_TextField.align = "left"
					
					
					break
				case 1:
					red_TextField.align = "right"
					
					break
				case 2:
					red_TextField.align = "center"
					break
				
			}
		}
		
		protected function HD_select_size($event:Event):void
		{
			switch($event.currentTarget.selectedIndex){
				case 0:
					red_TextField.size = 10
					
					
					break
				case 1:
					red_TextField.size = 20
					
					break
				case 2:
					red_TextField.size = 30
					break
				case 3:
					red_TextField.size = 40
					break
				case 4:
					red_TextField.size = 50
					break
				case 5:
					red_TextField.size = 60
					break
			}
		}
		
		private function resetTxt( $event:FocusEvent=null):void{
			text_property.text=""
		}
		
		private function HD_text_propertyBt($e:Event=null):void
		{
			red_TextField.text = text_property.text
		}
		
		private function setColor($e:Event=null):void
		{
			red_TextField[$e.currentTarget.name] = $e.currentTarget.value	
		}				
		
		private function setValue($e:Event=null):void
		{
			red_TextField[$e.currentTarget.label] = $e.currentTarget.value			
		}
		
		private function HD_select_background( $event:Event ):void{
			switch($event.currentTarget.selectedIndex){
				case 0:
					red_TextField.background = true
					break
				case 1:
					red_TextField.background = false
					break
			}
		}
		
		private function HD_select_border( $event:Event ):void{
			switch($event.currentTarget.selectedIndex){
				case 0:
					red_TextField.border = true
					break
				case 1:
					red_TextField.border = false
					break
			}
		}
	}
}

