package game_ex
{
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import red2D.display.Red_Sprite;
	import red2D.text.Red_TextField;
	import red2D.material.BitmapMaterial;
	import red2D.system.Red2D;
	import red2D.util.InitFontView;
	
	/** 
	 * Count/ Last update - Oct 4, 2011
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */
	public class Count extends Red_Sprite
	{
		[Embed( source = "./resource/game/result.png" )]
		private var Result:Class;
		
		// 폰트는  swc형태로 지작하여 불러온다.
		Font.registerFont(NanumGothic)
		// 리스트에 출력되는 폰트명들이 임베드 출력가능한 폰트네임이다.
		
		// 임베드된 폰트목록을 체크한다.
		InitFontView.getInfo()
			
		private var _result:Red_TextField;
		private var _formatText:TextFormat;
		private var _total:int=0
		private var _bg:Red_Sprite;
		private var _bgMaterial:BitmapMaterial;

	
		public function Count($width:Number=0, $height:Number=0, $x:Number=0, $y:Number=0)
		{
			super($width, $height, $x, $y);
			setDesign()
		}
		
		private function setDesign():void
		{			
			_bg = new Red_Sprite(256,64,0,0)
			_bgMaterial = new BitmapMaterial(new Result().bitmapData)	
			_bg.material = _bgMaterial
			addChild(_bg)
				
			_result = new Red_TextField()
			addChild(_result)
			_result.embedFonts =true			
	
			_formatText= new TextFormat();
			_formatText.font =  "NanumGothic ExtraBold"
			_formatText.size =14
			_result.setTextFormat(_formatText)
				
			_result.align="left"
			_result.text="GameScore"+"\nResult : "+_total
				
			_result.x=-50
			_result.y=0
	
		}
		
		private function updateText( $msg:String ):void{
			_result.text=$msg
		}
		
		public function addCount( $num:Number=0):void{
			_total += $num
			_result.text="GameScore"+"\nResult : "+_total
/*			updateText(l)*/
		}
	}
}

