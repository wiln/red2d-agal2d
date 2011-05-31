package Red2D.container
{
	import Red2D.display.Red_DisplayObject;
	
	import flash.display.Stage;
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;

	/**  
	 * Red_Scene	
	 * 이놈은 PV3d나 Away3D의 Scene 같은놈으로 Display할 목록들을 정의 한다.
	 * <p>실제적인 코딩은 이 클래스를 확장하여 작성한다.</p>
	 * / Last update - May 31, 2011
	 * @tag Tag text.
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * 
	 * 
	 */  
	public class Red_Scene
	{
		/**
		 * 차일드를 여기에 정리한다. 
		 */		
		private var _children:Vector.<Red_DisplayObject> =Vector.<Red_DisplayObject>([])
		private var _targetStage:Stage;
		private var _targetContext3D:Context3D;
			
		public function Red_Scene(){ 
		}
		
	
	

		/**
		 * Red2D객체에 setScene을 통해 등록할때 자동으로 초기화된다.
		 * @param $stage
		 * @param $context3d
		 * 
		 */		
		public function init( $stage:Stage , $context3d:Context3D ):void
		{
			_targetStage = $stage 
			_targetContext3D = $context3d
		}
		
		/**
		 * 랜더링 리스트 설정 
		 * @param $program3D
		 * 
		 */		
		public function setRenderList( $program3D:Program3D ):void{
			var i:Number=0
			var maxChild:Number = children.length
			
			for( i ; i< maxChild ; i++ ){
				children[i].draw( $program3D )
			}
		}
		
		/*********************************************************************************/
		/** 실제 디자인영역  ****/
		/*********************************************************************************/
		/**
		 * 실제 화면디자인을 구성하는 매서드 / 이 매서드를 오버라이드해서 화면을 구성한다. 
		 * 
		 */		
		public function setDesign():void
		{
			throw new Error("override하여 화면을 구성해주세요")
		}
		
		/*********************************************************************************/
		/** get / set  ****/
		/*********************************************************************************/
		
		/**
		 * context3D에 그려지는 children 목록갯수 반환
		 * @return 
		 * 
		 */		
		public function get children():Vector.<Red_DisplayObject>
		{
			return _children;
		}

		/**
		 * 디스플레이 리스트 등록 
		 * @param $target
		 * 
		 */		
		public function addChild( $target:Red_DisplayObject ):void{
			children.push( $target )
		}

		/**
		 * 현재 등록된 context3D
		 */
		public function get targetContext3D():Context3D
		{
			return _targetContext3D;
		}
		/**
		 * 현재 등록된 stage
		 */
		public function get targetStage():Stage
		{
			return _targetStage;
		}
	
	}
}