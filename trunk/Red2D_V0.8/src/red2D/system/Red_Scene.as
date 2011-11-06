package red2D.system
{
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix3D;
	import flash.utils.getTimer;
	
	import red2D.display.base.IRed_Display;
	import red2D.display.base.Red_DisplayContainer;
	import red2D.display.base.Red_DisplayObject;
	import red2D.display.base.Red_InteractiveObject;

	/** 
	 * <p>실제뷰를 생성하는 클래스이며 이 클래스를 확장하여 기본뷰를 제작합니다</p> 
	 * Last update - Sep 10, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0  
	 */
	public class Red_Scene
	{
		/**
		 * 이용할 Context3D 
		 */		
		private var _context3D:Context3D;
		/**
		 * 현재 사용하고있는 stage 
		 */		
		private var _stage:Stage;
		
		/**
		 *  자식 객체 리스트
		 */		
		private var _children:Array=[];
			
		/**
		 * 전역 좌표계 
		 */			
		private var wcs:Matrix3D =  new Matrix3D()
		/**
		 * 화면 좌표계
		 */			
		private var vcs:Matrix3D =  new Matrix3D()
			
		/**
		 * 전역화면좌표계 (유저사용빈도는 거의 없습니다)
		 */			
		public var wcsAndvcs:Matrix3D =  new Matrix3D()
			
		/**
		 * 생성자 
		 * 
		 */		
		public function Red_Scene()
		{		
		}
		
		/**
		 * 실제 화면디자인을 구성하는 매서드 / 이 매서드를 오버라이드해서 화면을 구성한다. 
		 * 
		 */		
		public function setDesign():void
		{	
			throw new Error("RedScene - setDesign()을 override하여 화면을 구성해주세요")					
		}
		
		/**
		 * 화면 따른 시점좌표계와 전역좌표계를 재설정하고 자식객체에게 변환된 좌표계를 입력합니다. 
		 * 
		 */		
		public function resetVcsAndWcs():void{
			
			wcs.identity()
			wcs.appendTranslation(-Red2D.targetStage.stageWidth/2, -Red2D.targetStage.stageHeight/2, 0);
			wcs.appendScale(1, -1, 1);
			
			vcs=makeOrthoProjection(Red2D.targetStage.stageWidth,Red2D.targetStage.stageHeight)	
				
			wcsAndvcs.identity()
			wcsAndvcs.append(wcs)
			wcsAndvcs.append(vcs)

			var i:int=0
			for( ; i< _children.length; ++i  ){			
				children[i].wcsAndvcs = wcsAndvcs
				children[i].updateVcsAndWcs(wcsAndvcs)
			}			
		}
		
		/**
		 * 렌더링 대상 리스트 실행 매서드
		 * 
		 */		
		public function setRenderList():void
		{			
			var i:int=0
			
			for(; i< _children.length ;++i){				
				_children[i].setRenderList()							
			}	
			update()
		}
		
		
		/**
		 * <p>매프레임 실행될 업데이트 사항을 기술합니다.</p> 
		 * <p>Scene마다 엔터프레임 이벤트를 따로 줄 경우 리소스 손실 및 관리효율이 떨어집니다</p>
		 * 렌더링을 요청할때 같이 실행이됨으로 엔터프레임과 같이 사용하실 수 있습니다.
		 */		
		public function update():void
		{			
			throw new Error("매프레임마다 실행될 업데이트 사항을 기술합니다. 오버라이드하세요")
		}

		/********************************************************************************/
		/** 유틸 매서드 **/
		/********************************************************************************/	
		/**
		 * 화면 좌표계를 구하는 매서드
		 * @param $stageWidth
		 * @param $stageHeight
		 * @return 
		 * 
		 */		
		private function makeOrthoProjection( $stageWidth:Number, $stageHeight:Number):Matrix3D
		{
			return new Matrix3D(Vector.<Number>
				([
					2/$stageWidth, 	0			    ,			0,			0,
					0, 				2/$stageHeight  ,			0,			0,
					0, 				0				,			0,			0,
					0,				0				,			0,			1
				]));
		}		
		
		/********************************************************************************/
		/** get / set  **/
		/********************************************************************************/	
		
		/**
		 * @private
		 */
		public function set context3D(value:Context3D):void
		{
			_context3D = value;
		}

		/**
		 * stage 
		 */
		public function get stage():Stage
		{
			return _stage;
		}

		/**
		 * @private
		 */
		public function set stage(value:Stage):void
		{
			_stage = value;
		}
		
		/********************************************************************************/
		/** display list 매서드 **/
		/********************************************************************************/	
		/**
		 * context3D에 그려지는 children 목록갯수 반환합니다.
		 * @return 
		 * 
		 */		
		public function get childNum():Number
		{
			return _children.length;
		}	
		/**
		 * context3D에 그려지는 children 목록반환합니다.
		 * @return 
		 * 
		 */		
		public function get children():Array
		{
			return _children;
		}
		
		/**
		 * 디스플레이 리스트에 대상을 등록합니다. 
		 * @param $target
		 * 
		 */		
		public function addChild( $target:Red_DisplayContainer ):void{
			_children.push( $target )
			$target.parent = null
			$target.wcsAndvcs = wcsAndvcs			
		}
		
		/**
		 * 디스플레이 리스트에서 대상을 제거합니다.
		 * @param $target
		 * 
		 */		
		public function removeChild( $target:Red_DisplayContainer ):void{
			if( childNum != 0 ){
				$target.parent = null
				children.splice(children.indexOf($target),1)				
			}else{
				throw new Error("\n\nRed2D Errow!!\nChildNum이 0입니다 removeChild를 진행할 대상이 없습니다.\n")
			}
		}
		/**
		 * 디스플레이 리스트 등록 
		 * @param $target
		 * @param $index
		 * 
		 */	
		public function addChildAt( $target:Red_DisplayContainer , $targetIndex:Number ):void {
			if( $targetIndex > childNum ){
				$targetIndex=childNum
			}
			children.splice( $targetIndex, 0 , $target )
			$target.parent = null
			$target.wcsAndvcs = Red2D.targetScene.wcsAndvcs			
			
		}
		
		/**
		 * 디스플레이 리스트에서 제거
		 * @param $index
		 * 
		 */	
		public function removeChildAt( $targetIndex:Number ):void {
			if( $targetIndex < childNum ){
				var target:Red_DisplayContainer = children[ $targetIndex ] 
				target.parent = null	
				children.splice($targetIndex,1)
				
			}else if( childNum==0 ){
				throw new Error("\n\nRed2D Errow!!\nChildNum이 0입니다 removeChildAt을 진행할 대상이 없습니다.\n")
			}else{
				throw new Error("\n\nRed2D Errow!!\nremoveChild하려는 디스플레이 객체의 index번호가 ChildNum보다 큽니다.\n")
			}			
		}
		
		/**
		 * 디스플레이 자식목록 리스트에서 모든 자식을 removeChild합니다
		 * 
		 */		
		public function removeChildAll():void{
			children.splice(0)			
		}		
		
		/**
		 * 지정된 인덱스에 존재하는 자식 표시 객체 인스턴스를 반환합니다.
		 * @param $targetIndex
		 * @return 
		 * 
		 */		
		public function getChildAt( $targetIndex:Number ):*{
			if( childNum !=0 ){
				var target:* = null
				target = children[ $targetIndex ]
			}
			return target
		}
		
		/**
		 * 디스플레이 리스트에서 name값을 가진 객체를 반환 
		 * @param $targetName
		 * @return 
		 * 
		 */		
		public function getChildByName( $targetName:String ):*{
			if(childNum !=0){
				var target:* = null
				for (var i:int = 0 ; i <childNum ; i++){
					if(children[i].name == $targetName){
						target = children[i]
						break				
					}
				}
			}
			return target
		}		
		
		/**
		 * 자식 DisplayObject 인스턴스의 인덱스 위치를 반환합니다.
		 * @param $targetName
		 * @return 
		 * 
		 */		
		public function getChildIndex( $targetChild:Red_DisplayContainer ):Number{
			if(childNum !=0){
				var returnNum:Number = NaN
				for (var i:int = 0 ; i <childNum ; i++){
					if(children[i] === $targetChild){
						returnNum = i
					}
				}
			}
			return returnNum
		}		
		
		/**
		 * 디스플레이 리스트에서 목표객체의 index를 목표Index로 변경 
		 * @param $targetIndex
		 * @param $index
		 * 
		 */		
		public function setChildIndex( $target:Red_DisplayContainer , $targetIndex:Number ):void{
			if( $targetIndex > childNum ){
				$targetIndex=childNum
			}
			
			if(childNum !=0){
				removeChild( $target )
				addChildAt( $target, $targetIndex )
			} else if( childNum==0 ){
				throw new Error("\n\nRed2D Errow!!\nChildNum이 0입니다 removeChildAt을 진행할 대상이 없습니다.\n")
				
			}
		}
		
		/**
		 * 자식 목록에서 지정된 두 곳의 인덱스 위치에 있는 자식 객체의 z 순서(전후 순서)를 맞바꿉니다.
		 * @param $index1
		 * @param $index2
		 * 
		 */		
		public function swapChildrenAt( $index1:int, $index2:int ):void {
			var target1:Red_DisplayContainer = children[ $index1 ]
			var target2:Red_DisplayContainer = children[ $index2 ]
			
			children[$index1] = target2
			children[$index2] = target1			
		}
		
		/**
		 * 지정된 두 개의 자식 객체의 z 순서(전후 순서)를 맞바꿉니다.
		 * @param $target1
		 * @param $target2
		 * 
		 */		
		public function swapChildren( $target1:Red_DisplayContainer , $target2:Red_DisplayContainer ):void {
			var targetIndex1:Number = children.indexOf($target1)
			var targetIndex2:Number = children.indexOf($target2)
			
			children[targetIndex1] = $target2
			children[targetIndex2] = $target1			
		}
	}
}

