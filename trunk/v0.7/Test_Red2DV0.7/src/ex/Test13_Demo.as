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
	import red2D.system.Red2D;
	import red2D.system.Red_Scene;
	

	/**
	 * 일종의 퍼포먼스 데모..
	 * 수백개의 이미지를....인터벌간격으로 개별 트위닝을 진행합니다.
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
		
		private function setTest():void
		{
			_allList = new Red_Sprite()
			
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