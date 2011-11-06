package  game_ex
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import red2D.display.Red_ImageScroller;
	import red2D.display.SequenceManager;
	import red2D.display.base.Red_BlendMode;
	import red2D.filter.fragmentBasic.LightLevelFilter;
	import red2D.material.SequenceMaterial;
	import red2D.system.Red_Scene;
	import red2D.text.Red_TextField;
	
	import red2D_Particle.ParticleEmitter;
	
	/** 
	 * Test_Scene5/ Last update - Sep 19, 2011
	 * 이 데모는 단순 테스트용 데모입니다.
	 * 최적화된 코드가 아닙니다.
	 * 
	 * 이게임데모에서는 기존의 디스플레이 API와 Red2D의 API를 어떻게 적절히 혼용하여 사용하실건가에 대한 조금의 도움을 드릴수 있을것입니다.
	 * 이거까지 정리는 못하겠음매 -_-;;
	 * 누가 데모좀 만들어 주심매...
	 * @author 백선기(seon ki, paik) http://redcamel-studio.tistory.com
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 11
	 */

	public class Test_Game extends Red_Scene
	{
		[Embed( source = "../resource/particle/base.png" )]
		private  var BgParticle:Class;
		
		[Embed( source = "../resource/scrollImg/testImg1.jpg" )]
		private  var Bg:Class;
		[Embed( source = "../resource/scrollImg/cloud.png" )]
		private  var Bg2:Class;
		
		/**
		 * 플레이어 시퀀스매니져 
		 */		
		private var _player_sequence_manager:SequenceManager ;

		private var _testSequenceMaterial1:SequenceMaterial;

		/**
		 * 키보드 상태 관리 
		 */		
		private var _keyState:KeyBoardState;

		private var _testSequenceMaterial4:SequenceMaterial;
		private var _testSequenceMaterial5:SequenceMaterial;

		private var _player:Player;
		private var _scrollBg:Red_ImageScroller;
		private var _scrollBg2:Red_ImageScroller;
		private var _enemy_sequence_manager:SequenceManager;
		private var _enemyList:Array =[];

		

		private var _bulletList:Array =[];
		private var _prevSpaceState:Boolean;
		private var _testSequenceMaterial2:SequenceMaterial;
		private var _enemyTimer:Timer;
		private var _enemyMissileList:Array =[];
		private var _enemyMissileTimer:Timer;
		private var frame:Frame;
		private var _count:Count;
		private var _menu:Menu;
		private var _pointer:Pointer;
		private var _lightFilter:LightLevelFilter;
		private var _lightValue:int;
		private var _bgParticle:ParticleEmitter;

		
		
		public function Test_Game(){	

				
		}
		public override function setDesign():void
		{	
			Mouse.hide()
			setResource()
			setFrame()
			setResult()
		
			// 키보드 이벤트 및 이벤트 등록
			setKeyEventState()			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKDown);//키 눌렀을때 이벤트리스너
			stage.addEventListener( KeyboardEvent.KEY_UP, onKUp);//키 뗏을때 이벤트리스너			
			
			setMenu()
	
			//gameStart()	
			
			stage.addEventListener(Event.RESIZE, HD_Resize)
			HD_Resize()
			
		}

		
		/**
		 * 메인프레임은 일반 디스플레이 api를 사용한다. 
		 * Stage3D를 사용한다고 해서 전부를 Stage3D로 채울 필요는 없습니다.
		 * 
		 */		
		private function setFrame():void
		{
			trace("프레임세팅")
			frame = new Frame()
			stage.addChild(frame)
			frame.alpha=0
			TweenLite.to(frame,2,{alpha:0.2})
			
		}
		
		/**
		 * 점수결과판 
		 * 
		 */		
		private function setResult():void
		{
			_count = new Count(0,0,0,50)
			addChild(_count)
			_count.x=stage.stageWidth-128
		
		}
		
		/**
		 * 메뉴생성 
		 * 
		 */		
		private function setMenu():void
		{
			_menu = new Menu()
			_menu.y=-500
			addChild(_menu)
			_menu.showIntro()
			_menu.addEventListener("Start", gameStart)
			setChildIndex(_pointer,childNum-1)
		}
		
		/********************************************************************************/
		/** 리소스세팅관련 **/
		/********************************************************************************/
		/**
		 * 기본리소스 세팅 
		 * 
		 */		
		private function setResource():void
		{
			// 배경스크롤러
			_scrollBg = new Red_ImageScroller(new Bg().bitmapData,1,true)						
			// 배경스크롤러2
			_scrollBg2 = new Red_ImageScroller(new Bg2().bitmapData,1.5,true)		
			// 시퀀스 매니설정
			setSequences()
			
			_scrollBg.alpha=0
			_scrollBg2.alpha=0
				
			addChild(_scrollBg)
			addChild(_scrollBg2)
			
			_lightFilter = new LightLevelFilter(1.5)
			
			_scrollBg.filters = [_lightFilter]
			
			_pointer = new Pointer()
			addChild(_pointer)
			
			_bgParticle = new ParticleEmitter(new BgParticle().bitmapData)
			addChild(_bgParticle)
			_bgParticle.x = stage.stageWidth/2
			_bgParticle.y=-100
				
			var obj:Object = new Object();
			obj.particle_liftTime='2.5'
			obj.particle_angle='90'
			obj.maxParticleNum='130'
			obj.particle_moveSpeed='6'
			obj.emitterAreaWidth='487.2'
			obj.emitterAreaHeight='0'
			obj.particle_randomAngle=true
			obj.particle_randomAngleMin='19.91'
			obj.particle_randomAngleMax='135.59'
			obj.particle_firstScale='0'
			obj.particle_lastScale='5'
			obj.particle_speedScale='0.18'
			obj.particle_firstAlpha='1'
			obj.particle_lastAlpha='0'
			obj.particle_speedAlpha='0.07'
			obj.particle_firstRotation='62.57'
			obj.particle_lastRotation='0'
			obj.particle_speedRotation='0'
			obj.particle_waveRotation='13.92'
			obj.particle_waveAmplitude='0'
			obj.particle_waveSpeed='0'
			obj.particle_randomAngle=true
			obj.gravity='0'

			_bgParticle.setProperty(obj)
		
		}
		
	
		
		/**
		 * Red_SceneV0.8 부터는 을 updatea도 오버라이드를 필수로 하셔야합니다. 
		 * 기존에 stage에 엔터프레임 이벤트를 걸어 자원을 낭비할 필요가 없기때문입니다.
		 * update매서드를 오버라이드하여 기존의 엔터프레임에서 처리하던 명령들을 처리할 수 있습니다.
		 * 
		 */	
		public override function update():void
		{			
			
			_lightValue ++
			if(_lightValue>360){
				_lightValue=0
			}
		
			_lightFilter.lightStrength = Math.abs(Math.sin(_lightValue*Math.PI/180)*3)/2+0.6
				
			_pointer.x = stage.mouseX
			_pointer.y = stage.mouseY
			_pointer.getChildAt(1).rotation +=2
			_pointer.getChildAt(2).rotation--
		}
		
	
		
		/**
		 * 키보드 상태를 저장 
		 * 
		 */		
		private function setKeyEventState():void
		{
			_keyState= new KeyBoardState()
		}
		
		/**
		 * 시퀀스 통합관리 
		 * 
		 */		
		private function setSequences():void
		{
			// 시퀀스 매니저를 통하여 시퀀스를 통합관리합니다.
			_player_sequence_manager = new SequenceManager()				
			// 시퀀스재질을 생성합니다.
			_testSequenceMaterial1 = new SequenceMaterial("../resource/sequence/비행/","비행","png",15,1000,128,128)		
			_testSequenceMaterial2 = new SequenceMaterial("../resource/sequence/폭발/","폭발","png",15,1000,128,128)			
			// 생성된 시퀀스 재질을 시퀀스 매니저에 임의의 아이디와 함꼐 등록합니다.
			_player_sequence_manager.addSequenceMaterial("비행",_testSequenceMaterial1)
			_player_sequence_manager.addSequenceMaterial("폭발",_testSequenceMaterial2)
			
		}
		
		/********************************************************************************/
		/** 게임상태관련 **/
		/********************************************************************************/
		
		/**
		 * 게임시작 
		 * 
		 */		
		private function gameStart(e:Event=null):void
		{
			
			resetGame()
			_menu.outOfIntro()
				
			TweenLite.to(frame,1, {alpha:1})
			TweenLite.to(_pointer,1, {alpha:0})
		
		
			TweenLite.to(_scrollBg,1, {alpha:1})
			TweenLite.to(_scrollBg2,1, {alpha:0.5})
				
			
			// 적군생성
			_enemyTimer= new Timer(500,2000)
			_enemyTimer.start()
			_enemyTimer.addEventListener(TimerEvent.TIMER, addEnemy)
			
			_enemyMissileTimer= new Timer(4000,20000)
			_enemyMissileTimer.start()
			_enemyMissileTimer.addEventListener(TimerEvent.TIMER, addMissile)
			
			// 플레이어생성
			addPlayer()
			
	
			
			// 게임 상태 업데이트 시작
			stage.addEventListener(Event.ENTER_FRAME, gameStateUpdate)
		}
		
		private function resetGame():void{
			removePlayer()
			for(var i:int=0; i<_bulletList.length; ++i){
					removeChild(_bulletList[i])
			}
			_bulletList=[]
			
			// 적군이 화면 밖으로 나갔는지 판단
			for(i=0; i<_enemyList.length; ++i){
					removeChild(_enemyList[i])	
							
			}
			_enemyList=[]
			// 적군 미사일 상태 업데이트
			for(i=0; i<_enemyMissileList.length; ++i){
					removeChild(_enemyMissileList[i])	
						
			}	
			_enemyMissileList=[]
		}

		/**
		 * 게임종료 
		 * 
		 */		
		private function gameEnd():void
		{
			TweenLite.to(_pointer,1, {alpha:1})
			setChildIndex(_menu,childNum-1)
			setChildIndex(_pointer,childNum-1)
			_menu.showIntro()
			TweenLite.to(_scrollBg,1, {alpha:0.5})
			TweenLite.to(_scrollBg2,1, {alpha:0.1})
			_enemyTimer.stop()
			_enemyTimer.removeEventListener(TimerEvent.TIMER, addEnemy)

			_enemyMissileTimer.stop()
			_enemyMissileTimer.removeEventListener(TimerEvent.TIMER, addMissile)
				
			_enemyTimer=null
			_enemyMissileTimer=null
				
			// 플레이어삭제
			removePlayer()
			
			// 게임 상태 업데이트 종료
			stage.removeEventListener(Event.ENTER_FRAME, gameStateUpdate)
			System.gc()
			trace("게임종료")
		}
		
		/********************************************************************************/
		/** 유닛 **/
		/********************************************************************************/
				
		/**
		 * 적군생성 
		 * 
		 */		
		private function addEnemy( $TimerEvent:TimerEvent ):void
		{
			var _enemy:Enemy = new Enemy(64,64,stage.stageWidth*Math.random(),-150)
			addChild(_enemy)

			_enemy.setSequence("비행",_player_sequence_manager)	
			_enemy.rotation=180
			_enemyList.push(_enemy)
		}
		
		/**
		 * 적군삭제
		 * @param e
		 * 
		 */		
		private function removeEnemy(e:*):void{
			removeChild(e)
			_enemyList.splice(_enemyList.indexOf(e),1)			
		}
		
		/**
		 * 플레이어생성 
		 * 
		 */		
		private function addPlayer():void
		{
			
			_player = new Player(128,128,stage.stageWidth/2,stage.stageHeight/2)
			//_player.drawDebugCollision=true
			addChild(_player)			
			_player.setSequence("비행",_player_sequence_manager)	
		}
		
		/**
		 * 적군미사일 
		 * @param $TimerEvent
		 * 
		 */		
		private function addMissile( $TimerEvent:TimerEvent=null ):void
		{
			var i:int =0
			for(i=0; i<_enemyList.length; ++i){
				var missile:EnemyMissile = new EnemyMissile(8,8,_enemyList[i].x, _enemyList[i].y)
					addChild(missile)
					_enemyMissileList.push(missile)
			}			
		}		
		
		/**
		 * 플레이어 삭제 
		 * 
		 */		
		private function removePlayer():void
		{
			if(_player!=null){
			removeChild(_player)
			_player= null
		}
		}		
		
		
		/**
		 * 게임 상태 업데이트 
		 * @param event
		 * 
		 */		
		protected function gameStateUpdate(event:Event):void
		{
			// 배경 스크롤러 상태 업데이트
			_scrollBg.update()
			// 배경 스크롤러 상태 업데이트2
			_scrollBg2.update()
			_bgParticle.update()
			// 플레이어 키보드 상태 업데이트
			_player.keyStateUpdate(_keyState)
			// 플레이어 상태 업데이트
			_player.update()		
				
				
			// 총알생성판정
			if(_keyState.space && _prevSpaceState==false){	
				var bulletItem:Missile = new Missile(20,20,_player.x-50, _player.y-20)
				bulletItem.blendMode=Red_BlendMode.ADD
				_bulletList.push(bulletItem)
				addChild(bulletItem)
				
				var bulletItem2:Missile = new Missile(20,20,_player.x+50, _player.y-20)
				bulletItem2.blendMode=Red_BlendMode.ADD
				_bulletList.push(bulletItem2)
				addChild(bulletItem2)
				
				var bulletItem3:Missile = new Missile(10,10,_player.x, _player.y-20)
				bulletItem3.blendMode=Red_BlendMode.ADD
				_bulletList.push(bulletItem3)
				addChild(bulletItem3)
				_prevSpaceState = true
			}
			
			// 총알 상태 업데이트
			for(var i:int=0; i<_bulletList.length; ++i){
				_bulletList[i].update()					
				if(_bulletList[i].y<-10){
					removeChild(_bulletList[i])
					_bulletList.splice(i,1)
				}
			}
							
	
			var _maxY:int = stage.stageHeight
			var _currentTimer:int = getTimer()
			// 플레이이어 미사일과 적군 충돌 테스트
			for(i=0; i<_enemyList.length; ++i){
				for(var j:int=0; j<_bulletList.length; ++j){				
					var target:Enemy = _enemyList[i]
					if(target.checkCollison(_bulletList[j].rect)){
						if(target.dead==false){
							target.setSequence("폭발",_player_sequence_manager)	
							target.dead=true
							_count.addCount((Math.random()*100))
							TweenMax.to(target,1, {scaleX:1, scaleY:1, ease:Back.easeInOut, onComplete:removeEnemy, onCompleteParams:[target]})
						}						
					}
				}					
				_enemyList[i].update()					
			}
			// 적군 미사일과 플레이어 충돌 테스트
			for(i=0; i<_enemyMissileList.length; ++i){				
				if(_player.checkCollison(_enemyMissileList[i].rect)){
					if(_player.dead==false){
						_player.setSequence("폭발",_player_sequence_manager)	
						_player.dead=true
						TweenMax.to(_player,1, {scaleX:1, scaleY:1, ease:Back.easeInOut, onComplete:gameEnd})
					}
				}				
			}
			
			// 적군이 화면 밖으로 나갔는지 판단
			for(i=0; i<_enemyList.length; ++i){
				if(_enemyList[i].y > _maxY+100){
					removeChild(_enemyList[i])	
					_enemyList.splice(i,1)					
				}
			}
			
			// 적군 미사일 상태 업데이트
			for(i=0; i<_enemyMissileList.length; ++i){
				_enemyMissileList[i].update()
				if(_enemyMissileList[i].y > _maxY+100){
					removeChild(_enemyMissileList[i])	
					_enemyMissileList.splice(i,1)					
				}
			}			
		}		
		
	
		/********************************************************************************/
		/** 키보드 이벤트 **/
		/********************************************************************************/ 
		protected function onKUp(e:KeyboardEvent):void
		{
			if ( e.keyCode == 68 ) _keyState.rightKey = false;
			if ( e.keyCode == 65 )  _keyState.leftKey = false;
			if ( e.keyCode == 83 )  _keyState.downKey = false;
			if ( e.keyCode == 87 )  _keyState.upKey = false;
			if ( e.keyCode == Keyboard.SPACE )  _keyState.space = false;
			_prevSpaceState=false
		}
		
		protected function onKDown(e:KeyboardEvent):void
		{
			if ( e.keyCode == 68 )	{
				_keyState.rightKey = true;	
		
			}
			if ( e.keyCode == 65 )	{
				_keyState.leftKey = true;		
		
			}
			if ( e.keyCode == 83 ) {
				_keyState.downKey = true;	

			}
			if ( e.keyCode == 87 ) {
				_keyState.upKey = true;		
	
			}
			if ( e.keyCode == Keyboard.SPACE ) {
				_keyState.space = true;	
	
			}
		}
		
		protected function HD_Resize(event:Event=null):void
		{
			_count.x= stage.stageWidth- 128
			_menu.x = stage.stageWidth/2
		}
	
	}
}

