package ex  
{
	/** 
	 * by Paik seonki / redcamel
	 * webseon@hanmail.net	 
	 */
	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;
	
	import flash.utils.setInterval;
	
	import red2D.display.Red_Sprite;
	import red2D.material.BitmapMaterial;
	
	public class Test13_DemoSubClass extends Red_Sprite
	{
		[Embed( source = "./resource/photo/01.png" )]
		private static var Photo01:Class;
		[Embed( source = "./resource/photo/02.png" )]
		private static var Photo02:Class;
		[Embed( source = "./resource/photo/03.png" )]
		private static var Photo03:Class;
		[Embed( source = "./resource/photo/04.png" )]
		private static var Photo04:Class;
		[Embed( source = "./resource/photo/05.png" )]
		private static var Photo05:Class;		
		[Embed( source = "./resource/photo/06.png" )]
		private static var Photo06:Class;
		[Embed( source = "./resource/photo/07.png" )]
		private static var Photo07:Class;
		[Embed( source = "./resource/photo/08.png" )]
		private static var Photo08:Class;

		private var _lists:Array=[];
		private var _maxNum:Number=20
		private var _materialList:Array=[];
		private var _circleRadius:Number;
		
		public function Test13_DemoSubClass( $circleRadius:Number = 300 )
		{
			_circleRadius=$circleRadius
			setDisplay()
		}
		
		/**
		 * 실제 화면구성은 setDesign매서드를 오버라이드 하여 사용합니다.
		 * 
		 */		
		public  function setDisplay():void{
			setMaterialList()

			for(var i:Number=0; i<_maxNum;i++){
				var list:Red_Sprite = new Red_Sprite()
				list.width = 75
				list.height = 100
				list.scaleX = 0.01
				list.scaleY = 0.01
				list.rotation = 180
				list.alpha=0
				_lists.push(list)
				addChild(list)
				list.material = _materialList[i%7]

			}
			setAnimation()
			setInterval(HD_interval,2000)
	
		}
		

		/**
		 * 재질만들기 
		 * 
		 */		
		private function setMaterialList():void
		{
			var material1:BitmapMaterial = new BitmapMaterial(new Photo01().bitmapData,256,256)
			var material2:BitmapMaterial = new BitmapMaterial(new Photo02().bitmapData,256,256)
			var material3:BitmapMaterial = new BitmapMaterial(new Photo03().bitmapData,256,256)
			var material4:BitmapMaterial = new BitmapMaterial(new Photo04().bitmapData,256,256)
			var material5:BitmapMaterial = new BitmapMaterial(new Photo05().bitmapData,256,256)
			var material6:BitmapMaterial = new BitmapMaterial(new Photo06().bitmapData,256,256)
			var material7:BitmapMaterial = new BitmapMaterial(new Photo07().bitmapData,256,256)
			var material8:BitmapMaterial = new BitmapMaterial(new Photo08().bitmapData,256,256)
			
			_materialList.push(material1)
			_materialList.push(material2)
			_materialList.push(material3)
			_materialList.push(material4)
			_materialList.push(material5)
			_materialList.push(material6)
			_materialList.push(material7)

		}
		
		private function setAnimation():void
		{
			for(var i:Number=0; i<_lists.length;i++){
				var tx:Number = _circleRadius*Math.cos(Math.PI/180*360/_lists.length*i);  
				var ty:Number = _circleRadius*Math.sin(Math.PI/180*360/_lists.length*i);  
				TweenMax.to(_lists[i],1.2,{alpha:1,scaleX:1,rotation:0, scaleY:1, delay:0.1*i,x:tx,y:ty,ease:Quint.easeInOut})
			}
			
		}
		
		private function HD_interval():void
		{
			for(var i:Number=0; i<_lists.length;i++){
				var tx:Number = _circleRadius*Math.cos(Math.PI/180*360/_lists.length*i);  
				var ty:Number = _circleRadius*Math.sin(Math.PI/180*360/_lists.length*i);  
				TweenMax.to(_lists[i],1.2,{alpha:Math.random(),scaleX:1,rotation:0, scaleY:1, delay:0.1*i,x:tx,y:ty,ease:Quint.easeInOut})
			}
		}
	}
}