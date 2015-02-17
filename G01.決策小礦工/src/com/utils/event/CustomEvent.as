package com.utils.event {
	import flash.events.Event;
	/**
	 * ...
	 * @author yang
	 */
	public class CustomEvent extends Event
	{
		// command
		static public const START:String = "START";
		static public const TIMEUP:String = "TIMEUP";
		static public const PREPARE:String = "PREPARE";
		
		public var data:Object;
		public function CustomEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}