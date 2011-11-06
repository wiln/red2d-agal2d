package filter_ex
{
	/** 
	 * by Paik seonki / redcamel
	 * webseon@hanmail.net	 
	 */
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.RadioButton;
	import com.bit101.components.Style;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import red2D.display.Red_Sprite;
	import red2D.filter.fragmentBasic.BlackAndWhite;
	import red2D.filter.fragmentBasic.BrightFilter;
	import red2D.filter.fragmentBasic.EmbossFilter;
	import red2D.filter.fragmentBasic.InvertFilter;
	import red2D.filter.fragmentBasic.LightLevelFilter;
	import red2D.filter.fragmentBasic.MonoFilter;
	import red2D.filter.fragmentBasic.NeonSign;
	import red2D.filter.fragmentBasic.NightVisionFilter;
	import red2D.filter.fragmentUV.UV_OffsetFilter;
	import red2D.filter.fragmentUV.UV_TileFilter;
	import red2D.filter.fragmentUV.UV_Wave;
	import red2D.filter.fragmentUV.UV_ZoomFilter;
	import red2D.material.BitmapMaterial;
	import red2D.system.Red_Scene;
	

	/**
	 * Test11_UseFilter
	 * <p>Last update - Oct 28, 2011</p>
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */	
	public class Test01_UseFilters extends Red_Scene
	{
		// 맵핑 테스트를 위한 비트맵
		[Embed( source = "./resource/img.jpg" )]
		private var MapTest:Class;
		
		private var _target:Red_Sprite;
		private var _normal:RadioButton;
		private var _mono:RadioButton;
		private var _invert:RadioButton;
		private var _nightvision:RadioButton;
		private var _neonSign:RadioButton;
		
		// 현재 선택된 라디오버튼
		private var _currentRadio:RadioButton = _normal
		
		private var _lightLevel:RadioButton;
		private var _lightLevelStrength:HUISlider
		
		private var _brightLevel:RadioButton;
		private var _brightLevelStrength:HUISlider;
		private var _rStrength:HUISlider;
		private var _gStrength:HUISlider;
		private var _bStrength:Object;
		
		private var _uvZoom:RadioButton;
		private var _uvZoomCenterX:HUISlider;
		private var _uvZoomCenterY:Object;
		private var _uvZoomStrength:HUISlider;
		
		private var _uvTile:RadioButton;
		private var _tileScale:HUISlider;
		
		private var _uvOffset:RadioButton;
		private var _uvOffsetX:HUISlider;
		private var _uvOffsetY:HUISlider;
		private var _emboss:RadioButton;
		private var _embossValue:HUISlider;
		
		private var _blackAndWhite:RadioButton;
		private var _blackAndWhiteValue:Object;
		
		private var _waveValue:HUISlider;
		private var _wave:RadioButton;
		private var _waveValue2:HUISlider;
		private var _underWaterValue2:Object;
		private var _underWaterValue:Object;
		private var _underWater:RadioButton;
				
		public function Test01_UseFilters()
		{
			//TODO 예제정리필요
		}
		
		/**
		 * Red_Scene을 확장하여 setDesign을 오버라이드하여 화면을 구성합니다. 
		 * 
		 */		
		public override function setDesign():void
		{	
	
			var testMaterial:BitmapMaterial = new BitmapMaterial(new MapTest().bitmapData)
			_target = new Red_Sprite(1920,1200,stage.stageWidth/2,stage.stageHeight/2)
			_target.material = testMaterial
			addChild(_target)

			setSimpelGUI()
		}
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{
		}				
		/**
		 ***************************************************************************************************
 		 ***************************************************************************************************
		 */	
		private function setSimpelGUI():void{
			var gui:Sprite = new Sprite
			gui.graphics.beginFill(0x000000)
			gui.graphics.drawRect(10,10,200,1000)
			gui.graphics.endFill()
			stage.addChild(gui)
			gui.x=0
			gui.y=0
			Style.setStyle(Style.DARK)
			var defaultHeight:Number = 20
			var defaultY:Number = 50
				
			var guiTitle:Label = new Label(gui,20,15,"Red2D Test\nTest Filter ")
			
			_normal = new RadioButton(gui, 20, defaultHeight*0+defaultY, "normal Filter", true, changeFilter) 			
			_mono = new RadioButton(gui, 20, defaultHeight*1+defaultY, "mono Filter", false, changeFilter)
			_invert = new RadioButton(gui, 20, defaultHeight*2+defaultY, "invert Filter", false, changeFilter)
			_nightvision = new RadioButton(gui, 20, defaultHeight*3+defaultY, "nightvision Filter", false, changeFilter)
	
			_lightLevel = new RadioButton(gui, 20, defaultHeight*4.5+defaultY, "lightLevel Filter", false, changeFilter)
			_lightLevelStrength = new HUISlider(gui, 20,defaultHeight*5+defaultY, "Strength",HD_value)
			_lightLevelStrength.width=200
			_lightLevelStrength.setSliderParams(0,10,2.5)
				
			_brightLevel = new RadioButton(gui, 20, defaultHeight*6.5+defaultY, "brightLevel Filter", false, changeFilter)
			_brightLevelStrength = new HUISlider(gui, 20,defaultHeight*7+defaultY, "Strength",HD_value)
			_brightLevelStrength.width=200
			_brightLevelStrength.setSliderParams(0,2,0.3)	
				
			_neonSign = new RadioButton(gui, 20, defaultHeight*8.5+defaultY, "neonSign Filter", false, changeFilter)
			_rStrength = new HUISlider(gui, 20,defaultHeight*9+defaultY, "r",HD_value)
			_rStrength.width=200
			_rStrength.setSliderParams(0,1,0.3)	
			_gStrength = new HUISlider(gui, 20,defaultHeight*9.5+defaultY, "g",HD_value)
			_gStrength.width=200
			_gStrength.setSliderParams(0,1,0.3)	
			_bStrength = new HUISlider(gui, 20,defaultHeight*10+defaultY, "b",HD_value)
			_bStrength.width=200
			_bStrength.setSliderParams(0,1,0.3)	
				
			_uvZoom = new RadioButton(gui, 20, defaultHeight*11.5+defaultY, "uvZoom Filter", false, changeFilter)
			_uvZoomCenterX = new HUISlider(gui, 20,defaultHeight*12+defaultY, "centerX",HD_value)
			_uvZoomCenterX.width=200
			_uvZoomCenterX.setSliderParams(0,1,0.3)	
			_uvZoomCenterY = new HUISlider(gui, 20,defaultHeight*12.5+defaultY, "centerY",HD_value)
			_uvZoomCenterY.width=200
			_uvZoomCenterY.setSliderParams(0,1,0.3)	
			_uvZoomStrength = new HUISlider(gui, 20,defaultHeight*13+defaultY, "zoomScale",HD_value)
			_uvZoomStrength.width=200
			_uvZoomStrength.setSliderParams(0,1,0.3)	
				
			_uvTile = new RadioButton(gui, 20, defaultHeight*14.5+defaultY, "uvTile Filter", false, changeFilter)
			_tileScale = new HUISlider(gui, 20,defaultHeight*15+defaultY, "scale",HD_value)
			_tileScale.width=200
			_tileScale.setSliderParams(0,1,0.3)
			new Label(gui, 20, defaultHeight*15.5+defaultY, "tileFilter is Very Heavy!")
			
			_uvOffset = new RadioButton(gui, 20, defaultHeight*17+defaultY, "uvOffset Filter", false, changeFilter)
			_uvOffsetX = new HUISlider(gui, 20,defaultHeight*17.5+defaultY, "x",HD_value)
			_uvOffsetX.width=200
			_uvOffsetX.setSliderParams(0,1,0)
			_uvOffsetY = new HUISlider(gui, 20,defaultHeight*18+defaultY, "y",HD_value)
			_uvOffsetY.width=200
			_uvOffsetY.setSliderParams(0,1,0)
				
			_emboss = new RadioButton(gui, 20, defaultHeight*20+defaultY, "emboss Filter", false, changeFilter)
			_embossValue = new HUISlider(gui, 20,defaultHeight*20.5+defaultY, "value",HD_value)
			_embossValue.width=200
			_embossValue.setSliderParams(-2,2,0.5)
				
			_blackAndWhite = new RadioButton(gui, 20, defaultHeight*22+defaultY, "BlackAndWhite Filter", false, changeFilter)
			_blackAndWhiteValue = new HUISlider(gui, 20,defaultHeight*22.5+defaultY, "value",HD_value)
			_blackAndWhiteValue.width=200
			_blackAndWhiteValue.setSliderParams(0,1,0.5)
				
			_wave = new RadioButton(gui, 20, defaultHeight*24+defaultY, "wave Filter", false, changeFilter)
			_waveValue = new HUISlider(gui, 20,defaultHeight*24.5+defaultY, "waveLength",HD_value)
			_waveValue.width=200
			_waveValue.labelPrecision=2
			_waveValue.setSliderParams(0,360,1)
				
			_waveValue2 = new HUISlider(gui, 20,defaultHeight*25+defaultY, "$amplitude",HD_value)
			_waveValue2.width=200
			_waveValue2.labelPrecision=2
			_waveValue2.setSliderParams(0,100,1)
		

				
				
		}
		
		private function HD_value($e:Event=null):void
		{
			changeFilter()
		}
		
		private function changeFilter(e:Event = null):void
		{
			if(e!=null){
				_currentRadio = e.target as RadioButton
			}
				
			for(var i:int=0; i<childNum; ++i){
				var target:Red_Sprite = _target
				if (_currentRadio == _normal) {
					//필터를 사용하지않을떄는 필터는 빈 배열을 입력합니다.(null값은 허용되지 않습니다, 기본값으로 빈배열이 입력되어있습니다.)
					target.filters = []
				}
				else if (_currentRadio == _mono) {
					//필터를 적용할떄는 filters 배열을 사용하며 원하는 필터를 배열에 입력해줍니다.(기본 API방식과 동일합니다)
					target.filters = [new MonoFilter]		
				}
				else if (_currentRadio == _invert) {
					// 반전필터
					target.filters = [new InvertFilter]
				}
				else if (_currentRadio == _nightvision) {
					// 야간투시경? 필터입니다.
					target.filters = [new NightVisionFilter]
				}
				else if (_currentRadio == _lightLevel) {
					// 밝을부분강도조절
					target.filters = [new LightLevelFilter(_lightLevelStrength.value)]
				}
				else if (_currentRadio == _brightLevel) {
					// 전체밝기조절
					target.filters = [new BrightFilter(_brightLevelStrength.value)]
				}
				else if (_currentRadio == _neonSign) {
					// 네온사인
					target.filters = [new NeonSign(_rStrength.value, _gStrength.value, _bStrength.value)]
				}
				else if (_currentRadio == _uvZoom) {
					// UZ줌필터
					target.filters = [new UV_ZoomFilter(_uvZoomCenterX.value, _uvZoomCenterY.value, _uvZoomStrength.value)]
				}
				else if (_currentRadio == _uvTile) {
					// 타일필터
					target.filters = [new UV_TileFilter(_tileScale.value)]
				}
				else if (_currentRadio == _uvOffset) {
					// uvOffset필터
					target.filters = [new UV_OffsetFilter(_uvOffsetX.value,_uvOffsetY.value)]
				}
				else if (_currentRadio == _emboss) {
					// _emboss필터
					target.filters = [new EmbossFilter(_embossValue.value)]
				}
				else if (_currentRadio == _blackAndWhite) {
					// blackAndWhite필터
					target.filters = [new BlackAndWhite(_blackAndWhiteValue.value)]
				}
				else if (_currentRadio == _wave) {
					// wave필터
					target.filters = [new UV_Wave(_waveValue.value, _waveValue2.value)]
				}
	
				
			}
		}	
	}
}