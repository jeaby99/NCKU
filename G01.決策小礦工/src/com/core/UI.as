package com.core
{
	import com.utils.event.CustomEvent;
	import com.utils.event.EventCenter;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
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
		private var _heatTxt:TextField;
		private var _targetTxt:TextField;
		
		private var _timer:Timer;
		
		private var _lowHeat:int;
		private var _highHeat:int;
		private var _currentHeat:int;
		
		public function UI(displayer:Sprite)
		{
			_view = displayer;
			_view.mouseChildren = false;
			_view.mouseEnabled = false;
			
			_levelTxt = _view["levelTxt"];
			_timelTxt = _view["timelTxt"];
			_heatTxt = _view["heatTxt"];
			_targetTxt = _view["targetTxt"];
					
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimeTick);
		}
		
		// -------------------------------------------------
		public function setParameters(time:int, lowHeat:int, highHeat:int, lv:int):void
		{
			_time = time;
			_timelTxt.text = _time + "";
			_timer.reset();
			
			_lowHeat = lowHeat;
			_highHeat = highHeat;
			_currentHeat = 0;
			
			if (highHeat == -1) 
			{
				_highHeat = _lowHeat;
				_targetTxt.text = _lowHeat + "";
			}
			else
			{
				_targetTxt.text = _lowHeat + "~" + _highHeat;
			}
			
			_heatTxt.text = "0";
			
			_levelTxt.text = "" + ["一", "二", "三", "四", "五"][lv - 1];
			_view.visible = true;
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
				EventCenter.dispatchEvent(new CustomEvent(CustomEvent.TIMEUP));
			}
		}
		
		public function addHeat(value:int):void
		{
			_currentHeat += value;
			_heatTxt.text = _currentHeat + "";
		}
		
		public function checkHeat():Boolean
		{
			return (_currentHeat >= _lowHeat) && (_currentHeat <= _highHeat);
		}
		
		// -------------------------------------------------
		public function hide():void
		{
			_view.visible = false;
		}
	}
}