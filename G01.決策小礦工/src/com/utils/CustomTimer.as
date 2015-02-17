package com.utils
{
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * 配合 TimerManager 使用
	 * @author yang
	 */
	
	public class CustomTimer
	{
		private var _timer:Timer;
		private var _completeFunc:Function;
		private var _removeTimer:Function;
		
		public function CustomTimer(delay:Number, completeFunc:Function, removeTimer:Function)
		{
			_completeFunc = completeFunc;
			_removeTimer = removeTimer;
			
			_timer = new Timer(delay * 1000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeup);
			_timer.start();
		}
		
		private function onTimeup(e:TimerEvent):void
		{			
			stop();
			_removeTimer(this);
			_completeFunc();
		}
		
		public function pause():void
		{
			_timer.stop();
		}
		
		public function resume():void
		{
			_timer.start();
		}
		
		public function stop():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimeup);
			_timer = null;
		}
	
	}
}