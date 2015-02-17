package com.core
{
	import com.utils.event.CustomEvent;
	import com.utils.event.EventCenter;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author yang
	 */
	public class Tutorial
	{
		
		static public const INIT:String = 'init';
		
		static public const DESC1:String = 'desc1';
		static public const DESC2:String = 'desc2';
		static public const DESC3:String = 'desc3';
		
		static public const DAY1:String = 'day1';
		static public const DAY2:String = 'day2';
		static public const DAY3:String = 'day3';
		static public const DAY4:String = 'day4';
		static public const DAY5:String = 'day5';
		
		static public const ALLPASS:String = 'allpass';
		static public const PASS:String = 'pass';
		static public const FAILD:String = 'faild';
		
		static public const GAME:String = 'game';
		
		private var _view:MovieClip;
		private var _step:String;
		private var _day:int;
		private var _dayObj:Object;
		
		public function Tutorial(displayer:MovieClip):void
		{
			_view = displayer;
			_view.stop();
			
			_dayObj = {1: DAY1, 2: DAY2, 3: DAY3, 4: DAY4, 5: DAY5};
		}
		
		public function init():void
		{
			_view.gotoAndStop(INIT);
			_view.visible = true;
			_step = INIT;
		}
		
		public function tutorialHandler():void
		{
			switch (_step)
			{				
				case Tutorial.GAME: 
					EventCenter.dispatchEvent(new CustomEvent(CustomEvent.START));
					break;
				
				case Tutorial.PASS: 
					_view.gotoAndStop(_step);
					_view["nextBtn"].addEventListener(MouseEvent.CLICK, onTutorialNext);
					_step = getNextDay(true);
					break;
				
				case Tutorial.INIT: 
					_view["startBtn"].addEventListener(MouseEvent.CLICK, onTutorialNext);
					_step = Tutorial.DESC1;
					break;
				case Tutorial.DESC1: 
					_view.gotoAndStop(_step);
					_view["nextBtn"].addEventListener(MouseEvent.CLICK, onTutorialNext);
					_step = Tutorial.DESC2;
					break;
				case Tutorial.DESC2: 
					_view.gotoAndStop(_step);
					_view["nextBtn"].addEventListener(MouseEvent.CLICK, onTutorialNext);
					_step = Tutorial.DESC3;
					break;
				case Tutorial.DESC3: 
					_view.gotoAndStop(_step);
					_view["nextBtn"].addEventListener(MouseEvent.CLICK, onTutorialNext);
					_step = Tutorial.DAY1;
					break;
				
				case Tutorial.DAY1: 
					dayHandler(_step, 1);
					break;
				case Tutorial.DAY2: 
					dayHandler(_step, 2);
					break;
				case Tutorial.DAY3: 
					dayHandler(_step, 3);
					break;
				case Tutorial.DAY4: 
					dayHandler(_step, 4);
					break;
				case Tutorial.DAY5: 
					dayHandler(_step, 5);
					break;
				
				case Tutorial.FAILD: 
					_view.gotoAndStop(_step);
					_view["nextBtn"].addEventListener(MouseEvent.CLICK, onTutorialNext);
					_step = getNextDay();
					break;
				
				case Tutorial.ALLPASS: 
					_view.gotoAndStop(_step);
					break;
			}
		}
		
		private function onTutorialNext(e:MouseEvent):void
		{
			e.currentTarget.removeEventListener(MouseEvent.CLICK, onTutorialNext);
			tutorialHandler();
		}
		
		public function show():void
		{
			_view.visible = true;
		}
		
		public function hide():void
		{
			_view.visible = false;
		}
		
		public function pass(isPass:Boolean = true):void
		{
			if (isPass)
			{
				_step = (++_day >= 6) ? Tutorial.ALLPASS : Tutorial.PASS;
			}
			else
			{
				_step = Tutorial.FAILD;
			}
			
			tutorialHandler();
		}
		
		private function dayHandler(step:String, day:int):void
		{
			_view.gotoAndStop(step);
			_view["startBtn"].addEventListener(MouseEvent.CLICK, onTutorialNext);
			_day = day;
			EventCenter.dispatchEvent(new CustomEvent(CustomEvent.PREPARE, _day));
			_step = Tutorial.GAME;
		}
		
		private function getNextDay(pass:Boolean = false):String
		{
			if (pass)
			{
				if (_day >= 6)
				{
					return ALLPASS;
				}
			}
			
			return _dayObj[_day];
		}
	}
}