package com.panel
{
	import com.core.GameData;
	import com.core.ItemContainer;
	import com.core.key.KeyManager;
	import com.core.key.KeyManagerEvent;
	import com.core.Tutorial;
	import com.core.UI;
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import com.manager.SoundManager;
	import com.utils.event.CustomEvent;
	import com.utils.event.EventCenter;
	import com.utils.resource.ResourceData;
	import com.utils.Tools;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class IndexPanel extends Sprite
	{
		static public var TURN_SPEED:Number = 1;
		
		private var _sm:SoundManager = SoundManager.getInstance();
		private var _view:Sprite;
		private var _ui:UI;
		private var _tutorial:Tutorial;
		private var _paw:Sprite;
		private var _getter:MovieClip;
		private var _turnIndex:int;
		
		private var _stats:int;
		private var _tween:TweenLite;
		private var _key:KeyManager;
		private var _downTime:int;
		private var _level:int;
		private var _ic:ItemContainer;
		private var _item:MovieClip;
		private var _getterHitBall:Sprite;
		private var _getterItem:MovieClip;
		
		private var _pawBtn:Sprite;
		private var _boomBtn:Sprite;
		
		public function IndexPanel()
		{
			this._view = ResourceData.getInstance().getResouse("IndexPanel") as Sprite;
			addChild(this._view);
			
			_tutorial = new Tutorial(this._view["tutorial"]);
			_ui = new UI(this._view["ui"]);
			
			_paw = _view["paw"];
			_getter = Tools.ArrangeDisplayer(_paw["getter"]);
			_getterHitBall = Tools.ArrangeDisplayer(_getter["hitball"]);
			_getterItem = Tools.ArrangeDisplayer(_getter["item"]);
			_getterItem.gotoAndStop(1);
			_getterItem.visible = false;
			
			_ic = new ItemContainer(_view["itemContainer"]);
			
			TweenLite.defaultEase = Linear.easeNone;
			EventCenter.addEventListener(CustomEvent.PREPARE, onGamePrepare);
			EventCenter.addEventListener(CustomEvent.START, onGameStart);
			EventCenter.addEventListener(CustomEvent.TIMEUP, onTimeUp);
			
			if (!GameData.IS_WIN)
			{
				_pawBtn = _view["pawBtn"];
				_boomBtn = _view["boomBtn"];
				_pawBtn.addEventListener(MouseEvent.CLICK, onBtnHandler);
				_boomBtn.addEventListener(MouseEvent.CLICK, onBtnHandler);
			}
		}
		
		public function init():void
		{
			_tutorial.init();
			_ui.hide();
			_ic.clear();
			_level = 1;
		}
		
		public function onEnter():void
		{
			if (!_key)
			{
				_key = new KeyManager(stage);
				_key.addKey(["up"]); // 38
				_key.addKey(["down"]); // 40
				_key.addKey([Keyboard.W]); // 87
				_key.addKey([Keyboard.S]); // 83
			}
			
			GameData.KEY_ACTIVE = false;
			_key.addEventListener(KeyManagerEvent.KEY_DOWN, onKeyHandler);
			
			_tutorial.tutorialHandler();
		}
		
		private function onGamePrepare(e:CustomEvent):void
		{
			_level = int(e.data);
			_ic.prepare(_level);
			_downTime = 2;
			_stats = 1;
			resetGetter();
			
			switch (_level)
			{
				case 1: 
					_ui.setParameters(25, 1500, 2000, _level);
					break;
				case 2: 
					_ui.setParameters(25, 1900, 2100, _level);
					break;
				case 3: 
					_ui.setParameters(25, 1900, -1, _level);
					break;
			}
		}
		
		private function resetGetter():void
		{
			TweenLite.killTweensOf(_getter);
			_getter.y = 60;
			_getter.gotoAndStop(1);
			_paw.x = 400;
			_turnIndex = 0;
			_paw.rotation = 0;
			_getterItem.visible = false;
		}
		
		private function onGameStart(e:CustomEvent):void
		{
			// 關卡
			_ui.startTime();
			_ic.show();
			_tutorial.hide();
			
			GameData.KEY_ACTIVE = true;
			this.addEventListener(Event.ENTER_FRAME, onframe);
		}
		
		private function onBtnHandler(e:MouseEvent):void
		{
			if (!GameData.KEY_ACTIVE)
				return;
			
			if (e.currentTarget == _pawBtn)
			{
				onPawHandler();
			}
			else
			{
				onGetHandler();
			}
		}
		
		private function onKeyHandler(e:KeyManagerEvent):void
		{
			if (!GameData.KEY_ACTIVE)
				return;
			
			if (e.keyCombo[0] == 40 || e.keyCombo[0] == 83) // ↓
			{
				onPawHandler();
			}
			else if (e.keyCombo[0] == 38 || e.keyCombo[0] == 87) // ↑
			{
				onGetHandler();
			}
		}
		
		private function onPawHandler():void
		{
			if (_stats == 1)
			{
				_stats = 2;
				_tween = TweenLite.to(_getter, _downTime, {y: 500, onComplete: revoke});
			}
		}
		
		private function onGetHandler():void
		{
			// 抓取上升期間 才可以丟炸彈
			if (_stats == 0 && _item)
			{
				_getterItem.visible = false;
				_ic.showBoom(_getter.localToGlobal(new Point(_getterItem.x, _getterItem.y)));
				_item = null;
			}
		}
		
		private function onframe(e:Event):void
		{
			switch (_stats)
			{
				case 1: // move					
					if (_paw.rotation <= -80)
					{
						_turnIndex = 1;
					}
					else if (_paw.rotation >= 80 || _turnIndex == 0)
					{
						_turnIndex = -1;
					}
					
					_paw.rotation += _turnIndex * TURN_SPEED;
					break;
				case 2: // checkHit
					_item = _ic.checkHit(_getterHitBall);
					if (_item)
					{
						_tween.pause();
						_getter.gotoAndPlay(1);
						_getterItem.visible = true;
						_getterItem.gotoAndStop(_item.currentFrame);
						_item.visible = false;
						_stats = 3;
					}
					
					break;
				case 3: // 抓取期間
					// 收子收起後才往上回去
					if (_getter.currentFrame == _getter.totalFrames)
					{
						revoke();
					}
					break;
				case 0: // 收回爪子的途中
					break;
			}
		}
		
		/**
		 * 收回爪子
		 */
		private function revoke():void
		{
			_stats = 0;
			_tween = TweenLite.to(_getter, _downTime, {y: 60, onComplete: onRevoke});
		}
		
		// 已收回爪子
		private function onRevoke():void
		{
			_stats = 1;
			_getter.gotoAndStop(1);
			
			if (_item)
			{
				// 判斷item的種類去加分
				switch (_item.currentFrame)
				{
					case 1: 
						_ui.addHeat(-300);
						break;
					case 2: 
						_ui.addHeat(-500);
						break;
					case 3: 
						_ui.addHeat(200);
						break;
					case 4: 
						_ui.addHeat(300);
						break;
					case 5: 
						_ui.addHeat(500);
						break;
					case 6: 
						var h:int = 0;
						do
						{
							h = Tools.randomInt(-5, 5) * 100;
						} while (h == 0);
						_ui.addHeat(h);
						break;
				}
				
				// 判斷是否把所有東西都抓完了
				if (_ic.isGetAllItem())
				{
					onTimeUp();
				}
				
				_item = null;
				_getterItem.visible = false;
			}
		}
		
		private function onTimeUp(e:CustomEvent = null):void
		{
			// 判斷分數是否落在區間
			GameData.KEY_ACTIVE = false;
			
			_ic.clear();
			this.removeEventListener(Event.ENTER_FRAME, onframe);
			_tutorial.pass(_ui.checkHeat());
			
			_stats = 1;
			resetGetter();
		}
	}
}
