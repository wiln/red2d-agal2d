package particle_ex 
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.ComboBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.TextArea;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import red2D_Particle.ParticleEmitter;
	
	/** 
	 * <p>입자 방출기 속성값 테스터</p>
	 * <p>Last update - Oct 16, 2011</p>
	 * @author 백선기(seon ki, paik) / http://redcamel-studio.tistory.com
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 * @playerversion AIR 3.0 
	 */
	public class Controller extends Sprite
	{
		private var _target:ParticleEmitter;

		private var huiSlider_randomAngle:CheckBox;
		private var huiSlider_waveStartRotationRandom:CheckBox;

		private var huiSlider_liftTime:HUISlider;

		private var huiSlider_angle:HUISlider;

		private var huiSlider_Particle:HUISlider;

		private var huiSlider_moveSpeed:HUISlider;

		private var huiSlider_emitterWidth:HUISlider;

		private var huiSlider_emitterHeight:HUISlider;

		private var huiSlider_angleRandomMin:HUISlider;

		private var huiSlider_angleRandomMax:HUISlider;

		private var huiSlider_scale_first:HUISlider;

		private var huiSlider_scale_last:HUISlider;

		private var huiSlider_scale_speed:HUISlider;

		private var huiSlider_alpha_first:HUISlider;

		private var huiSlider_alpha_last:HUISlider;

		private var huiSlider_alpha_speed:HUISlider;

		private var huiSlider_gravity:HUISlider;
		
		/**
		 * 속성전체를 파악하기위한 배열 
		 */		
		private var propertyArray:Array = []

		private var propertyTxt:TextArea;
		private var huiSlider_wave_first:HUISlider;
		private var huiSlider_last_first:Object;
		private var huiSlider_wave_speed:Object;
		private var huiSlider_rotation_first:HUISlider;
		private var huiSlider_rotation_last:Object;
		private var huiSlider_rotation_speed:Object;
		private var huiSlider_wave_direction:ComboBox;

		
		public function Controller( $target:ParticleEmitter )
		{
			_target = $target
			addEventListener(Event.ADDED_TO_STAGE, setUI)
			
		}
		
		private function setUI(e:Event):void
		{
			var gui:Sprite = new Sprite
			stage.addChild(gui)
				
			// 라이프타임
			huiSlider_liftTime=new HUISlider(gui,10,10,"particle_liftTime",setValue)
			huiSlider_liftTime.setSliderParams(0,4,_target.particle_liftTime)	
			propertyArray.push(huiSlider_liftTime)				
			huiSlider_liftTime.labelPrecision=4
				
			// 생성방향
			huiSlider_angle=new HUISlider(gui,150,87,"particle_angle",setValue)
			huiSlider_angle.setSliderParams(0,360,_target.particle_angle)
			propertyArray.push(huiSlider_angle)
			huiSlider_angle.labelPrecision=4
				
			// 최대 파티클갯수
			huiSlider_Particle=new HUISlider(gui,10,50,"maxParticleNum",setValue)
			huiSlider_Particle.setSliderParams(0,150,_target.maxParticleNum)
			propertyArray.push(huiSlider_Particle)
				
				
			
			// 스피드
			huiSlider_moveSpeed=new HUISlider(gui,200,10,"particle_moveSpeed",setValue)
			huiSlider_moveSpeed.setSliderParams(0,20,_target.particle_moveSpeed)
			huiSlider_moveSpeed.width=250
			propertyArray.push(huiSlider_moveSpeed)
			huiSlider_moveSpeed.labelPrecision=4
				
			// 입자방출영역
			huiSlider_emitterWidth=new HUISlider(gui,200,30,"emitterAreaWidth",setValue)
			huiSlider_emitterWidth.setSliderParams(0,1680,_target.emitterAreaWidth)
			huiSlider_emitterWidth.width=250
			propertyArray.push(huiSlider_emitterWidth)
				
			// 입자방출영역
			huiSlider_emitterHeight=new HUISlider(gui,200,50,"emitterAreaHeight",setValue)
			huiSlider_emitterHeight.setSliderParams(0,1280,_target.emitterAreaHeight)
			huiSlider_emitterHeight.width=250
			propertyArray.push(huiSlider_emitterHeight)
				
			//////////////////////////////////////////////////////////////////////////////////////
				
			// 생성방향 랜덤설정
			huiSlider_randomAngle=new CheckBox(gui,10,90,"particle_randomAngle", HD_randomAngle)
			huiSlider_randomAngle.selected=_target.particle_randomAngle
			propertyArray.push(huiSlider_randomAngle)
				
			// 생성방향 범위
			huiSlider_angleRandomMin=new HUISlider(gui,10,110,"particle_randomAngleMin",setValue)
			huiSlider_angleRandomMin.width=350
			huiSlider_angleRandomMin.setSliderParams(-360,360,_target.particle_randomAngleMin)
			propertyArray.push(huiSlider_angleRandomMin)
			
			// 생성방향 범위
			huiSlider_angleRandomMax=new HUISlider(gui,10,130,"particle_randomAngleMax",setValue)
			huiSlider_angleRandomMax.width=350
			huiSlider_angleRandomMax.setSliderParams(-360,360,_target.particle_randomAngleMax)
			propertyArray.push(huiSlider_angleRandomMax)
						
			//////////////////////////////////////////////////////////////////////////////////////
				
					
			//////////////////////////////////////////////////////////////////////////////////////
				
			// 스케일 설정
			huiSlider_scale_first=new HUISlider(gui,10,170,"particle_firstScale",setValue)
			huiSlider_scale_first.labelPrecision=4
			huiSlider_scale_first.width=350
			huiSlider_scale_first.setSliderParams(0,5,_target.particle_firstScale)
			propertyArray.push(huiSlider_scale_first)
				
			
			// 스케일 설정
			huiSlider_scale_last=new HUISlider(gui,10,190,"particle_lastScale",setValue)
			huiSlider_scale_last.labelPrecision=4
			huiSlider_scale_last.width=350
			huiSlider_scale_last.setSliderParams(0,5,_target.particle_lastScale)
			propertyArray.push(huiSlider_scale_last)
			
			// 스케일 설정
			huiSlider_scale_speed=new HUISlider(gui,10,210,"particle_speedScale",setValue)
			huiSlider_scale_speed.labelPrecision=4
			huiSlider_scale_speed.width=350
			huiSlider_scale_speed.setSliderParams(0,1,_target.particle_speedScale)
			propertyArray.push(huiSlider_scale_speed)
				
			//////////////////////////////////////////////////////////////////////////////////////
			
			// 알파 설정
			huiSlider_alpha_first=new HUISlider(gui,10,250,"particle_firstAlpha",setValue)
			huiSlider_alpha_first.labelPrecision=4
			huiSlider_alpha_first.width=350
			huiSlider_alpha_first.setSliderParams(0,1,_target.particle_firstAlpha)
			propertyArray.push(huiSlider_alpha_first)
			
			// 알파 설정
			huiSlider_alpha_last=new HUISlider(gui,10,270,"particle_lastAlpha",setValue)
			huiSlider_alpha_last.labelPrecision=4
			huiSlider_alpha_last.width=350
			huiSlider_alpha_last.setSliderParams(0,1,_target.particle_lastAlpha)
			propertyArray.push(huiSlider_alpha_last)
			
			// 알파 설정
			huiSlider_alpha_speed=new HUISlider(gui,10,290,"particle_speedAlpha",setValue)
			huiSlider_alpha_speed.labelPrecision=4
			huiSlider_alpha_speed.width=350
			huiSlider_alpha_speed.setSliderParams(0,1,_target.particle_speedAlpha)		
			propertyArray.push(huiSlider_alpha_speed)
			huiSlider_alpha_speed.labelPrecision=4

			//////////////////////////////////////////////////////////////////////////////////////
			
			// rotation 설정
			huiSlider_rotation_first=new HUISlider(gui,10,330,"particle_firstRotation",setValue)
			huiSlider_rotation_first.labelPrecision=4
			huiSlider_rotation_first.width=350
			huiSlider_rotation_first.setSliderParams(0,360,_target.particle_firstRotation)
			propertyArray.push(huiSlider_rotation_first)
			
			// rotation 설정
			huiSlider_rotation_last=new HUISlider(gui,10,350,"particle_lastRotation",setValue)
			huiSlider_rotation_last.labelPrecision=4
			huiSlider_rotation_last.width=350
			huiSlider_rotation_last.setSliderParams(0,360,_target.particle_lastRotation)
			propertyArray.push(huiSlider_rotation_last)
			
			// rotation 설정
			huiSlider_rotation_speed=new HUISlider(gui,10,370,"particle_speedRotation",setValue)
			huiSlider_rotation_speed.labelPrecision=4
			huiSlider_rotation_speed.width=350
			huiSlider_rotation_speed.setSliderParams(0,1,_target.particle_speedRotation)		
			propertyArray.push(huiSlider_rotation_speed)
				
			//////////////////////////////////////////////////////////////////////////////////////
			
			// wave설정
			huiSlider_wave_first=new HUISlider(gui,10,410,"particle_waveRotation",setValue)
			huiSlider_wave_first.labelPrecision=4
			huiSlider_wave_first.width=350
			huiSlider_wave_first.setSliderParams(0,360,_target.particle_waveRotation)
			propertyArray.push(huiSlider_wave_first)
			
			// wave 설정
			huiSlider_last_first=new HUISlider(gui,10,430,"particle_waveAmplitude",setValue)
			huiSlider_last_first.labelPrecision=4
			huiSlider_last_first.width=350
			huiSlider_last_first.setSliderParams(0,100,_target.particle_waveAmplitude)
			propertyArray.push(huiSlider_last_first)
			
			// wave 설정
			huiSlider_wave_speed=new HUISlider(gui,10,450,"particle_waveSpeed",setValue)
			huiSlider_wave_speed.labelPrecision=4
			huiSlider_wave_speed.width=350
			huiSlider_wave_speed.setSliderParams(0,100,_target.particle_waveSpeed)		
			propertyArray.push(huiSlider_wave_speed)
				
			new Label(gui,10,470,"waveDirection")
			// wave 설정
			huiSlider_wave_direction=new ComboBox(gui,105,470,"VERTICAL",["HORIZON","VERTICAL"])
			huiSlider_wave_direction.width=200
			propertyArray.push(huiSlider_wave_direction)
				
			huiSlider_wave_direction.addEventListener(Event.SELECT, HD_select)
				
			// 중력
			huiSlider_gravity=new HUISlider(gui,10,530,"gravity",setValue)
			huiSlider_gravity.setSliderParams(0,10,_target.gravity)	
			huiSlider_gravity.width=350
			propertyArray.push(huiSlider_gravity)
				
			var propertyBt:PushButton = new PushButton(gui,10,560,"getEmitterProperty", HD_getProperty)
			propertyTxt = new TextArea(gui,10,580,"click getEmitterProperty Button")
				
		
		}
		

		
		/********************************************************************************/
		/** 속성 추출 매서드 **/
		/********************************************************************************/	
		public function getEmitterPropertyArray():String{
			var str:String ="Propery List! - use make Particle Preset\n"
				str+="var obj:Object = new Object();\n"

			for each(var child:* in propertyArray){
				if(child is HUISlider){
					str += "obj."+child.label + "='" + child.value +"'\n"
				}else if(child is CheckBox){
					str += "obj."+child.label + "=" + child.selected +"\n"
				}else if(child is ComboBox){
					str += "obj.particle_randomAngle" + "=" + huiSlider_randomAngle.selected +"\n"
				}else{
					throw new Error("minimacomp 타입중 컨트롤러에 등록되지않은타입입니다")
				}	
				
				
			}
			return str
		}
		
		
		/********************************************************************************/
		/** 핸들러 **/
		/********************************************************************************/	
		protected function HD_select($event:Event):void
		{
			_target.particle_waveDirection =  String(huiSlider_wave_direction.selectedItem)
		}
		private function HD_randomAngle( $e:Event = null):void
		{
			propertyTxt.text="click getEmitterProperty Button!"
			_target.particle_randomAngle =  huiSlider_randomAngle.selected
		}
		
		private function setValue($e:Event=null):void
		{
			propertyTxt.text="click getEmitterProperty Button!"
			_target[$e.currentTarget.label] = $e.currentTarget.value			
		}
		
		protected function HD_getProperty(event:MouseEvent):void
		{
			trace(getEmitterPropertyArray())
			propertyTxt.text = getEmitterPropertyArray()
		}
	}
}
