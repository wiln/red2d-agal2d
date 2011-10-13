package ex
{
	/** 
	 * by Paik seonki / redcamel
	 * webseon@hanmail.net	 
	 */
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.Text;
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	import red2D.system.Red_Scene;
	import red2D.text.Red_TextField;
	
	
	
	/**
	 * 05 Container 예제4 - 컨테이너 메소드 테스트
	 * @author redcamel
	 * 
	 */	
	public class Test14_DisplayContainer_Mathod extends Red_Scene
	{
		// 맵핑 테스트를 위한 비트맵
		[Embed( source = "./resource/flower.png" )]
		private static var MapTest1:Class;
		// 맵핑 테스트를 위한 비트맵
		[Embed( source = "./resource/testImg2.jpg" )]
		private static var MapTest2:Class;
		// 맵핑 테스트를 위한 비트맵
		
		private var gui:Sprite 
		
		private var removeBt2Txt:Text;
		private var removeBt2Txt2:Text;
		private var getChildByNameTxt:Text;
		private var getChildAtTxt:Text;
		private var setChildIndexTxt:Text;
		private var swapChildrenAtTxt:Text;
		private var swapChildrenAtTxt2:Text;
		
		private var getChildIndexTxt:Text;
		
		private var material1:BitmapMaterial 
		private var material2:BitmapMaterial
		
		public function Test14_DisplayContainer_Mathod()
		{
		}
		
		/**
		 * 실제 화면구성은 setDesign매서드를 오버라이드 하여 사용합니다.
		 * 
		 */		
		public override function setDesign():void{
			
			material1 = new BitmapMaterial(new MapTest1().bitmapData)
			material2 = new BitmapMaterial(new MapTest2().bitmapData)
			
			setUI()
			stage.addEventListener(Event.ENTER_FRAME, HD_enter)		
			stage.addEventListener(KeyboardEvent.KEY_DOWN, HD_key)
				
			
			
		}
		protected function HD_key(e:KeyboardEvent):void{
			if(e.keyCode ==70){
				stage.displayState = StageDisplayState.FULL_SCREEN
			}
		}
	
		
		private function setUI():void
		{
			gui = new Sprite()
			gui.x = 5
			gui.y = 5
			Style.setStyle(Style.DARK);
			stage.addChild(gui)
			
			var guiTitle:Label = new Label(gui,0,0,"Red2D Test\nContainer Method")				
			///////////////////////////////////////////////////////////////////////////////////////////////////
			var addChildBt:PushButton = new PushButton(gui,0,40,"addChild", HD_addChild)
			new Label(gui,110,40,"Add Red_Sprite and addChild")
			///////////////////////////////////////////////////////////////////////////////////////////////////
			var addChildAtBt:PushButton = new PushButton(gui,0,60,"addChildAt", HD_addChildAt)
			///////////////////////////////////////////////////////////////////////////////////////////////////
			var removeBt:PushButton = new PushButton(gui,0,90,"removeChild", HD_removeChild)
			new Label(gui,110,90,"RemoveChild Red_Sprite in DisplayList")
			///////////////////////////////////////////////////////////////////////////////////////////////////
			var removeBt2:PushButton = new PushButton(gui,0,110,"removeChildAt", HD_removeChildAt)
			removeBt2Txt = new Text(gui,110,110,"0")
			removeBt2Txt.width = 30
			removeBt2Txt.height = 20				
			removeBt2Txt2 = new Text(gui,110,60,"0")
			removeBt2Txt2.width = 30
			removeBt2Txt2.height = 20
			///////////////////////////////////////////////////////////////////////////////////////////////////	
			var getChildByName:PushButton = new PushButton(gui,0,140,"getChildByName", HD_getChildByName)
			getChildByNameTxt = new Text(gui,110,140,"insert child Name")
			getChildByNameTxt.width = 250
			getChildByNameTxt.height = 20
			getChildByNameTxt.addEventListener(FocusEvent.FOCUS_IN, resetTxt)
			///////////////////////////////////////////////////////////////////////////////////////////////////	
			var getChildAt:PushButton = new PushButton(gui,0,160,"getChildAt", HD_getChildAt)
			getChildAtTxt = new Text(gui,110,160,"insert child IndexNumber")
			getChildAtTxt.width = 250
			getChildAtTxt.height = 20
			getChildAtTxt.addEventListener(FocusEvent.FOCUS_IN, resetTxt)
			///////////////////////////////////////////////////////////////////////////////////////////////////	
			var getChildIndex:PushButton = new PushButton(gui,0,180,"getChildIndex", HD_getChildIndex)
			getChildIndexTxt =  new Text(gui,110,180,"Insert target name!")
			getChildIndexTxt.width = 250
			getChildIndexTxt.height = 20
			getChildIndexTxt.addEventListener(FocusEvent.FOCUS_IN, resetTxt)
			///////////////////////////////////////////////////////////////////////////////////////////////////		
			var setChildIndex:PushButton = new PushButton(gui,0,210,"lastChild-setChildIndex", HD_setChildIndex)
			setChildIndexTxt = new Text(gui,110,210,"0")
			setChildIndexTxt.width = 20
			setChildIndexTxt.height = 20
			///////////////////////////////////////////////////////////////////////////////////////////////////
			var swapChildrenAt:PushButton = new PushButton(gui,0,230,"swapChildrenAt", HD_swapChildrenAt)
			swapChildrenAtTxt = new Text(gui,110,230,"0")
			swapChildrenAtTxt.width = 20
			swapChildrenAtTxt.height = 20
			swapChildrenAtTxt2 = new Text(gui,130,230,"1")
			swapChildrenAtTxt2.width = 20
			swapChildrenAtTxt2.height = 20
			///////////////////////////////////////////////////////////////////////////////////////////////////
			var swapChildren:PushButton = new PushButton(gui,0,250,"swapChildren", HD_swapChildren)
			new Label(gui,110,250,"firstChild & lastChild SwapDepths!!!!")
			///////////////////////////////////////////////////////////////////////////////////////////////////
			var removeChildAll:PushButton = new PushButton(gui,0,280,"removeChildAll", HD_removeChildAll)
			new Label(gui,110,280,"remove all child in DisplayList!!")
		}
		
		/*************************************************************************/		
		/** 핸들러들**/	
		/*************************************************************************/	
		
		private function HD_removeChildAll($e:Event=null):void
		{
			removeChildAll()
		}
		
		protected function resetTxt( $e:FocusEvent ):void
		{
			$e.currentTarget.text = ""
		}
		
		private function HD_getChildIndex($e:Event=null):void
		{
			if(childNum==0){
				navigateToURL(new URLRequest("javascript:alert('등록된 객체가 없습니다')"),"_self")
				return
			}
			var target:Red_Sprite = getChildByName(getChildIndexTxt.text)
			if(target!=null){
				getChildIndexTxt.text = "success search! indexNumber is : " + String(getChildIndex(target))
				TweenLite.to( target , 2,{rotation:Math.random()*360, ease:Elastic.easeOut }) 	
			}else{
				getChildIndexTxt.text = "fail search, Insert another target name!"
			}
			
		}		
		private function HD_swapChildren($e:Event=null):void
		{
			if(childNum==0){
				navigateToURL(new URLRequest("javascript:alert('등록된 객체가 없습니다')"),"_self")
				return
			}
			swapChildren(children[0], children[childNum-1])
		}
		
		private function HD_swapChildrenAt($e:Event=null):void
		{
			if(childNum==0){
				navigateToURL(new URLRequest("javascript:alert('등록된 객체가 없습니다')"),"_self")
				return
			}
			swapChildrenAt(Number(swapChildrenAtTxt.text), Number(swapChildrenAtTxt2.text))
			
		}
		
		private function HD_setChildIndex($e:Event=null):void
		{
			if(childNum==0){
				navigateToURL(new URLRequest("javascript:alert('등록된 객체가 없습니다')"),"_self")
				return
			}
			setChildIndex( children[childNum-1], Number(setChildIndexTxt.text) )			
		}
		
		private function HD_getChildAt($e:Event=null):void
		{
			var target:Red_Sprite = getChildAt(Number(getChildAtTxt.text))
			if(target!=null){
				getChildAtTxt.text ="success search : " + target.name
				TweenLite.to( target , 3,{rotation:Math.random()*360, ease:Elastic.easeOut }) 	
			}else{
				getChildAtTxt.text = "fail search, Insert another target index!"
			}		
		}
		
		private function HD_getChildByName($e:Event=null):void
		{
			var target:Red_Sprite = getChildByName(getChildByNameTxt.text)
			if(target!=null){
				getChildByNameTxt.text ="success search : " + target.name
				TweenLite.to( target , 3,{rotation:Math.random()*360, ease:Elastic.easeOut }) 	
			}else{
				getChildByNameTxt.text = "fail search, Insert another target name!"
			}
		}
		
		private function HD_addChildAt($e:Event=null):void
		{
			
			var testBox:Red_Sprite = new Red_Sprite(100,100, stage.stageWidth/2,	stage.stageHeight/2)
			addChildAt(testBox, Number(removeBt2Txt2.text))
			//속성설정
			testBox.name = "test"+(childNum-1)
			//재질설정
			testBox.material = material1
			
			var textInfo:Red_TextField = new Red_TextField()
			textInfo.text = testBox.name
			
			//textBox에 Red_TextField등록
			testBox.addChild(textInfo)
			textInfo.y= testBox.height/2+10
			resetAllText()
		}
		
		private function HD_removeChildAt($e:Event=null):void
		{
			if(childNum==0){
				navigateToURL(new URLRequest("javascript:alert('등록된 객체가 없습니다')"),"_self")
				return
			}
			removeChildAt(Number(removeBt2Txt.text))
			resetAllText()
		}
		

		
		private function HD_removeChild($e:Event=null):void
		{
			if(childNum==0){
				navigateToURL(new URLRequest("javascript:alert('등록된 객체가 없습니다')"),"_self")
				return
			}
			removeChild(children[childNum-1])
			resetAllText()
		}
		
		private function HD_addChild($e:Event=null):void
		{
			
			//trace($e.currentTarget)
			var testBox:Red_Sprite = new Red_Sprite(100,100, stage.stageWidth/2,	stage.stageHeight/2)
			addChild(testBox)
			testBox.name = "test"+(childNum-1)
			//재질설정
			testBox.material = material2
			
			var textInfo:Red_TextField = new Red_TextField()
			textInfo.text = testBox.name
			
			//textBox에 Red_TextField등록
			testBox.addChild(textInfo)
			textInfo.y= testBox.height/2+10
			resetAllText()
		}		
		
		private function resetAllText():void
		{
			if(childNum!=0){
				for (var i:Number =0 ; i<childNum; i++){
					var target:Red_Sprite = children[i]
					var targetTextField:Red_TextField = target.getChildAt(0)as Red_TextField
					targetTextField.text = "this.name : "+target.name +"\nindexNum : "+i
					
				}
			}			
		}
		
		protected function HD_enter(event:Event):void
		{
			if(childNum!=0){
				for (var i:Number =0 ; i<childNum; i++){
					var target:Red_Sprite = children[i]
					target.x += ((stage.stageWidth/2+Math.sin(360/childNum*i*Math.PI/180)*(stage.stageHeight-100)/2)-children[i].x)*0.3
					target.y += ((stage.stageHeight/2+Math.cos(360/childNum*i*Math.PI/180)*(stage.stageHeight-100)/2)-children[i].y)*0.3
				}
			}			
		}
	}
}