package com.panel
{
	import com.core.GameData;
	import com.core.Gesture;
	import com.core.ItemManager;
	import com.core.KeyManager;
	import com.core.Player;
	import com.core.Tutorial;
	import com.core.UI;
	import com.greensock.TweenLite;
	import com.manager.SoundManager;
	import com.utils.event.CustomEvent;
	import com.utils.event.EventCenter;
	import com.utils.resource.ResourceData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class IndexPanel extends Sprite
	{
		private var _sm:SoundManager = SoundManager.getInstance();
		private var _coreView:Sprite;
		private var _view:Sprite;
		private var _ui:UI;
		private var _tutorial:Tutorial;
		private var _mist:Sprite;
		private var _getter:MovieClip;
		private var _targetX:Number;
		private var _tween:TweenLite;
		private var _player:Player;
		private var _km:KeyManager;
		private var _im:ItemManager;
		private var _cloud:Sprite;
		private var _level:int;
		private var _gesture:Gesture;
		
		public function IndexPanel()
		{
			this._view = ResourceData.getInstance().getResouse("IndexPanel") as Sprite;
			addChild(this._view);
			
			this._mist = new Sprite();
			this._mist.graphics.beginFill(0, 0);
			this._mist.graphics.drawRect(0, 0, 800, 480);
			this._mist.graphics.endFill();
			this._mist.visible = false;
			addChild(this._mist);
			
			this._tutorial = new Tutorial(this._view["tutorial"]);
			this._ui = new UI(this._view["ui"]);
			
			_coreView = _view["core"];
			_coreView.mouseChildren = false;
			_coreView.mouseEnabled = false;
			
			_cloud = _view["cloud"];
			//_cloud.cacheAsBitmap = true;
			_cloud.mouseChildren = false;
			_cloud.mouseEnabled = false;
			
			_player = new Player(_coreView["player"]);
			
			EventCenter.addEventListener(CustomEvent.PREPARE, onGamePrepare);
			EventCenter.addEventListener(CustomEvent.START, onGameStart);
			EventCenter.addEventListener(CustomEvent.GAMEOVER, onTimeUp);
		}
		
		public function init():void
		{
			_tutorial.init();
			_coreView.visible = false;
			_ui.hide();
			_cloud.visible = false;
		}
		
		public function onEnter():void
		{
			_km = _km || new KeyManager(stage);
			_km.clear();
			
			_im = _im || new ItemManager(_coreView, _player);
			
			if (!GameData.IS_WIN)
			{
				_gesture = _gesture || new Gesture(stage);
			}
			
			_tutorial.tutorialHandler();
		}
		
		private function onGamePrepare(e:CustomEvent):void
		{
			_level = int(e.data);
			// 關卡準備
			_ui.init();
			_ui.show();
			_ui.setTitle(_level);
			_coreView.visible = true;
			_player.init();
			_im.clear();
			
			if (!GameData.IS_WIN)
			{
				_gesture.clear();
			}
			
			switch (_level)
			{
				case 1: 
					_ui.setTime(10);
					_ui.setItemCount(1, 1);
					_ui.setItemCount(2, 1);
					_ui.setItemCount(3, 1);
					_ui.setItemCount(4, 1);
					_im.setCmd([1, 2, 3, 4]);
					break;
				case 2: 
					_ui.setTime(10);
					_ui.setItemCount(2, 5);
					_im.setCmd([2]);
					break;
				case 3: 
					_ui.setTime(20);
					_ui.setItemCount(1, 3);
					_ui.setItemCount(2, 3);
					_ui.setItemCount(3, 3);
					_ui.setItemCount(4, 3);
					_im.setCmd([1, 2, 3, 4]);
					break;
				case 4: 
					_ui.setTime(20);
					_ui.setItemCount(1, 5);
					_ui.setItemCount(3, 4);
					_im.setCmd([1, 3], true);
					break;
				case 5: 
					_ui.setTime(30);
					_ui.setItemCount(1, 4);
					_ui.setItemCount(2, 4);
					_ui.setItemCount(3, 4);
					_ui.setItemCount(4, 4);
					_ui.setItemCount(5, 2);
					_im.setCmd([1, 2, 3, 4, 5], true);
					break;
			}
		}
		
		private function onGameStart(e:CustomEvent):void
		{
			_tutorial.hide();
			_ui.startTime();
			_cloud.visible = Boolean([0, 0, 1, 1, 1][_level - 1]);
			_im.start();
			if (_gesture)
				_gesture.start();
			GameData.KEY_ACTIVE = true;
			this.addEventListener(Event.ENTER_FRAME, onframe);
		}
		
		private function onframe(e:Event):void
		{
			checkKeyHandler();
			_player.render();
			_im.render();
		}
		
		private function checkKeyHandler():void
		{
			if (!GameData.KEY_ACTIVE)
				return;
			
			if (GameData.IS_WIN)
			{
				if (_km.isPress(Keyboard.A) || _km.isPress(Keyboard.LEFT))
				{
					_player.goLeft();
				}
				
				if (_km.isPress(Keyboard.D) || _km.isPress(Keyboard.RIGHT))
				{
					_player.goRight();
				}
				
				if (_km.isPress(Keyboard.W) || _km.isPress(Keyboard.UP))
				{
					_player.jump();
				}
			}
			else
			{
				if (_gesture.isLeft())
				{
					_player.goLeft();
				}
				else if (_gesture.isRight())
				{
					_player.goRight();
				}
				
				if (_gesture.isUp())
				{
					_player.jump();
				}
			}
		}
		
		// 時間到 檢查是否過關
		private function onTimeUp(e:CustomEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, onframe);
			
			GameData.KEY_ACTIVE = false;
			if (_gesture)
				_gesture.stop();
			_coreView.visible = false;
			_tutorial.show();
			_cloud.visible = false;
			_im.clear();
			_ui.stopTime();
			
			if (_ui.checkPass() && (e.data != "die"))
			{
				_tutorial.pass();
			}
			else
			{
				_tutorial.pass(false);
			}
		}
	}
}
