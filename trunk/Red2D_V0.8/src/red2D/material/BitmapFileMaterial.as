package red2D.material
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.system.System;
	
	import red2D.system.loaders.IMGLoader;
	import red2D.util.CheckPower;

	/**  
	 * <p>외부의 Bitmap파일을 를 재질로 지정하는 Class</p>
	 * Last update - Oct 13, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 * 
	 */ 
	public class BitmapFileMaterial extends MaterialBase
	{
		/**
		 * 기본 이미지 로더 
		 */		
		private var imgLoader:IMGLoader;
		private var _srcURL:String;
		private var _format:String;
		private var _optimizeRenderToTexture:Boolean;

		private var _contentBitmapData:BitmapData;
		
		/**
		 * 생성자 
		 * @param $sourceURL
		 * @param $format
		 * @param $optimizeRenderToTexture
		 * 
		 */		
		public function BitmapFileMaterial( $sourceURL:String, $format:String = Context3DTextureFormat.BGRA, $optimizeRenderToTexture:Boolean=false)
		{	
			_srcURL = $sourceURL
			_format = $format
			_optimizeRenderToTexture = $optimizeRenderToTexture
				
			setSizeInformation(1,1)
			
			// 로딩이 안되었을때 투명으로 보이기위해 빈 비트맵테이터를 생성한다.
			_bitmapData = new BitmapData( _width , _height , true , 0x00ffffff)
			_texture= _context3d.createTexture( _width , _height , _format , _optimizeRenderToTexture );
			_texture.uploadFromBitmapData(_bitmapData);		
			
			startLoad()
		}	
		
		/**
		 * 사이즈정보값을 계산 
		 * 
		 */		
		private function setSizeInformation( $inputWidth:Number=0, $inputHeight:Number=0):void
		{
			// 실제 사이즈 입력
			_inputWidth = $inputWidth
			_inputHeight = $inputHeight
			
			// 생성할 사이즈 리턴
			_width =  CheckPower.Check(_inputWidth)
			_height = CheckPower.Check(_inputHeight)
			
			// 실제사이즈와 생성사이즈 사이의 비율을 구함
			_sizeRatioWidth =  _width/_inputWidth
			_sizeRatioHeight =  _height/_inputHeight		
			
			// 비율보간 매트릭스
			_mapRatioMatrix.scale(_sizeRatioWidth, _sizeRatioHeight)
		}		
	
		/**
		 * 외부 이미지를 로딩한다. 
		 * 
		 */		
		private function startLoad():void
		{
			//trace("실행",_loadedCount)
			imgLoader=null
			imgLoader= new IMGLoader()
			imgLoader.loadFile(_srcURL,HD_removeList,true)					
		}
		
		/**
		 * 로딩완료 체크 
		 * 
		 */		
		private function HD_removeList():void
		{
			var content:Bitmap = imgLoader.getContent() as Bitmap
			_contentBitmapData = content.bitmapData		
			
			setBitmapData()
		}
		
		/**
		 * 로딩완료후 비트맵테이터을 추출해 텍스쳐를 만든다. 
		 * 
		 */		
		private function setBitmapData():void
		{
			// 실제 사이즈 입력
			setSizeInformation(_contentBitmapData.width,_contentBitmapData.height)		
		
			_bitmapData = null
			_bitmapData = new BitmapData( _width , _height , true , 0x00ffffff)
			_bitmapData.draw(_contentBitmapData ,_mapRatioMatrix,null,null,null,true)
			
			_texture = null
			_texture= _context3d.createTexture( _width , _height , _format , _optimizeRenderToTexture );
			_texture.uploadFromBitmapData(_bitmapData);		
			
			_context3d.setTextureAt(0,_texture)
		}	
	}
}