package com.core
{
	import com.utils.event.CustomEvent;
	import com.utils.event.EventCenter;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author yang
	 */
	public class UI
	{
		private var _view:Sprite;
		private var _time:int;
		
		private var _levelTxt:TextField;
		private var _timelTxt:TextField;
		
		private var _txtObj:Object;
		private var _initObj:Object;
		private var _currentObj:Object;
		
		private var _timer:Timer;
		
		private var _life:Life;
		
		public function UI(displayer:Sprite)
		{
			_view = displayer;
			_view.mouseChildren = false;
			_view.mouseEnabled = false;
			
			_levelTxt = _view["levelTxt"];
			_timelTxt = _view["timelTxt"];
			
			_txtObj = {"1": _view["i1"], "2": _view["i2"], "3": _view["i3"], "4": _view["i4"], "5": _view["i5"]};
			_initObj = {};
			
			_life = new Life(_view["life"]);
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimeTick);
			EventCenter.addEventListener(CustomEvent.HIT, onHit);
		}
		
		public function init():void
		{
			setTime(25);
			_life.init();
			
			// 初始化每項 itme 的值為0;
			_currentObj = {};
			for (var i:int = 1; i <= 5; i++)
			{
				_currentObj[i] = 0;
				_initObj[i] = 0;
				_txtObj[i].text = "0/0";
			}
		}
		
		// -------------------------------------------------
		public function setTime(t:int):void
		{
			_time = t;
			_timelTxt.text = _time + "";
			_timer.reset();
		}
		
		public function startTime():void
		{
			_timer.start();
		}
		
		public function stopTime():void
		{
			_timer.stop();
		}
		
		private function onTimeTick(e:TimerEvent):void
		{
			_timelTxt.text = --_time + "";
			
			if (_time <= 0)
			{
				_timelTxt.text = "0";
				_timer.stop();
				EventCenter.dispatchEvent(new CustomEvent(CustomEvent.GAMEOVER));
			}
		}
		
		// -------------------------------------------------
		
		// 設定 item 的目標值
		public function setItemCount(i:int, n:int):void
		{
			_initObj[i] = n;
			_txtObj[i].text = "0/" + n;
		}
		
		// 增加 item 值
		public function addItemCount(i:int):void
		{
			_currentObj[i]++;
			_txtObj[i].text = _currentObj[i] + "/" + _initObj[i];
		}
		
		public function checkPass():Boolean
		{
			for (var i:int = 1; i <= 5; i++)
			{
				if (_initObj[i] > _currentObj[i])
				{
					return false;
				}
			}
			
			return true;
		}
		
		private function onHit(e:CustomEvent):void
		{
			var i:int = int(e.data);
			
			if (i <= 5)
			{
				addItemCount(i);
			}
			else
			{
				_life.life--;
				if (_life.life == 0)
				{
					EventCenter.dispatchEvent(new CustomEvent(CustomEvent.GAMEOVER, "die"));
				}
			}
		}
		
		// -------------------------------------------------
		
		public function show():void
		{
			_view.visible = true;
		}
		
		public function hide():void
		{
			_view.visible = false;
		}
		
		public function setTitle(d:int):void
		{
			_levelTxt.text = "" + ["一", "二", "三", "四", "五"][d - 1];
		}
	}
}