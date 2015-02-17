package com.manager
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
	public class TimerManager
	{
		static public var NORMAL_TIME:int = 90;
		
		private var _view:Sprite;
		private var _gbar:Sprite;
		private var _timeTxt:TextField;
		private var _timer:Timer;
		private var _totalTime:int;
		private var _onTimeupHandler:Function;
		
		public function TimerManager(displayer:Sprite)
		{
			_view = displayer;
			_view.mouseChildren = false;
			_view.mouseEnabled = false;
			
			_timer = new Timer(1000);			
			_timer.addEventListener(TimerEvent.TIMER, onTimeTick);
			_timer.delay = 1000;
			
			_totalTime = NORMAL_TIME;
			_timeTxt = _view["timeTxt"];
			_timeTxt.text = _totalTime + "";
			
			_gbar = _view["gbar"];
		}
		
		public function start(onTimeHandler:Function):void
		{
			_timeTxt.text = _totalTime + "";
			_onTimeupHandler = onTimeHandler;
			
			_timer.start();
		}
		
		public function pause():void
		{
			_timer.stop();
		}
		
		// 正常 180 秒
		private function onTimeTick(e:TimerEvent):void
		{
			updateTF();
			updateGbar();
			EventCenter.dispatchEvent(new CustomEvent(CustomEvent.TIME_TICK));
			
			if (_totalTime == 0)
			{
				_timer.stop();
				_timer.removeEventListener(e.type, arguments.callee);
				_onTimeupHandler();
			}
		}
		
		private function updateTF():void
		{
			if (--_totalTime <= 0)
			{
				_timer.stop();
				_totalTime = 0;
			}
			
			_timeTxt.text = _totalTime + "";
		}
		
		private function updateGbar():void
		{
			_gbar.scaleX = _totalTime / NORMAL_TIME;
		}
		
		public function get currentTime():int
		{
			return _totalTime;
		}
	}
}