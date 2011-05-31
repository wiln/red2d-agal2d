package 
{

	import Red2D.Material.BitmapMaterial;
	import Red2D.Material.ColorMaterial;
	import Red2D.Material.IMaterial;
	import Red2D.container.Red_Scene;
	import Red2D.display.Red_DisplayObject;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	
	import flash.display3D.Context3DTextureFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**  
	 * TestScene	
	 * / Last update - May 24, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 128~ 
	 * 
	 * 
	 */  
	public class TestScene03 extends Red_Scene
	{
		[Embed( source = "./res/test1.jpg" )]
		private static var MapTest1:Class;
		
		[Embed( source = "./res/test2.jpg" )]
		private static var MapTest2:Class;
		
		private var testBox:Red_DisplayObject;
		private var totalNum:Number=800
		private var currentNum:Number =0
		
		/**
		 * 대량 객체 등록 및 이벤트 실행 테스트
		 * 사각형을 num갯수만큼 생성하고 128*128 재질생성
		 * 엔터프레임으로 개별적으로 TweenLite로 모션을 주는 스크립트 
		 * 
		 */		
		public override function setDesign():void
		{					
			// 재질설정
			var bitmapMaterial1:BitmapMaterial =  new BitmapMaterial(targetContext3D, new MapTest1().bitmapData , 128, 128, Context3DTextureFormat.BGRA, false)
			var bitmapMaterial2:BitmapMaterial =  new BitmapMaterial(targetContext3D, new MapTest2().bitmapData , 128, 128, Context3DTextureFormat.BGRA, false)
			var colorMaterial:ColorMaterial = new ColorMaterial(targetContext3D,0xffffffff*Math.random())
	
			for(var i:Number=0; i<totalNum; i++){
				var material:IMaterial				
				if(i%3==1){
					material = bitmapMaterial1
				}else if(i%3==2){
					material = bitmapMaterial2
				}else{
					material = new ColorMaterial(targetContext3D,0xffffffff*Math.random())
				}
				
				// 사각형생성
				makeDisplayObject( material )
			}	
			
			// 마우스 이벤트 테스트
			targetStage.addEventListener(MouseEvent.MOUSE_DOWN , HD_Down)
			targetStage.addEventListener(Event.ENTER_FRAME , HD_enterTest)
		}
		
		/**
		 * 사각형생성 
		 * 
		 */		
		private function makeDisplayObject( $material:IMaterial ):void
		{
			var width:Number =Math.random()*128
			var height:Number = width
			
			// * 2D생성
			testBox = new Red_DisplayObject(
					targetStage, targetContext3D ,
					width , width ,
					$material,
					targetStage.stageWidth * Math.random()-300, targetStage.stageHeight * Math.random()
				)					
			addChild(testBox)
		}
		
		
		/**
		 * 마우스이벤트 
		 * @param event
		 * 
		 */		
		protected function HD_Down(event:Event=null):void
		{
			// 트윈라이트를 적용해보자			
			for(var i:Number=0; i<totalNum; i++){
				var scale:Number = Math.random()
				TweenLite.to(children[i],1,{
				rotation:Math.random()*360 ,
				x:targetStage.stageWidth*Math.random()-300,
				y:targetStage.stageHeight*Math.random(),
				scaleX:scale,
				scaleY:scale,
				ease:Quint.easeInOut })
			}
		}
		
		/**
		 * 엔터프레임 이벤트 
		 * @param e
		 * 
		 */		
		private function HD_enterTest(e:Event):void{
			var height:Number = targetStage.stageHeight
			var width:Number = targetStage.stageWidth
				
			var target:*
				currentNum++
				if(currentNum==totalNum){
					currentNum=1
					HD_Down()
				}				
				var scale:Number = Math.random()
					
				TweenLite.to(children[totalNum-currentNum],1.5,{
					rotation:Math.random()*360 ,
					x:targetStage.stageWidth-100,
					y:targetStage.stageHeight/2,
					scaleX:0.01,
					scaleY:0.01,
					ease:Quint.easeOut })
		}		
	}
}