package red2D.util{
	
	import flash.text.Font;

	/**  
	 * embed한 폰트 리스트를 알아내는 클래스
	 * <p>Date -2010.05.10</p>
	 * @author 백선기(seon ki, paik), http://redcamel-studio.tistory.com
	 */  

	public class InitFontView {

		public function InitFontView () {
		}

		/**
		 * 
		 * @return Embed된 폰트리스트를 반환한다. 
		 * 
		 */		
		public static function getInfo ():String {


			trace ("/////////// view embed font List - start /////////////");
			var fontList:Array = Font.enumerateFonts();
			var font:Font;
			var str:String = "";
			for each (font in fontList)
			{
				str +=  font.fontName + " / ";
			}
			trace (str);
			trace ("/////////// view embed font List - end /////////////");
			return (str);
		}
	}

}