package red2D.display.base
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.getQualifiedClassName;
	
	import red2D.system.Red2D;

	/** 
	 * <p>하이라키개념 구현을 위한 클래스</p>
	 * Last update - Sep 13, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Red_DisplayContainer extends Red_DisplayObject
	{
		/********************************************************************************/
		/** 변수선언 **/
		/********************************************************************************/	
		
		/**
		 * 자식 객체 리스트
		 */		
		protected var _children:Array=[];
		/**
		 * 부모컨테이너 
		 */		
		protected var _parent:Red_DisplayContainer

		/********************************************************************************/
		/** 생성자 **/
		/********************************************************************************/	
		public function Red_DisplayContainer()
		{
			var className:String = getQualifiedClassName(this);			
			//  클래스를 직접 생성하는지 확인 - 직접생성할 경우 에러
			if (className == "red2D.display.base::Red_DisplayContainer")
			{
				throw new Error("Red_DisplayContainer 생성자로 이용 할 수 없습니다")		
			}		
		}
		
		/********************************************************************************/
		/** 매서드 **/
		/********************************************************************************/	
		
		/**
		 * 렌더링 대상 리스트들에 대하여 렌더링 실행 
		 * 
		 */		
		public function setRenderList(  ):void
		{		
			var i:int=0		
			var prevChangeProperty:Boolean = _changeProperty
				
			applyParentAlpha()			
			drawObject()
			
			for( i ; i< _children.length ; ++i  )
			{			
				_children[i].changeProperty = prevChangeProperty
				_children[i].setRenderList()					
			}	

			checkMouseEvent()
		}
		
		/**
		 * 모델좌표계와 전역좌표계화 화면좌표계를 반영합니다. (속성의 변화가 있을때만 변경합니다)
		 * 
		 */		
		protected override function setMatrix():void{
			// 속성변화가 있을때만 기존 매트릭스를 변환 - 부모자식간의 영향판단을 개선해야함..향후적용
			//if(_changeProperty){
				_mcs.identity()	
				_mcs.appendTranslation(_pivotX,_pivotY,1)	
				_mcs.appendRotation(_rotation, Vector3D.Z_AXIS);
				_mcs.appendTranslation(_x,_y,1)					
				
				_mvp.identity()
				_mvp.appendScale(_width*_scaleX,_height*_scaleY,1)		
				_mvp.append(_mcs)				
				
				// 부모좌표계 합산
				var parents:Red_DisplayContainer = this	
				var parentScaleX:Number = _scaleX
				var parentScaleY:Number = _scaleY		
				
				for (var i:int=0; i<1000; ++i){
					if(parents.parent !=null){			
						parents = parents.parent as Red_DisplayContainer
						_mvp.appendScale(parents.scaleX,parents.scaleY,1)
						_mvp.append(parents.mcs)				
					}else{
						break
					}
				}	
				
				// 마우스이벤트체크를 위해 매트릭스복사
				_mouseCheckMatrix = _mvp.clone()
				
				// 화면좌표계로 변환
				_mvp.append(wcsAndvcs)
					
			//	_changeProperty=false
			//}			
		}
		
		/**
		 * 알파값을 부모 알파값과 합산하여 적용한다. 
		 * 
		 */		
		private function applyParentAlpha():void{

				var parents:Red_DisplayContainer = this	
				var targetAlpha:Number = _alpha				
					
				for (var i:int=0; i<1000; ++i){
					if(parents.parent !=null){			
						parents = parents.parent as Red_DisplayContainer
						targetAlpha *= parents.alpha
					}else{
						break
					}
				}	
			
			 _alphaVector=Vector.<Number>([targetAlpha,targetAlpha,targetAlpha,targetAlpha])	
		}
			
		/**
		 *  화면 따른 시점좌표계와 전역좌표계를 재설정합니다.  
		 * @param $wcs
		 * @param $vcs
		 * 
		 */		
		public function updateVcsAndWcs( $wcsAndvcs:Matrix3D ):void{
			wcsAndvcs =$wcsAndvcs
			var i:int=0
			
			_changeProperty = true
			for( ; i< _children.length; ++i  ){	
				children[i].updateVcsAndWcs(wcsAndvcs)
				children[i].changeProperty = true
			}	
		}
					
		/**
		 * 마우스 이벤트를 체크하는 매서드 / Red_InteractiveObject 에서 오버라이드합니다.
		 * 
		 */		
		protected function checkMouseEvent():void{
			throw new Error("Red_InteractiveObject 에서 오버라이드합니다.")		
		}
		
		/********************************************************************************/
		/** display list 매서드 **/
		/********************************************************************************/	

		/**
		 * context3D에 그려지는 children 목록갯수 반환
		 * @return 
		 * 
		 */		
		public function get childNum():Number
		{
			return _children.length;
		}	
		/**
		 * context3D에 그려지는 children 목록반환
		 * @return 
		 * 
		 */		
		public function get children():Array
		{
			return _children;
		}
		
		/**
		 * 디스플레이 리스트 등록 
		 * @param $target
		 * 
		 */		
		public function addChild( $target:Red_DisplayContainer ):void{
			_children.push( $target )
			$target.parent = this
			$target.wcsAndvcs = Red2D.targetScene.wcsAndvcs			
		}
				
		/**
		 * 디스플레이 리스트에서 제거
		 * @param $target
		 * 
		 */		
		public function removeChild( $target:Red_DisplayContainer ):void{
			if( childNum != 0 ){
				$target.parent = this
				children.splice(children.indexOf($target),1)
				
			}else{
				throw new Error("\n\nRed2D Errow!!\nChildNum이 0입니다 removeChild를 진행할 대상이 없습니다.\n")
			}
		}
		
		/**
		 * 지정된 인덱스에 디스플레이 리스트 등록 
		 * @param $target
		 * @param $index
		 * 
		 */	
		public function addChildAt( $target:Red_DisplayContainer , $targetIndex:Number ):void {
			if( $targetIndex > childNum ){
				$targetIndex=childNum
			}
			children.splice( $targetIndex, 0 , $target )
			$target.parent = this
			$target.wcsAndvcs = Red2D.targetScene.wcsAndvcs			
				
		}
		
		/**
		 * 지정된 인덱스에서 디스플레이 리스트  제거
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
		/********************************************************************************/
		/** get / set **/
		/********************************************************************************/
		/**
		 * 부모 컨테이너
		 */
		public function get parent():Red_DisplayContainer
		{
			return _parent;
		}

		/**
		 * @private
		 */
		public function set parent(value:Red_DisplayContainer):void
		{
			_parent = value;
		}


	}
}

