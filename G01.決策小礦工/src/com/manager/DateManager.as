package com.manager
{
	
	/**
	 * ...
	 * @author yang
	 */
	public class DateManager
	{
		private var _date:Date;
		private var _startTime:String;
		private var _startDate:String;
		
		public function DateManager()
		{
		
		}
		
		public function init():void
		{
			_startTime = getCurrentTime();
			_startDate = getCurrentDate();
		}
		
		public function getCurrentDate():String
		{
			_date = new Date();
			return _date.getFullYear() + "-" + numberFormat(_date.getMonth() + 1) + "-" + numberFormat(_date.getDate());
		}
		
		public function getCurrentTime():String
		{
			_date = new Date();
			return numberFormat(_date.getHours()) + ":" + numberFormat(_date.getMinutes());
		}
		
		public function numberFormat(num:Number, len:int = 2):String
		{
			var numStr:String = num + "";
			var d:int = len - numStr.length;
			if (d > 0)
			{
				while (d--)
				{
					numStr = "0" + numStr;
				}
			}
			return numStr;
		}
		
		// ------------------------------------
		public function get startTime():String
		{
			return _startTime;
		}
		
		public function get startDate():String
		{
			return _startDate;
		}
		
		// ------------------------------------
		static private var _instance:DateManager;
		
		static public function getInstance():DateManager
		{
			_instance = _instance || new DateManager();
			return _instance;
		}
	}
}