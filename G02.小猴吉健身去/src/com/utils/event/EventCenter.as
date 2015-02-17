package com.utils.event {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class EventCenter
	{
		static private var _instanse:EventDispatcher = new EventDispatcher();
		
		static public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_instanse.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_instanse.removeEventListener(type, listener, useCapture);
		}
		
		static public function dispatchEvent(e:Event):Boolean 
		{
			return _instanse.dispatchEvent(e);
		}
	}
}