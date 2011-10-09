package red2D.material
{
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.getTimer;
	
	import red2D.system.loaders.IMGLoader;
	import red2D.system.Red2D;

	/**  
	 * <p>시퀀스이미지들을 재질로 지정하는 Class</p>
	 * Last update - July 25, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 * 
	 */ 
	public class SequenceMaterial extends MaterialBase
	{
		private var _count:int;

		
		/**
		 * 시퀀스 로딩 대상 파일  리스트 
		 */			
		private var _loadFileList:Array=[]
		
		/**
		 * 실제 시퀀스 리스트 
		 */			
		private var _sequenceList:Array=[]
		
		/**
		 * 로딩완료된 이미지카운트 
		 */			
		private var _loadedCount:Number=0
		private var _allLoaded:Boolean=false
		private var _rect:Rectangle 
		private var _point:Point = new Point

		private var _second:int;
		private var imgLoader:IMGLoader;


		/**
		 * 
		 * @param $sequencePath
		 * @param $sequenceName
		 * @param $imageType
		 * @param $count
		 * @param $second
		 * @param $width
		 * @param $height
		 * 
		 */		
		public function SequenceMaterial(  $sequencePath:String="../res/", $sequenceName:String="", $imageType:String="png", $count:int =0, $second:int=1000, $width:Number=128, $height:Number=128)
		{
			_width = $width
			_height = $height
			_rect =new Rectangle(0,0,_width,_height)
				
			_count = $count
			_second = $second/10
				
			_loadFileList = _sequenceList =  null
			_loadFileList  = []
			_sequenceList  = []
				
			var i:int
			var totalPath:String 

			for( i=0; i<$count; ++i){
			
				totalPath=String(i)
				while( totalPath .length < 4 ){ totalPath = "0"+ totalPath  }
				totalPath =  $sequencePath + $sequenceName + totalPath + "." + $imageType
				
				_loadFileList.push(totalPath)
				_sequenceList.push(new BitmapData( _width , _height , true , 0x00ffffff))

			}		
			_bitmapData = new BitmapData( _width , _height , true , 0x00ffffff)			
			_context3d = Red2D.targetContext3d			
			_texture= _context3d.createTexture( _width , _height , Context3DTextureFormat.BGRA , false );
			_texture.uploadFromBitmapData( _bitmapData);	
			startLoad()			
			
	
			
		}	
		
		private function startLoad():void
		{
			//trace("실행",_loadedCount)
			imgLoader=null
			imgLoader= new IMGLoader()
			imgLoader.loadFile(_loadFileList[_loadedCount],HD_removeList,false)					
		}
		
		/**
		 * program3D 설정 
		 * 
		 */		
		public override function setProgram( ):void{
			// 기존 프로그램3d와 현재 재질의 프로그램3D가 같은지 체크
			if(	_programData.currentShaderType != _shaderType){
				// 다를 경우 현재 프로그램으로 대체하고 상태를 갱신합니다.
				_programData.setShaderProgram3D(_shaderType)
				_context3d.setProgram(_programData.getShaderProgram3D())		
			}
			if(_allLoaded){
			
				if(prevCheckTime != checkTime){				
					_bitmapData.copyPixels(_sequenceList[checkTime],_rect,_point)				
					_texture.uploadFromBitmapData( _bitmapData);
				}
				
			}
			
			_context3d.setTextureAt(0,_texture)
				
			
		}	
		/////////////////////////////////////////////////////////////////////////////////////////////////////

		
		/**
		 * 전체로딩완료확인 
		 * @param e
		 * 
		 */		
		private function HD_removeList( $event:Event=null ):void
		{
	
			_sequenceList[_loadedCount].fillRect(_rect,0x00ffffff)
			_sequenceList[_loadedCount].copyPixels(imgLoader.getContent().bitmapData,_rect,_point)
				
			_loadedCount++
			if(_loadedCount==_count){
				trace("시퀀스로딩완료")
				_loadFileList=null
				_allLoaded=true
				
				// 첫장면을 미리등록해둔다...딜레이방지
				_bitmapData.fillRect(_rect,0x00ffffff)
				_bitmapData.copyPixels(_sequenceList[0],_rect,_point)
				prevCheckTime =  _count
				System.gc()
					
			}else{
				startLoad()
			}
	
		}

		public function get count():int
		{
			return _count;
		}

		public function get second():int
		{
			return _second;
		}

		


	}
}