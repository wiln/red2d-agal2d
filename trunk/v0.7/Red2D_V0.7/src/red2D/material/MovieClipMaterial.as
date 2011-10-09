package red2D.material
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display3D.Context3DTextureFormat;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import red2D.system.Red2D;

	/**  
	 * <p>MovieClip을 재질로 지정하는 Class </p>
	 * <p>실제로 MovieClip을 이용하며 디스플레이 표현만 StageAPI(Molehill)을 이용한다</p>
	 * <p>Last update - July 25, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 * 
	 */ 	
	public class MovieClipMaterial extends MaterialBase
	{

		/**
		 * 재질로 사용할 무비클립 
		 */		
		private var _movieClip:MovieClip;

		/**
		 * 애니메이션을 사용할지 여부를 설정 
		 */		
		private var _useAnimation:Boolean=false
			
			
		/**
		 * 애니메이션 사용에 따른 인터벌세팅 
		 */			
		private var _interval:uint;
		
		/**
		 * 현재프레임 
		 */		
		private var _currentFrame : int
		/**
		 * 현재프레임 라벨 
		 */		
		private var _currentFrameLabel : String
		/**
		 * 현재라벨 
		 */		
		private var _currentLabel : String
		private var _currentLabels : Array
		private var _framesLoaded : int
		private var _totalFrames : int
		private var _optimizeRenderToTexture:Boolean;
		private var _format:String;
		private var _rect:Rectangle;
		private var _point:Point;
		



		/**
		 * MovieClipMaterial 
		 * @param $context3d
		 * @param $bitmapData
		 * @param $width
		 * @param $height
		 * @param $format
		 * @param $optimizeRenderToTexture
		 * 
		 */		
		public function MovieClipMaterial( $movieClip:MovieClip ,$width:Number=128, $height:Number=128,  $format:String = Context3DTextureFormat.BGRA, $optimizeRenderToTexture:Boolean=false)
		{
			_width = $width
			_height = $height
			_rect =new Rectangle(0,0,_width,_height)
			
			_context3d = Red2D.targetContext3d
			
			_bitmapData = new BitmapData( _width , _height , true , 0x00ffffff)		
			_texture= _context3d.createTexture( _width  , _height , $format ,$optimizeRenderToTexture );		
			
			_movieClip = $movieClip			
			update()					
		}
		
		/**
		 * 텍스쳐 업데이트 
		 * 
		 */		
		private function update():void
		{			
			_bitmapData.fillRect(_rect,0x00ffffff)
			_bitmapData.draw( _movieClip , null , null , null, null,true)					
		
						
			_texture.uploadFromBitmapData( _bitmapData );					
		
		}		
		/***************************************************************/
		/** 텍스쳐관련 매서드 **/
		/***************************************************************/
		/**
		 * 텍스쳐반환 
		 * @return 
		 * 
		 */		
		public function getTexture():*{
			return _texture
		}
		
		/**
		 * 텍스쳐 사이즈 반환 
		 * @return 
		 * 
		 */		
		public function getTextureSize():Object
		{
			return {width:_width , height:_height}
		}

		/**
		 * 재질에 사용된 무비클립을 반환 
		 * @return 
		 * 
		 */		
		public function getMovieClip():MovieClip
		{
			return _movieClip
		}
		
				
		/***************************************************************/
		/** 무비클립 매서드 **/
		/***************************************************************/
		
		/**
		 * 지정된 프레임에서 SWF 파일 재생을 시작합니다.
		 * @param frame
		 * @param scene
		 * 
		 */		
		public function gotoAndPlay( $frame:Object ):void{
			_movieClip.gotoAndPlay( $frame )
		}		

		/**
		 * 동영상 클립의 특정 프레임으로 재생 헤드를 가져온 다음 정지합니다.
		 * @param frame
		 * @param scene
		 * 
		 */		
		public function gotoAndStop( $frame:Object):void{
			_movieClip.gotoAndStop( $frame )
		}

		/**
		 * 	재생 헤드를 다음 프레임으로 보낸 다음 정지합니다.
		 * 
		 */		
		public function nextFrame():void{
			_movieClip.nextFrame()
		}
		
		/**
		 * 	동영상 클립의 타임라인에서 재생 헤드를 이동합니다.
		 * 
		 */			
		public function play():void{
			_movieClip.play()
		}
		
		/**
		 * 	재생 헤드를 이전 프레임으로 보낸 다음 정지합니다.
		 * 
		 */			
		public function prevFrame():void{
			_movieClip.prevFrame()
		}
			
		/**
		 * 	동영상 클립의 재생 헤드를 정지합니다.
		 */
		public function stop():void{
			_movieClip.stop()
		}
		
		/***************************************************************/
		/** get/set **/
		/***************************************************************/		

		/**
		 * 재생 헤드가 MovieClip 인스턴스의 타임라인에 있는 프레임 번호를 지정합니다.
		 */
		public function get currentFrame():int
		{
			return _movieClip.currentFrame
		}

		/**
		 * MovieClip 인스턴스의 타임라인에서 현재 프레임의 레이블입니다.
		 */
		public function get currentFrameLabel():String
		{
			return _movieClip.currentFrameLabel;
		}

		/**
		 * MovieClip 인스턴스의 타임라인에서 재생 헤드가 있는 현재의 레이블입니다.
		 */
		public function get currentLabel():String
		{
			return _movieClip.currentLabel;
		}

		/**
		 * 현재 장면에서 FrameLabel 객체의 배열을 반환합니다.
		 */
		public function get currentLabels():Array
		{
			return _movieClip.currentLabels;
		}

		/**
		 * 스트리밍 SWF 파일에서 로드되는 프레임 수입니다.
		 */
		public function get framesLoaded():int
		{
			return _movieClip.framesLoaded;
		}

		/**
		 * MovieClip 인스턴스의 총 프레임 수입니다.
		 */
		public function get totalFrames():int
		{
			return _movieClip.totalFrames;
		}

		/**
		 * 애니메이션 사용여부 
		 */
		public function get useAnimation():Boolean
		{
			return _useAnimation;
		}
		/**
		 * 애니메이션 사용여부 반화
		 * @param value
		 * 
		 */		
		public function set useAnimation(value:Boolean):void
		{
			_useAnimation = value;
			
			if(_useAnimation){
				clearInterval(_interval)
				_interval = setInterval(update,10)
			}else{
				clearInterval(_interval)
			}			
		}
	}
}