package com.manager
{
	import com.utils.CustomTimer;
	
	/**
	 * ...
	 * @author yang
	 */
	public class TimerManager
	{
		static private var _paused:Boolean;
		static private var _timerVec:Vector.<CustomTimer> = new Vector.<CustomTimer>();
		
		static public function delayedCall(delay:Number, onComplete:Function):void
		{
			_timerVec.push(new CustomTimer(delay, onComplete, removeTimer));
		}
		
		static private function removeTimer(timer:CustomTimer):void
		{
			_timerVec.splice(_timerVec.indexOf(timer), 1);
		}
		
		// --------------------------------------------
		
		static public function get paused():Boolean
		{
			return _paused;
		}
		
		static public function pause():void
		{
			_paused = true;
			for each (var timer:CustomTimer in _timerVec)
			{
				timer.pause();
			}
		}
		
		static public function resume():void
		{
			_paused = false;
			for each (var tween:CustomTimer in _timerVec)
			{
				tween.resume();
			}
		}
		
		static public function clear():void
		{
			for each (var timer:CustomTimer in _timerVec)
			{
				timer.stop();
			}
			_timerVec.length = 0;
			_paused = false;
		}
	}
}