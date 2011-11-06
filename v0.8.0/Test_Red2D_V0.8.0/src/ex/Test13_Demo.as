package ex
{
	/** 
	 * by Paik seonki / redcamel
	 * webseon@hanmail.net	 
	 */
	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;
	
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	
	import red2D.display.Red_Sprite;
	import red2D.filter.fragmentBasic.InvertFilter;
	import red2D.filter.fragmentBasic.LightLevelFilter;
	import red2D.system.Red2D;
	import red2D.system.Red_Scene;
	

	/**
	 * 일종의 퍼포먼스 데모..
	 * 수백개의 이미지를....인터벌간격으로 개별 트위닝을 진행합니다.
	 * 필터적용처리가 추가되었습니다.
	 * @author redcamel
	 * 
	 */	
	public class Test13_Demo extends Red_Scene
	{		
	
		private var _maxNum:Number=8

		private var _allList:Red_Sprite;
		private var _listArray:Array=[];

		
		public function Test13_Demo()
		{
		}
		
		/**
		 * 실제 화면구성은 setDesign매서드를 오버라이드 하여 사용합니다.
		 * 
		 */		
		public override function setDesign():void{
			
			
			setBG()
			setTest()
				
			setInterval(HD_interval,3000)
			stage.addEventListener(MouseEvent.MOUSE_DOWN,HD_down)
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
		
		private function setTest():void
		{
			_allList = new Red_Sprite()
				
			_allList.filters = [new LightLevelFilter(2)]
			
			for(var i:Number=0; i<_maxNum;i++){
				var _list:Test13_DemoSubClass = new Test13_DemoSubClass((i+1)*100)
				_listArray.push(_list)
				_allList.addChild(_list)
			}
				
			addChild(_allList)
			_allList.x = stage.stageWidth/2
			_allList.y = stage.stageHeight/2
		}
		
		private function setBG():void
		{

			Red2D.backgroundColor=0x000000

		}
		
		protected function HD_interval(event:MouseEvent=null):void
		{
			for(var i:Number=0; i<_maxNum;i++){
				TweenMax.to(_listArray[i],1.2,{alpha:Math.random()+0.3,scaleX:1,rotation:360*Math.random(), scaleY:1,ease:Quint.easeInOut})
			}
		}		

		
		protected function HD_down(event:MouseEvent):void
		{
			TweenMax.to(_allList,1.2,{x:stage.mouseX,y:stage.mouseY,alpha:Math.random()+0.3,scaleX:1,rotation:360*Math.random(), scaleY:1,ease:Quint.easeInOut})
		}
		

	}
}